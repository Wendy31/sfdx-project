// Automatically create a Renewal Opp for closed won deals
trigger OpportunityTrigger on Opportunity(before update) {
    // Create a list to store all renewal opps for bulk inserting
    List<Opportunity> renewals = new List<Opportunity>();

    for (Opportunity opp : Trigger.new) {
        /*  // get old opp 
        // store in boolean to check if record changed AND also to a specific value
        Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
        Boolean oldOppIsClosedWon = oldOpp.StageName.contains('Closed Won');
        Boolean newOppIsClosedWon = opp.StageName.contains('Closed Won'); 
	*/

        // Only create renewal opps for closed won deals
        // if opp is Closed Won && old value was not closed, then there was a change i.e. from prospecting to Closed Won
        if (opp.IsClosed && opp.IsWon && Trigger.oldMap.get(opp.Id).IsClosed == false) {
            Opportunity renewal = new Opportunity();
            renewal.AccountId = opp.AccountId;
            renewal.Name = opp.Name + ' Renewal';
            renewal.CloseDate = opp.CloseDate.addDays(365); // Add a year
            renewal.StageName = 'Open';
            renewal.RecordTypeId = '0121i000000GqSiAAK';
            renewal.OwnerId = opp.OwnerId;
            renewals.add(renewal);
        }
    }
    // Bulk insert all renewals to avoid Governor Limits
    // DML on before trigger for records not found in Trigger.New i.e. new renewal Opps on Opp
    insert renewals;
}
