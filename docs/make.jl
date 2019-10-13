# This file is a part of JuliaFEM.
# License is MIT: see https://github.com/JuliaFEM/HeatTransfer.jl/blob/master/LICENSE

using Pkg, Documenter, Literate, Dates, JuliaFEMDocs

PAGES = Any[]

root = abspath(pathof(JuliaFEMDocs), "..", "..", "docs", "src")

# First we get main page from JuliaFEM.jl/README.md

using JuliaFEM
JuliaFEMDocs.copydocs(JuliaFEM)
cp(joinpath(root, "packages", "JuliaFEM", "README.md"), joinpath(root, "index.md"); force=true)
push!(PAGES, "Home" => "index.md")

# Add packages

PACKAGES = Any[]

# HeatTransfer.jl
using HeatTransfer
JuliaFEMDocs.copydocs(HeatTransfer)
HeatTransferDocs = Any[]
push!(HeatTransferDocs, "Home" => "packages/HeatTransfer/README.md")
push!(HeatTransferDocs, "Docs" => "packages/HeatTransfer/index.md")
push!(PACKAGES, "HeatTransfer.jl" => HeatTransferDocs)

push!(PAGES, "Packages" => PACKAGES)

# Done. Make docs.

makedocs(modules=[JuliaFEMDocs],
         format = Documenter.HTML(),
         checkdocs = :all,
         sitename = "JuliaFEM.jl",
         authors = "Jukka Aho",
         pages = PAGES)
