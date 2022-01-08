public class OpportunityController {
    public static void updateOppProfile(List<id> oppIds){
        List<Opportunity> oppRecords = [SELECT id, name, amount, profile__c
                                        FROM Opportunity 
                                        WHERE id IN :oppIds];
        
        for(Opportunity opp : oppRecords){
            if(opp.amount != null){
                if(opp.amount < 10000){
                    opp.profile__c = 'Low';
                } else if(opp.amount > 10000 && opp.amount < 50000){
                    opp.profile__c = 'Medium';
                } else {
                    opp.profile__c = 'High';
                }
            } else {
                opp.profile__c  = '';
            }
        }
        update oppRecords;
    }  
}