trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {
     // use switch statement to switch between events
     switch on Trigger.OperationType {
        when  AFTER_INSERT{
            ContactTriggerHandler.afterInsertHandler(trigger.new); 
         }
        when AFTER_UPDATE {
            ContactTriggerHandler.afterUpdateHandler(trigger.new, trigger.oldMap); 
        }
        when AFTER_DELETE {
            ContactTriggerHandler.afterDeleteHandler(trigger.old); 
        }
        when AFTER_UNDELETE {
            ContactTriggerHandler.afterUndeleteHandler(trigger.new); 
        }
    }
}