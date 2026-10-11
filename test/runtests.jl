using SSDPClient
using Test

@test ssdpquery isa Function 

# sandboxed run in CI will not allow these tests below
# str = ssdpquery("uuid", timeoutsecs = 2)
# @test contains(str, "USN") # in CI this will be nothing so will fail in CI
