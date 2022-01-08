public class AccountController {
    // create a method to update av_case_res_days on acc
    // total days/ total cases = avg res days
    
    public static void updateAvgCaseResolutionDays(List<ID> accountIds){
        // query all closed cases for the accounts passed in
        // loop thru cases to get number of cases, createdDate, closedDate
        // create two empty maps
        // use loop to build map
        // loop thru map to create new accounts and update Avg_Case_Resolution_Days__c field
        // store accounts in a list and mass update
        
        List<Case> cases = [SELECT Id, createdDate, closedDate, AccountId
                            FROM Case
                            WHERE isClosed = True AND AccountId IN :accountIds];
        
        Map<Id, Integer> accountCases = new Map<Id,Integer>();
        Map<Id, Integer> accountCasesResolutionDays = new Map<Id,Integer>();
        for(Case c : cases){
            // check if map has account, if not then add account to maps and populate value with 0
            if(!accountCases.containsKey(c.AccountId)){
                accountCases.put(c.AccountId, 0);
                accountCasesResolutionDays.put(c.AccountId, 0);
            }
            
            // calculate number of cases to repopulate map value
            Integer totalCases = accountCases.get(c.AccountId);
            totalCases++;
            accountCases.put(c.AccountId, totalCases);
            
            // calculate case resolution days (closedDate - createdDate) and repopulate map
            Integer totalResDays = accountCasesResolutionDays.get(c.AccountId);
            totalResDays += c.CreatedDate.date().daysBetween(c.ClosedDate.date());
            accountCasesResolutionDays.put(c.AccountId, totalResDays); 
        }
        
        // list of account to be updated
        List<Account> accountsToBeUpdated = new List<Account>();
        
        // loop thru map
        for(Id accountId : accountCases.keySet()){ // can not loop thru accountIds passed in since not all IDs added to map if they don't have any cases. Therefore map will return null to some accountId key
            
            // calculate avg resolution days of all cases for the acc (total days/ total cases)
            Decimal avResDays = accountCasesResolutionDays.get(accountId)/ accountCases.get(accountId);
            Account acc = new Account();
            acc.id = accountId;
            acc.Avg_Case_Resolution_Days__c = avResDays;
            accountsToBeUpdated.add(acc);
        }
        update accountsToBeUpdated;   
    }  
}