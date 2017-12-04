if (process.argv.length <= 2) {
    console.log("No arguments given")
    process.exit()
}

function isValid(passphrase) {
    var usedKeywords = {}
    var keywords = passphrase.split(/\s+/)

    for (var i = 0; i < keywords.length; i++) {
        var kw = keywords[i]

        if (!!keywords[kw]) {
            return 0
        } else {
            keywords[kw] = true
        }
    }

    return 1
}

passphrases = process.argv.slice(2)

var numValid = 0
for (var i = 0; i < passphrases.length; i++) {
    numValid += isValid(passphrases[i])
}

console.log(numValid)
