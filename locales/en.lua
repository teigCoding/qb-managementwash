local Translations = {
    error = {
        not_started = "You have not started washing!",
        cannot_collect = "You cannot collect ",
        have_to_wait = " You have to wait ",
        not_enough = "You don't have enough marked money!",
        not_value = "Invalid amount!",
      
    },
    success = {
        wash = "You got ",
        started_wash = "You started washing ",
        wash_start = " USD!",
    },
    label = {
        hours = " hours, ",
        minutes = " minutes, ",
        seconds = " seconds",
        ready = "Ready for pickup!",
        quit = "Quit",
        header = "Wash Menu",
        send = "Send",
        amount = "Amount",
        method = "Washing method",
        option1 = "Quick Wash",
        option2 = "1 day",
        option3 = "2 days",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})