({
    doInit : function(component, event, helper) {
        console.log("Initialization completed");

        // get list of 100 words from helper file
        console.log("Words: " + helper.getWords(6));
    }
})
