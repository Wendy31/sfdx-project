({
    blockClickHandler : function(component, event, helper) {
        // on click of a tile open = true
        // get attrribute from block cmp
        const open = component.get("v.open");
        if(open === false){
            component.set("v.open", true);

        // fire the BlockClickEvent
        // first get the event from CMP, get label from CMP, then set the EVENT value, and fire it (to send to parent)
        const label = component.get("v.label");
        let compEvent = component.getEvent("onclick");
        compEvent.setParams({value : label}); // takes label attribute from CMP and assigns to Event's value attribute 
        compEvent.fire();
        } 
    },

    scriptsLoaded : function(component) {
        // do post processing after external JS script is loaded
        // call FitText method and pass in the div element (of the block tiles) you want the text to fit in
        fitText(component.getElement(".board-block"));
    }
})
