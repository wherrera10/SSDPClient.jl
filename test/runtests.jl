using SSDPClient
using Test

str = ssdpquery("uuid", timeoutsecs = 15)
@test contains(str, "USN")

#str = ssdpquery("Roku", timeoutsecs = 30)
# @test contains(str, "Roku")
