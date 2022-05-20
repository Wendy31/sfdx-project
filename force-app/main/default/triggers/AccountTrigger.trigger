// Automatically populate a lookup field to the Rival object
trigger GetRival on Account (after insert, after update) {
    // Find the Rival record based on the picklist value
   List<Rival__c> comp = [SELECT Id, Name
                            FROM Rival__c
                            WHERE Name = acc.Rival_Picklist__c];

    List<Rival__c> rivals = new List<Rival__c>();
    for (Account acc : Trigger.old) {
  
      // Rival__c is a lookup to the Rival custom object fgadf
      acc.Rival__c  = comp.Name; 
    }
  }