# SSDPClient.jl
Simple Service Discovery Protocol (SSDP) client for julia.



## Contents

<br />

###    ssdpquery(matchtext="")

<br />

Query the local network for devices responding to query with the
Simple Service Discovery Protocol (SSDP).

The optional argument is a text to match, such as "Roku" or "Arduino".

The matching is case-insensitive.
If you specify a capture in the match text, that capture will be returned,
otherwise the entry that had a match will be returned in its entirety.

<em>NOTE: If you do not specify an argument all replies will be printed and
the function will loop until interrupted. This is useful when searching a network.</em>

<br/><br />

## Installation


<br />

You may install the package from Github in the usual way, or to install the current master copy:
    
    using Pkg
    Pkg.add("http://github.com/wherrera10/SSDPClient.jl")
    
<br />
