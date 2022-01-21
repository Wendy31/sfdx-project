trigger ContactTrigger on Contact (after insert, after update) {
     // contact has field Active__c
    // account has field Active_Contacts__c
    // create trigger to show total child contacts on account 
    // must work with bulk operations
    
    // create Map<AccId, set<Contacts>>
    Map<Id,List<Contact>> mapOfExisitingRecs = new Map<Id,List<Contact>>();
    
    // loop thru trigger.new and get accountIds
    Set<Id> accIds = new Set<Id>();
    for(Contact con : trigger.new){
        if(con.Active__c == true){
            accIds.add(con.AccountId);
        }
    }
    // use accountIDs to get all related contacts
    List<Contact> existingContacts = [SELECT Id, Name, AccountId, Active__c
                                      FROM Contact
                                      WHERE AccountId IN :accIds];
    
    //Integer totalContacts;
    
    // loop thru contact list of existing records to build Map
    // for each contact, get the accountID and add to map and create new set
    // get the accountID from Map and get all related contacts and add to map set
    for(Contact con : existingContacts){
        if(!mapOfExisitingRecs.containsKey(con.AccountId)){
            mapOfExisitingRecs.put(con.AccountId, new List<Contact>());  
        }
        mapOfExisitingRecs.get(con.AccountId).add(con);
        //totalContacts = mapOfExisitingRecs.get(con.AccountId).size();
    }
    
    List<Account> accountsToUpdate = new List<Account>();
    List<Account> existingAccs = [SELECT Id, Active_contacts__c
                                  FROM Account
                                  WHERE Id IN :accIds];
    
    // for each account update active_contacts with total count
    for(Account acc : existingAccs){
        if(mapOfExisitingRecs.containsKey(acc.Id) && mapOfExisitingRecs.values()){
            acc.active_contacts__c ++;
            //= (Integer)totalContacts;
        } else {
            acc.active_contacts__c --;  
        }
        accountsToUpdate.add(acc);
    }
    update accountsToUpdate;
}