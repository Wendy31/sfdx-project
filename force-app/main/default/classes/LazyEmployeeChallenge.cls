// This lazy dude wrote code to auto-accept and close all cases!
trigger LazyEmployee on Case(before insert) {
    // no need new list since it's a before trigger
    for (Case newCase : Trigger.new) {
        newCase.Status = 'Closed';
        newCase.OwnerId = 'D0050E000004vXORQA2';
    }
}
