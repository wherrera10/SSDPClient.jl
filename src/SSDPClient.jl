module SSDPClient

export ssdpquery

using Sockets

"""
    ssdpquery(matchtext=""; timeoutsecs = 10 * 60)

Query local network for devices responding to query with the
Simple Service Discovery Protocol (SSDP).

The optional argument is a text to match, such as "Roku" or "Arduino".
The matching is case-insensitive.

If you specify a capture in the match text, that capture will be returned,
otherwise the entry that had a match will be returned in its entirety.

NOTE: If you do not specify an argument all replies will be printed and
the function will loop until interrupted. This is useful when searching a network.
"""
function ssdpquery(matchtxt=""; timeoutsecs = 24 * 60 * 60)
    MULTICAST = ip"239.255.255.250"
    SERVERPORT = 1900
    SEARCHHEADER = """M-SEARCH * HTTP/1.1\r\nHOST: 239.255.255.250:1900\r\nMAN: "ssdp:discover"\r\nST: ssdp:all\r\nMX: 10\r\n\r\n"""
    endtime = time() + timeoutsecs
    try
        while time() < endtime
            udpsock = UDPSocket()
            send(udpsock, MULTICAST,SERVERPORT, SEARCHHEADER)
            reply = join([Char(ch) for ch in recv(udpsock)], "")
            if matchtxt == ""
                println("Received reply:\r\n$reply")
            else
                regex = Regex(matchtxt, "is")
                if (mat = match(regex, reply)) != nothing
                    if length(mat.captures) > 0
                        return mat.captures
                    end
                    return reply
                end
            end
            close(udpsock)
            sleep(3)
        end
    catch y
        println("Caught error: $y")
        return ""
    end
end

end # module
