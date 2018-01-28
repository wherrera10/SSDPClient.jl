#=
@Version: 0.1
@Author: William Herrera
@Copyright: 2018 William Herrera
@Created: 27 January 2018
@Purpose: Detect devices on local network with the SSDP protocol
=#


module SSDPClient


export ssdpquery


"""
    ssdpquery

Query local network for devices responding to query with the
Simple Service Discovery Protocol (SSDP).

The optional argument is a text to match, such as "Roku" or "Arduino".

If you specify a capture in the match text that will be returned,
otherwise the entry that matched will be returned in entirety.

NOTE: If you do not specify an argument all replies will be printed and
the function will loop until interrupted. This is useful when searching a network.
"""
function ssdpquery(matchtxt="")
    MULTICAST = ip"239.255.255.250"
    SERVERPORT = 1900
    SEARCHHEADER = """M-SEARCH * HTTP/1.1\r\nHOST: 239.255.255.250:1900\r\nMAN: "ssdp:discover"\r\nST: ssdp:all\r\nMX: 10\r\n\r\n"""
    try
        while true
            udpsock = UDPSocket()
            send(udpsock, MULTICAST,SERVERPORT, SEARCHHEADER)
            reply = join([Char(ch) for ch in recv(udpsock)], "")
            if matchtxt == ""
                println("Received reply:\r\n$reply")
            else
                regex = Regex(matchtxt, "s")
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

