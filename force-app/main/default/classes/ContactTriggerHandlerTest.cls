@isTest
public with sharing class ContactTriggerHandlerTest {
    @TestSetup
    public static void makeData(){
        List<Account> accounts = new List<Account>();
        Account acc1 = new Account(Name = 'TestAccount1');
        Account acc2 = new Account(Name = 'TestAccount2');
        accounts.add(acc1);
        accounts.add(acc2);
        insert accounts;

        List<Contact> contacts = new List<Contact>();
        contacts.add(new Contact(AccountId = accounts[0].Id, LastName = 'Test Contact 1', Active__c = true));
        contacts.add(new Contact(AccountId = accounts[0].Id, LastName = 'Test Contact 2', Active__c = true));
        contacts.add(new Contact(AccountId = accounts[0].Id, LastName = 'Test Contact 3'));
        contacts.add(new Contact(AccountId = accounts[0].Id, LastName = 'Test Contact 4'));
        contacts.add(new Contact(AccountId = accounts[0].Id, LastName = 'Test Contact 5'));
        insert contacts;
    } 

    @isTest
    public static void afterInsertHandlerTest2() {
        // method to check accounts with and without active contacts
        List<Account> exisitingAccounts = [SELECT Id, Name, Active_Contacts__c
                                            FROM Account];
        
        // check total accounts
        System.assertEquals(2, exisitingAccounts.size());
        
        // check active contacts per account
        for (Account acc : exisitingAccounts) {
            if (acc.Name == 'TestAccount1') {
                System.assertEquals(2, acc.Active_Contacts__c);
            } 
            if (acc.Name == 'TestAccount2') {
                System.assertEquals(null, acc.Active_Contacts__c);
            } 
        }

        // check total contacts
        List<Contact> existingContacts = [SELECT Id FROM Contact];
        System.assertEquals(5, existingContacts.size());

    }

    @isTest
    public static void afterInsertHandlerTestBulk() {
        // method to check bulk insert of contact records

        Account testAcc = [SELECT Id FROM Account WHERE Name = 'TestAccount1'];
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 1000; i++) {
            contacts.add(new Contact(AccountId = testAcc.Id, LastName = 'TestCon '+i, Active__c = true));
        }
        
        Test.startTest();
        insert contacts;
        Test.stopTest();

        List<Account> exisitingAccounts = [SELECT Id, Account.Name, Active_Contacts__c
                                            FROM Account];

         // check accounts
         System.assertEquals(2, exisitingAccounts.size());
         
         for (Account acc : exisitingAccounts) {
             if (acc.Name == 'TestAccount1') {
                 System.assertEquals(1002, acc.Active_Contacts__c);
             } 
             if (acc.Name == 'TestAccount2') {
                 System.assertEquals(null, acc.Active_Contacts__c);
             } 
         }
 
         // check contacts
         List<Contact> existingContacts = [SELECT Id FROM Contact];
         System.assertEquals(1005, existingContacts.size());
    }

    @isTest
    public static void afterUpdateHandlerTest1() {
        // method to update contact active field

        List<Contact> existingContacts = [SELECT Id, LastName, Active__c FROM Contact];
        for (Contact con : existingContacts) {
            if (con.LastName == 'Test Contact 3' || con.LastName == 'Test Contact 4') {
                con.Active__c = true;
            } 
        }
        Test.startTest();
        update existingContacts;
        Test.stopTest();

        List<Account> exisitingAccounts = [SELECT Id, Name, Active_Contacts__c
                                            FROM Account];
        
        // check accounts
        System.assertEquals(2, exisitingAccounts.size());
         
        for (Account acc : exisitingAccounts) {
            if (acc.Name == 'TestAccount1') {
                System.assertEquals(4, acc.Active_Contacts__c);
            } 
            if (acc.Name == 'TestAccount2') {
                System.assertEquals(null, acc.Active_Contacts__c);
            } 
        }

        // check contacts
        System.assertEquals(5, existingContacts.size());
    }

    @isTest
    public static void afterUpdateHandlerTest2() {
        // re-parenting: AccountId changes on Contact
        Account testAcc = [SELECT Id FROM Account WHERE Name = 'TestAccount2'];
        List<Contact> existingContacts = [SELECT Id, LastName, Active__c FROM Contact];
        for (Contact con : existingContacts) {
            if (con.LastName == 'Test Contact 3') {
                con.Active__c = true;
                con.AccountId = testAcc.Id;
            }
            
        }
        Test.startTest();
        update existingContacts;
        Test.stopTest();

        List<Account> exisitingAccounts = [SELECT Id, Name, Active_Contacts__c
                                            FROM Account];
        
        // check accounts
        System.assertEquals(2, exisitingAccounts.size());
         
        for (Account acc : exisitingAccounts) {
            if (acc.Name == 'TestAccount1') {
                System.assertEquals(2, acc.Active_Contacts__c);
            } 
            if (acc.Name == 'TestAccount2') {
                System.assertEquals(1, acc.Active_Contacts__c);
            } 
        }
        // check contacts
        System.assertEquals(5, existingContacts.size());
    }

    @isTest
    public static void afterDeleteHandlerTest() {
        // re-parenting: AccountId changes on Contact
        List <Contact> contactsToDelete = [SELECT Id FROM Contact WHERE Name IN ('Test Contact 1','Test Contact 5')];
        
        Test.startTest();
        Delete contactsToDelete;
        Test.stopTest();

        List <Contact> existingContacts = [SELECT Id FROM Contact];

        List<Account> exisitingAccounts = [SELECT Id, Name, Active_Contacts__c
                                            FROM Account];
        
        // check accounts
        System.assertEquals(2, exisitingAccounts.size());
         
        for (Account acc : exisitingAccounts) {
            if (acc.Name == 'TestAccount1') {
                System.assertEquals(1, acc.Active_Contacts__c);
            } 
            if (acc.Name == 'TestAccount2') {
                System.assertEquals(null, acc.Active_Contacts__c);
            } 
        }
        // check contacts
        System.assertEquals(3, existingContacts.size());
    }

    @isTest
    public static void afterUndeleteHandlerTest() {
        // re-parenting: AccountId changes on Contact
        List <Contact> contactsToDelete = [SELECT Id FROM Contact WHERE Name IN ('Test Contact 1','Test Contact 5')];
        delete contactsToDelete;

        Test.startTest();
        undelete contactsToDelete;
        Test.stopTest();

        List <Contact> existingContacts = [SELECT Id FROM Contact];

        List<Account> exisitingAccounts = [SELECT Id, Name, Active_Contacts__c
                                            FROM Account];
        
        // check accounts
        System.assertEquals(2, exisitingAccounts.size());
         
        for (Account acc : exisitingAccounts) {
            if (acc.Name == 'TestAccount1') {
                System.assertEquals(2, acc.Active_Contacts__c);
            } 
            if (acc.Name == 'TestAccount2') {
                System.assertEquals(null, acc.Active_Contacts__c);
            } 
        }
        // check contacts
        System.assertEquals(5, existingContacts.size());
    }
}
