trigger ContactTrigger on Contact (after insert, after update, after delete) {
     // use switch statement to switch between events
     switch on Trigger.OperationType {
         when  AFTER_INSERT{
            // loop thru trigger.new for each contact
            
            Set<Id> accIds = new Set<Id>();                               
            for (Contact con : trigger.new) {
                accIds.add(con.AccountId); 
            }
            // Get the count of active contacts where their parent accounts are found in trigger.new
            List<AggregateResult> results = [SELECT Active__c, AccountId, COUNT(ID) totalCount
                                            FROM Contact 
                                            WHERE Active__c = true
                                            AND AccountId IN :accIds
                                            GROUP BY Active__c, AccountId];
            // if field active__c is not blank then do logic
            // use aggregate query to count the number of contacts where active__c = true

            // loop thru queryList
            List<Account> accountsToUpdate = new List<Account>();
            for (AggregateResult result : results) {
                // get the accountId and totalCount
                String accountId = (String)result.get('AccountId');
                Integer totalActiveContacts = (Integer)result.get('totalCount');
                // create new account instance and populate fields? Not query existing account?
                Account accToUpdate = new Account(Id = accountId, Active_Contacts__c = totalActiveContacts);
                accountsToUpdate.add(accToUpdate);  
            }
            // update account 
            update accountsToUpdate;  
         }
         when AFTER_UPDATE {
             
        }
        when AFTER_DELETE {
             
        }
    }
}