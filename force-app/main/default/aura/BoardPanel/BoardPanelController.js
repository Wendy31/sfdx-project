({
    startGame : function(component, event, helper) {
        // access combobox
        let gameModeComboBox = component.find("gameMode");

        // access value of combobox
        let selectedValue = gameModeComboBox.get("v.value");

        // update selectedMode attribute
        component.set("v.selectedMode", selectedValue);

        console.log("The start game function is called. The Game Mode is: " + selectedValue);
        console.log("The selected Game Mode is: " + component.get("v.selectedMode"));
    },

    reshuffleBoard : function(component, event, helper) {
        console.log("The shuffle board function is called!");
    },
})
