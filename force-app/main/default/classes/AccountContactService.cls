public with sharing class AccountContactService {
    public static void updateActiveContactsField(Set<Id> accIds) {
        // Get the count of active contacts where their parent accounts are found in trigger.new
            // use aggregate query to count the number of contacts where active__c = true
            List<AggregateResult> results = [SELECT AccountId, COUNT(ID) totalContacts
                                            FROM Contact 
                                            WHERE Active__c = true
                                            AND AccountId IN :accIds
                                            GROUP BY AccountId];

            // loop thru queryList
            List<Account> accountsToUpdate = new List<Account>();
            for (AggregateResult result : results) {
                // get the accountId and totalContacts
                String accountId = (String)result.get('AccountId');
                Integer totalActiveContacts = (Integer)result.get('totalContacts');
                // create new account instance and populate fields
                Account accToUpdate = new Account(Id = accountId, Active_Contacts__c = totalActiveContacts);
                accountsToUpdate.add(accToUpdate);  
            }
            // update account 
            update accountsToUpdate;  
    }
}
