using SSDPClient
using Test

str = ssdpquery("uuid", timeoutsecs = 2)
@test isnothing(str) || contains(str, "USN") # in CI this will be nothing


