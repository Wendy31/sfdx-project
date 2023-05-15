global class BatchApexExample implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'select id, name from account';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Account> accList) {
        for (Account acc : accList) {
            acc.Name = acc.Name + ' MYTUTORIALRANK';
        }

        try {
            update accList;
        } catch (Exception e) {
            System.debug(e);
        }
    }

    global void finish(Database.BatchableContext BC) {
    }
}
