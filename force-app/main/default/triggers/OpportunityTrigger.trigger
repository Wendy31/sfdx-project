// Automatically create a Renewal Opp for closed won deals
trigger OpportunityTrigger on Opportunity(before update) {
    // Create a Map to store all renewal opps for bulk inserting
    // List<Opportunity> renewals = new List<Opportunity>();

    for (Opportunity opp : Trigger.new) {
        // get old opp
        Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
        Boolean oldOppIsClosedWon = oldOpp.StageName.contains('Closed Won');
        Boolean newOppIsClosedWon = opp.StageName.contains('Closed Won');

        // Only create renewal opps for closed won deals
        if (!oldOppIsClosedWon && newOppIsClosedWon) {
            Opportunity renewal = new Opportunity();
            renewal.AccountId = opp.AccountId;
            renewal.Name = opp.Name + ' Renewal';
            renewal.CloseDate = opp.CloseDate + 365; // Add a year
            renewal.StageName = 'Open';
            renewal.RecordTypeId = '0121i000000GqSiAAK';
            renewal.OwnerId = opp.OwnerId;
            renewals.add(renewal);
        }
    }
    // Bulk insert all renewals to avoid Governor Limits
    // insert renewals.values();
}
