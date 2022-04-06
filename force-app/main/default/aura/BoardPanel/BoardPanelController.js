({
    startGame: function (component, event, helper) {
        // access combobox
        let gameModeComboBox = component.find("gameMode");

        // access value of combobox
        let selectedValue = gameModeComboBox.get("v.value");

        // get selectedMode in case this value is already set from last game
        const selectedMode = component.get("v.selectedMode");
        // if selectedMode is not empty, then call aura:method to reInit page
        if (selectedMode != null) {
            const boardComp = component.find("boardComp"); // use find method to get aura id
            // call aura method by using the boardComp and aura method name
            boardComp.startGame();
        }

        // update selectedMode attribute
        component.set("v.selectedMode", selectedValue);

        console.log("The start game function is called. The Game Mode is: " + selectedValue);
        console.log("The selected Game Mode is: " + component.get("v.selectedMode"));
    },

    reshuffleBoard: function (component, event, helper) {
        // find boardComp, then call child reshuffleBoard method from aura:id boardComp  that connects parent to child
        const boardComp = component.find("boardComp");
        boardComp.reshuffleBoard();
        component.set("v.reshuffleDisabled", true);
    },

    // handles app event, when player wins or loses will disable or enable reshuffle button
    onResultHandler: function (component, event, helper) {
        const result = event.getParam("result");
        if (result === "win") {
            component.set("v.reshuffleDisabled", true);
            helper.showToast("YOU WIN", "Hooray!", "success");
        } else {
            component.set("v.reshuffleDisabled", false);
            helper.showToast("YOU LOSE", "Reshuffle the board to keep playing", "error");
        }
        // call apex method via helper file
        helper.addResultRecord(component, result);
    }
});