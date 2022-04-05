({
    fetchResult: function (component) {
        // method to call APEX method to get result from backend
        const action = component.get("c.getResult");
        action.setCallback(this, function (response) {
            const state = response.getState();
            if (state === "SUCCESS") {
                // if successful, then get returnValue i.e. list of results from APEX
                const resp = response.getReturnValue();
                // set resp (results) to data attribute in CMP
                component.set("v.data", resp);
            }
        });
        // call apex method (action). Action is added to a queue 
        $A.enqueueAction(action);
    }


})