({
    doInit : function(component, event, helper) {
        console.log("Initialization completed");

        // get list of words from helper file
        const words = helper.getWords(6);
        // set array of words to cmp
        component.set("v.words", words);
        console.log("Words: " + words);

        // get random winWord
        const winWord = helper.getWinWord(words);
        // set WinWord to cmp
        component.set("v.winWord", winWord);
        console.log("Win Word: " + winWord);
        



    }
})
