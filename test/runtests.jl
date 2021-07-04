using SSDPClient
using Test

str = ssdpquery("Roku", timeoutsecs = 30)

# @test contains(str, "Roku")

true
