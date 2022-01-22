public with sharing class AccountContactService {
    // called AccountContactService since this piece of code is updating the parent Account (servicing the account)
    public static void updateActiveContactsField(Set<Id> accIds) {
        // Get the count of active contacts where their parent accounts are found in trigger.new
        // use aggregate query to count the number of contacts where active__c = true
        List<AggregateResult> results = [SELECT AccountId, COUNT(ID) totalContacts
                                        FROM Contact 
                                        WHERE Active__c = true
                                        AND AccountId IN :accIds
                                        GROUP BY AccountId];

        // this loop adds all contacts with active = true to map and sets field with aggregated count
        Map<Id,Account> accountsToUpdateMap = new Map<Id,Account>();
        for (AggregateResult result : results) {
            // get the accountId and totalContacts
            String accountId = (String)result.get('AccountId');
            Integer totalActiveContacts = (Integer)result.get('totalContacts');
            // create new account instance and populate fields
            Account accToUpdate = new Account(Id = accountId, Active_Contacts__c = totalActiveContacts);
            accountsToUpdateMap.put(accountId, accToUpdate);  
        }

        // this loop adds contacts without active = true to map and sets field to 0
        for (Id accId : accIds) {
            if(!accountsToUpdateMap.containsKey(accId)){
                accountsToUpdateMap.put(accId, new Account(Id = accountId, Active_Contacts__c = 0)); 
            }
        }
        // update values of map (not the map itself)
        update accountsToUpdateMap.values();  
    }
}
