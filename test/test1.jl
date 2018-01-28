using SSDPClient

const ARDUINOMATCH = "SERVER: Arduino.+(http://[^/]+)/description"


println(ssdpquery(ARDUINOMATCH)[1])


true

