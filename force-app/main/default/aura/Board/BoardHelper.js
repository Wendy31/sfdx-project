({
    getWords: function (count) {
        if (count > 100) {
            return; // more than 100, then do nothing
        }
        // build array of 100 words
        let wordsArray = [
            "expansion",
            "grandfather",
            "nappy",
            "oranges",
            "beds",
            "quack",
            "achiever",
            "yell",
            "hospital",
            "winter",
            "understood",
            "squalid",
            "merciful",
            "reaction",
            "wipe",
            "fearless",
            "tiresome",
            "introduce",
            "planes",
            "drum",
            "muddle",
            "capable",
            "canvas",
            "route",
            "enchanted",
            "quirky",
            "switch",
            "apparatus",
            "loss",
            "agreement",
            "substance",
            "back",
            "oafish",
            "expand",
            "aromatic",
            "quarrelsome",
            "free",
            "useful",
            "raspy",
            "drown",
            "ring",
            "lush",
            "numberless",
            "embarrass",
            "shrill",
            "rice",
            "ice",
            "crow",
            "pumped",
            "sparkle",
            "instruct",
            "girl",
            "glass",
            "frog",
            "murky",
            "impolite",
            "crabby",
            "pin",
            "grade",
            "upbeat",
            "linen",
            "flaky",
            "side",
            "unknown",
            "cactus",
            "round",
            "busy",
            "grab",
            "crush",
            "faithful",
            "mother",
            "clean",
            "unhealthy",
            "event",
            "absent",
            "thoughtless",
            "icy",
            "prefer",
            "charge",
            "confuse",
            "clam",
            "dress",
            "snake",
            "evasive",
            "unit",
            "flow",
            "annoying",
            "gusty",
            "possessive",
            "rhetorical",
            "rule",
            "frantic",
            "farm",
            "poor",
            "possess",
            "men",
            "pleasant",
            "zoom",
            "sidewalk",
            "reply"
        ];
        // randomise array
        wordsArray = this.randomiseArray(wordsArray);
        // convert array of strings to array of objects, to add property 'open' to each word
        // open attribute will be false by default, until the tiles are clicked then open = true (see block.cmp)
        const wordObjArray = wordsArray.map((element) => {
            return {
                word: element,
                open: false
            };
        });

        // return the requested words
        return wordObjArray.slice(0, count);
    },
    // shuffle the array list to get a random result of words returned
    randomiseArray: function (array) {
        const randomArr = array;
        // randomise the array
        for (let i = randomArr.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * i);
            const temp = randomArr[i]; // swapping elements within array to shuffle them
            randomArr[i] = randomArr[j];
            randomArr[j] = temp;
        }
        return randomArr;
    },

    // method to get random index to find random WinWord
    getWinWord: function (array) {
        const randomIndex = Math.floor(Math.random() * array.length);
        return array[randomIndex].word;
    },

    disableBoard: function (component) {
        component.set("v.disableBoard", true);
    },

    enableBoard: function (component) {
        component.set("v.disableBoard", false);
    },

    resetBoard: function (component) {
        // re-enableBoard to unblock board from layer 
        this.enableBoard(component);
        // reset remainingMoves
        component.set("v.clickCount", 0);
        // reset result
        component.set("v.result", "");
    },

    fireResultEvent: function (resultValue) {
        // get event
        const appEvent = $A.get("e.c:ResultApplicationEvent");
        // set result to event
        appEvent.setParams({
            result: resultValue
        }); // set value to JSON object
        appEvent.fire();
    }
});