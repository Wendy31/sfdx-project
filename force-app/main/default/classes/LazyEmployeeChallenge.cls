// This lazy dude wrote code to auto-accept and close all cases!
trigger LazyEmployee on Case(before insert) {
    List<Case> newCases = new List<Case>();
    for (Case a : Trigger.new) {
        a.Status = 'Closed';
        a.Owner = 'David Liu';
        newCases.add(a);
    }
    insert newCases;
    // complete 2moro
}
