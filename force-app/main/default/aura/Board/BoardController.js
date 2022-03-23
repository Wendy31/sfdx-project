({
    doInit : function(component, event, helper) {
        console.log("Initialization completed");

        // set number of columns based on game mode
        const gameMode = component.get("v.mode");
        let column = 0;
        if (gameMode && gameMode === "hard") {
            column = 6;
        } else if (gameMode === "medium") {
            column = 4;
        } else {
            column = 3;
        }

        // set block size based on column
        let blockSize = 12/ column;
        component.set("v.blockSize", blockSize);

        // get list of words from helper file
        const words = helper.getWords(column * column);
        // set array of words to cmp
        component.set("v.words", words);

        // get random winWord
        const winWord = helper.getWinWord(words);
        // set WinWord to cmp
        component.set("v.winWord", winWord);
        // reset board for every Initialization
        helper.resetBoard(component); 
    
    },
    doRender: function (component, event, helper) {
        console.log("Render completed");
    },

    blockClickHandler: function (component, event, helper) {
        // handle event from blockController
        // get the event value
        let clickCount = component.get("v.clickCount") + 1;
        const value = event.getParam("value");
        if (value === component.get("v.winWord")) {
            // user has won
            component.set("v.result", "YOU WON")
            console.log("User wins");
            helper.disableBoard(component); // sets diableBoard = true
            helper.fireResultEvent("win"); // app event fires whenever user wins or loses a game
        } else if (clickCount === 3) {
            // user has lost
            component.set("v.result", "YOU LOSE");
            console.log("User loses");
            helper.disableBoard(component);
            helper.fireResultEvent("lose"); 
        } 

        // update clickcount
        component.set("v.clickCount", clickCount);
    }

});