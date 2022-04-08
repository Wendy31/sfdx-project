public with sharing class BoardPanelController {
    @AuraEnabled
    public static String addResult(String mode, String result) {
        // create instance of Word Shuffle and add new record with mode and result
        Word_Shuffle__c gameResult = new Word_Shuffle__c(Result__c = result, Mode__c = mode);
        // insert record
        insert gameResult;
        // return string
        return 'Result saved';
    }
}
