public class ContactTriggerHandler {
    public static void afterInsertHandler(List<Contact> newContacts){
        Set<Id> accIds = new Set<Id>();                               
            for (Contact con : newContacts) {
                if (String.isNotBlank(con.AccountId)) {
                    accIds.add(con.AccountId); 
                }  
            }
            AccountContactService.updateActiveContactsField(accIds);
         }   
    

    public static void afterUpdateHandler(List<Contact> newContacts, Map<Id,Contact> oldContactsMap){
        Set<Id> accIds = new Set<Id>();                               
        for (Contact con : newContacts) {
            // capture account Id if contact active checkbox value has updated 
            if (String.isNotBlank(con.AccountId) && oldContactsMap.get(con.Id).Active__c != con.Active__c) {
                accIds.add(con.AccountId); 
               // capture both accounts if contact has updated its parent account to run logic on both the new account and old account 
            }  else if (oldContactsMap.get(con.Id).AccountId != con.AccountId) {
                accIds.add(con.AccountId); 
                accIds.add(oldContactsMap.get(con.Id).AccountId);   
            } 
        }
        AccountContactService.updateActiveContactsField(accIds);
    }

    public static void afterDeleteHandler(List<Contact> oldContacts){ // only old records available since they are already deleted
        Set<Id> accIds = new Set<Id>();                               
            for (Contact con : oldContacts) {
                if (String.isNotBlank(con.AccountId)) {
                    accIds.add(con.AccountId); 
                }  
            }
            AccountContactService.updateActiveContactsField(accIds);
         }   

    public static void afterUndeleteHandler(List<Contact> newContacts){
        Set<Id> accIds = new Set<Id>();                               
            for (Contact con : newContacts) {
                if (String.isNotBlank(con.AccountId)) { // after undelete no need to check if checkbox has been changed. it retores original state first. any update will call update method above.
                    accIds.add(con.AccountId);  
                }  
            }
            AccountContactService.updateActiveContactsField(accIds);
        }   

}