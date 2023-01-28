local Translations = {
    error = {
        not_started = "Du har ikke startet vasking!",
        cannot_collect = "Du kan ikke hente ",
        have_to_wait = " Du må vente ",
        not_enough = "Du har ikke nok markerte penger!",
        not_value = "Ugyldig beløp!",
      
    },
    success = {
        wash = "Du fikk ",
        started_wash = "Du startet vasking av ",
        wash_start = " kr!",
    },
    label = {
        hours = " timer, ",
        minutes = " minutter, ",
        seconds = " sekunder",
        ready = "Klar for henting!",
        quit = "Avslutt",
        header = "Vaske Meny",
        send = "Send",
        amount = "Beløp",
        method = "Vaskemetode",
        option1 = "Hurtigvask",
        option2 = "1 dag",
        option3 = "2 dager",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
