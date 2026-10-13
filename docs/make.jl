using Documenter, SSDPClient

makedocs(
    sitename = "SSDPClient Module Documentation",
    format = Documenter.HTML(prettyurls = false),
)

deploydocs(
    repo = "github.com/wherrera10/SSDPClient.jl.git",
    devbranch = "master",  
)
