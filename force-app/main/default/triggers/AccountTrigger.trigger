// Automatically populate a lookup field on Account (child) from the Rival (parent) object
// Get the picklist values from Account
// Query Rival__c records and store in Map
// Populate lookup with the rival's ID

trigger AccountTrigger on Account(before insert, before update) {
    Set<String> accRivalPickListVals = new Set<String>();
    for (Account acc : Trigger.new) {
        if (acc.Rival_Picklist__c != null) {
            accRivalPickListVals.add(acc.Rival_Picklist__c);
        }
    }

    // Find the Rival record based on the picklist value
    Map<String, Rival__c> rivalsMap = new Map<String, Rival__c>();
    for (Rival__c rival : [SELECT Id, Name, Account__c FROM Rival__c WHERE Name IN :accRivalPickListVals]) {
        rivalsMap.put(rival.Name, rival);
    }

    // Rival__c is a lookup to the Rival custom object
    for (Account acc : Trigger.new) {
        acc.Rival__c = rivalsMap.get(acc.Rival_Picklist__c).Id;
    }
}
