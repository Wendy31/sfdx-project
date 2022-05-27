trigger CaseTrigger on Case(before insert, before update) {
    // TASK: create trigger to prevent users from creating more than 99 cases a month
    // 1. get all ownerIds from Trigger.New and store in set
    // 2. query the count of cases and group by OwnerId of all cases created in the last month
    // 3. store result in Map <String,Integer>
    // 4. if ownerId > 99, then add error message

    Set<Id> caseOwners = new Set<Id>();
    for (Case c : Trigger.New) {
        caseOwners.add(c.OwnerId);
    }

    Map<String, Integer> caseOwnerMap = new Map<String, Integer>();
    for (AggregateResult[] groupedResult : [
        SELECT COUNT(ID) totalCases, OwnerId ownerId
        FROM Case
        WHERE CreatedDate = LAST_MONTH AND OwnerId IN :caseOwners
        GROUP BY OwnerId
    ]) {
        caseOwnerMap.put(String(groupedResult.get('ownerId')), Integer(groupedResult.get('totalCases')));
    }

    for (Case c : Trigger.New) {
        if (caseOwnerMap.get(c.OwnerId) > 2) {
            c.addError('This Owner has more than 2 Cases created in the last month!');
        }
    }
}
