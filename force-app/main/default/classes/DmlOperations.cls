public class DmlOperations{
    // create new account with name 'Wing Nut Films' and Rating 'Warm'
    // create new opp 'Lord of the Rings' for this account with below fields:
    // - stage > qualification
    // - closed date > today
    // update account name to 'New Line Cinema'
    // update opp stage to 'closed-won'
    // delete opp
    // undelete opp
    // then repeat above using generic sObject type
    
    public static void DmlWithSpecifiedObject(){
        // create new account
        Account acc = new Account(Name='Wing Nut Films', Rating='Warm');
        insert acc;
        
        // create new opp
        Opportunity opp = new Opportunity(AccountId = acc.Id, Name='Lord Of The Rings', StageName='Qualification', CloseDate= date.today()); 
        insert opp;
        
        // update account name
        List<Account> accList = [SELECT id, name FROM account where name = 'Wing Nut Films'];
        for(Account account : accList){
            acc.name = 'New Line Cinema';
        }
        update accList;
        
        // update opp stageName
        List<Opportunity> OppList = [SELECT id, name, stagename FROM Opportunity WHERE name = 'Lord Of The Rings'];
        for(Opportunity oppty : OppList){
            oppty.stagename = 'Closed-Won';
        }
        update OppList;
        
        // delete opp
        List<Opportunity> OppToDelete = [SELECT id, name, stagename FROM Opportunity WHERE name = 'Lord Of The Rings'];
        delete OppToDelete;
        
        // undelete opp
        List<SObject> OppToUndelete = [SELECT id, name, stagename FROM Opportunity WHERE name = 'Lord Of The Rings' AND isDeleted = true ALL ROWS];
        undelete OppToUndelete;   
    } 
    
    public static void DmlWithSObject(){
        
        // insert account record with SObject
        SObject acc = (SObject) Type.forName('Account').newInstance(); 
        acc.put('Name', 'SObject2 Wing Nut Films');
        acc.put('Rating', 'Warm');
        insert acc;
        
        // insert opportunity record with SObject
        SObject newAcc = database.query('SELECT Id FROM account Name = \'SObject2 Wing Nut Films\' LIMIT 1');
        SObject opp = (SObject) Type.forName('Opportunity').newInstance();
        opp.put('AccountId', newAcc.id);
        opp.put('Name', 'SObject2 Lord Of The Rings');
        opp.put('StageName', 'Qualification');
        opp.put('CloseDate', date.today());
        insert opp;
        
        // update account name
        SObject accUpdate = database.query('SELECT id, name FROM account where name = \'SObject2 Wing Nut Films\' LIMIT 1');
        accUpdate.put('Name', 'New Line Cinema');
        update accUpdate;
        
        // update opp stageName
        SObject OppUpdate = database.query('SELECT id, name, stagename FROM Opportunity WHERE name = \'SObject2 Lord Of The Rings\' LIMIT 1');
        OppUpdate.put('StageName','Closed-Won');
        update OppUpdate;
        
        // delete opp
        SObject OppToDelete = database.query('SELECT id, name, stagename FROM Opportunity WHERE name = \'SObject2 Lord Of The Rings\' LIMIT 1');
        delete OppToDelete;
        
        // undelete opp
        List<SObject> OppToUndelete = database.query('SELECT id, name, stagename FROM Opportunity WHERE name = \'SObject2 Lord Of The Rings\' AND isDeleted = true ALL ROWS');
        undelete OppToUndelete;    
    }    
}