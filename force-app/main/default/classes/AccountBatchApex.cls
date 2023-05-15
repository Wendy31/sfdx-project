global class AccountBatchApex implements Database.Batchable<sObject>, Database.Stateful {
    global Integer numberOfDirectCustomers = 0;

    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'select id, name, AccountNumber, Type from account';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Account> accList) {
        for (Account acc : accList) {
            if (acc.type.equals('Customer - Direct')) {
                numberOfDirectCustomers++;
            }
        }
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('account with type Customer - Direct: ' + numberOfDirectCustomers);
    }
}
