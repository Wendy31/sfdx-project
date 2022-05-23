// Automatically populate a lookup field to the Rival object
trigger GetRival on Account(after insert, after update) {
    List<Account> accRivals = new List<Account>();
    for (Account acc : Trigger.new) {
        if (acc.Rival_Picklist__c != null) {
            accRivals.add(acc.Rival_Picklist__c);
        }

        // Find the Rival record based on the picklist value
        List<Rival__c> rivals = [SELECT Id, Name, AccountId FROM Rival__c WHERE Name IN :accRivals];

        // Rival__c is a lookup to the Rival custom object
        acc.Rival__c = comp.Name;
    }
}
