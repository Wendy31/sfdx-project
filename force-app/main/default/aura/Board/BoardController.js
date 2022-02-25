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
    }
})
