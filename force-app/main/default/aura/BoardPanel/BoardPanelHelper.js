({
    addResultRecord: function (component, gameResult) {
        // method to call server side action (apex method)
        // get apex method
        const action = component.get("c.addResult");
        // get mode from component
        const gameMode = component.get("v.selectedMode").toUpperCase();
        // set method params in JSON format
        action.setParams({
            result: gameResult.toUpperCase(),
            mode: gameMode
        });
        // set call back that executes after server-side action returns a response 
        action.setCallback(this, function (response) {
            const state = response.state();
            if (state !== "SUCCESS") {
                console.log("Error in saving record: " + response.getReturnValue());
            }
        });
        // call apex method (action). Action is added to a queue 
        $A.enqueueAction(action);
    },

    showToast: function (titleValue, msgValue, typeValue) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": titleValue,
            "message": msgValue,
            "type": typeValue
        });
        toastEvent.fire();
    }
})