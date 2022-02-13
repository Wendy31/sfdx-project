@isTest
public with sharing class ContactTriggerHandlerTest {
   /* @isTestData
    public static void createTestData(){

    } */

    @isTest
    public static void afterInsertHandlerTest() {
        // create two accounts
        // create related contacts: active and non active

        List<Account> accounts = new List<Account>();
        Account acc1 = new Account(Name = 'TestAccount1');
        Account acc2 = new Account(Name = 'TestAccount2');
        accounts.add(acc1);
        accounts.add(acc2);
        insert accounts;

        List<Contact> contacts = new List<Contact>();
        Contact con1 = new Contact(AccountId = acc1.Id, LastName = 'Abc', Active__c = True);
        Contact con2 = new Contact(AccountId = acc1.Id, LastName = 'Abcd', Active__c = True);
        Contact con3 = new Contact(AccountId = acc1.Id, LastName = 'Abcde');
        Contact con4 = new Contact(AccountId = acc2.Id, LastName = 'Wxyz');
        Contact con5 = new Contact(AccountId = acc2.Id, LastName = 'Xyz');
        contacts.add(con1);
        contacts.add(con2);
        contacts.add(con3);
        contacts.add(con4);
        contacts.add(con5);
        insert contacts;

        List<Account> exisitingAccounts = [SELECT Id, Active_Contacts__c
                                            FROM Account];

        // check contacts list size per account
        for (Contact con : contacts) {
            if (con.Account.Name == 'TestAccount1') {
                System.assertEquals(3, contacts.size());
            } 

            if (con.Account.Name == 'TestAccount2') {
                System.assertEquals(2, contacts.size());
            } 
            
        }
        // check account list size
        System.assertEquals(2, accounts.size());
        System.assertEquals(2, accounts[0].Active_Contacts__c);
        System.assertEquals(null, accounts[1].Active_Contacts__c);
    }

    @isTest
    public static void afterUpdateHandlerTest(){
        List<Account> accounts = new List<Account>();
        Account acc1 = new Account(Name = 'TestAccount1');
        Account acc2 = new Account(Name = 'TestAccount2');
        accounts.add(acc1);
        accounts.add(acc2);
        insert accounts;

        List<Contact> contacts = new List<Contact>();
        Contact con1 = new Contact(AccountId = acc1.Id, LastName = 'Abc', Active__c = True);
        Contact con2 = new Contact(AccountId = acc1.Id, LastName = 'Abcd', Active__c = True);
        Contact con3 = new Contact(AccountId = acc1.Id, LastName = 'Abcde');
        Contact con4 = new Contact(AccountId = acc2.Id, LastName = 'Wxyz');
        Contact con5 = new Contact(AccountId = acc2.Id, LastName = 'Xyz');
        contacts.add(con1);
        contacts.add(con2);
        contacts.add(con3);
        contacts.add(con4);
        contacts.add(con5);
        insert contacts;

        List<Contact> existingContacts = [SELECT Id, Active__c, LastName, Account.Name
                                            FROM Contact];
        
        for (Contact con : existingContacts) {
            if (con.Account.Name == 'TestAccount1' && con.LastName == 'Abcde') {
                con.Active__c = true;
            }
            update con;
        } 
        // check accounts' number of active contacts
        System.assertEquals(3, accounts[0].Active_Contacts__c);
        System.assertEquals(null, accounts[1].Active_Contacts__c);

    }

    @isTest
    public static void afterDeleteHandlerTest(){
        List<Account> accounts = new List<Account>();
        Account acc1 = new Account(Name = 'TestAccount1');
        Account acc2 = new Account(Name = 'TestAccount2');
        accounts.add(acc1);
        accounts.add(acc2);
        insert accounts;

        List<Contact> contacts = new List<Contact>();
        Contact con1 = new Contact(AccountId = acc1.Id, LastName = 'Abc', Active__c = True);
        Contact con2 = new Contact(AccountId = acc1.Id, LastName = 'Abcd', Active__c = True);
        Contact con3 = new Contact(AccountId = acc1.Id, LastName = 'Abcde');
        Contact con4 = new Contact(AccountId = acc2.Id, LastName = 'Wxyz');
        Contact con5 = new Contact(AccountId = acc2.Id, LastName = 'Xyz');
        contacts.add(con1);
        contacts.add(con2);
        contacts.add(con3);
        contacts.add(con4);
        contacts.add(con5);
        insert contacts;
        
        List<Contact> existingCons = [SELECT Id, LastName 
                                    FROM Contact
                                    WHERE LastName = 'Abc'];

        delete existingCons;                     

        // check accounts' number of active contacts
        System.assertEquals(2, accounts[0].Active_Contacts__c);
        System.assertEquals(null, accounts[1].Active_Contacts__c);

    }

    
    @isTest
    public static void afterUndeleteHandlerTest(){
        List<Account> accounts = new List<Account>();
        Account acc1 = new Account(Name = 'TestAccount1');
        Account acc2 = new Account(Name = 'TestAccount2');
        accounts.add(acc1);
        accounts.add(acc2);
        insert accounts;

        List<Contact> contacts = new List<Contact>();
        Contact con1 = new Contact(AccountId = acc1.Id, LastName = 'Abc', Active__c = True);
        Contact con2 = new Contact(AccountId = acc1.Id, LastName = 'Abcd', Active__c = True);
        Contact con3 = new Contact(AccountId = acc1.Id, LastName = 'Abcde');
        Contact con4 = new Contact(AccountId = acc2.Id, LastName = 'Wxyz');
        Contact con5 = new Contact(AccountId = acc2.Id, LastName = 'Xyz');
        contacts.add(con1);
        contacts.add(con2);
        contacts.add(con3);
        contacts.add(con4);
        contacts.add(con5);
        insert contacts;
        
        List<Contact> existingCons = [SELECT Id, LastName 
                                    FROM Contact
                                    WHERE LastName = 'Abc'];

        delete existingCons;  
        
        undelete existingCons;

        // check accounts' number of active contacts
        System.assertEquals(3, accounts[0].Active_Contacts__c);
        System.assertEquals(null, accounts[1].Active_Contacts__c);
    }


}
