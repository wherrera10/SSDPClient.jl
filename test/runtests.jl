using SSDPClient
using Test

@test ssdpquery isa Function # in CI, cannot easily test SSDP since is sandboxed

# str = ssdpquery("uuid", timeoutsecs = 2)
# @test contains(str, "USN") # in CI this will be nothing


