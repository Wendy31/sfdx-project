public with sharing class AccountProcessor {
    @future
    public static void CountContacts(List<Id> accountIds) {
        List<Account> accountList = new List<Account>();
        for (Id accId : accountIds) {
            Account acc = [SELECT Id FROM Account WHERE Id = :accId];
            acc.Number_of_Contacts__c = [SELECT COUNT() FROM Contact WHERE AccountId = :accId];
            accountList.add(acc);
        }

        update accountList;
    }
    public AccountProcessor() {
        List<Account> accList = [SELECT Id FROM Account];
        List<Id> accIds = new List<Id>();
        for (Account acc : accList) {
            accIds.add(acc.Id);
        }
        AccountProcessor.CountContacts(accIds);
    }
}
