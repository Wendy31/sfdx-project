// Automatically populate a lookup field to the Rival object
trigger GetRival on Account(before insert, before update) {
    List<Account> accRivals = new List<Account>();
    for (Account acc : Trigger.new) {
        if (acc.Rival_Picklist__c != null) {
            accRivals.add(acc.Rival_Picklist__c);
        }

        // Find the Rival record based on the picklist value
        Map<Id, Rival__c> rivalsMap = new Map<Id, Rival__c>([SELECT Id, Name, AccountId FROM Rival__c WHERE Name IN :accRivals]);

        // Rival__c is a lookup to the Rival custom object
        for (Account acc : Trigger.new) {
            acc.Rival__c = rivalsMap.get(acc.Id).Name;
        }
    }
}
