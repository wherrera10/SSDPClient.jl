""" Simple Service Discovery Protocol (SSDP) client module """
module SSDPClient

export ssdpquery

using Sockets

"""
    ssdpquery(matchtext=""; timeoutsecs = 10 * 60)

Query local network for devices responding to query with the
Simple Service Discovery Protocol (SSDP).

The `matchtext` argument is an optional text to match, such as "Roku" or "Arduino".
The matching is case-insensitive.

The optional `timeoutsecs` is the number of seconds to monitor the network
before returning from the function. This defaults to 600 seconds or 10 minutes.

If you specify a capture in the match text, that capture will be returned,
otherwise the entry that had a match will be returned in its entirety.

NOTE: If you do not specify an argument all replies will be printed and
the function will loop until timeout (default 10 minutes) or until Control-C
interrupt. This is useful when searching a network.
"""
function ssdpquery(matchtxt = ""; timeoutsecs = 10 * 60)
    MULTICAST = ip"239.255.255.250"
    SERVERPORT = 1900
    SEARCHHEADER = """M-SEARCH * HTTP/1.1\r\nHOST: 239.255.255.250:1900\r\nMAN: "ssdp:discover"\r\nST: ssdp:all\r\nMX: 10\r\n\r\n"""
    endtime = time() + timeoutsecs
    try
        while time() < endtime
            udpsock = UDPSocket()
            # Force recv() to give up once the remaining time budget is used up,
            # otherwise a reply-less recv() call can block past timeoutsecs.
            timer = Timer(max(0.0, endtime - time())) do _
                close(udpsock)
            end
            try
                send(udpsock, MULTICAST, SERVERPORT, SEARCHHEADER)
                reply = String(recv(udpsock))
                if matchtxt == ""
                    println("Received reply:\r\n$reply")
                else
                    regex = Regex(matchtxt, "is")
                    if (mat = match(regex, reply)) !== nothing
                        if length(mat.captures) > 0
                            return mat.captures
                        end
                        return reply
                    end
                end
            catch err
                err isa InterruptException && rethrow() # timer or socket error
            finally
                close(timer)
                close(udpsock)
            end
            sleep(3)
        end
    catch y
        println("Caught error: $y")
        return ""
    end
end

end # module
