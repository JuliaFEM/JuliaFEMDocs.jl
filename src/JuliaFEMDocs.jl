# This file is a part of JuliaFEM.
# License is MIT: see https://github.com/JuliaFEM/JuliaFEMDocs.jl/blob/master/LICENSE

module JuliaFEMDocs

"""
    copydocs(package)

Copy documentation of some package to the src dir of JuliaFEMDocs/docs.
"""
function copydocs(package)
    # source
    pkg_path = abspath(pathof(package), "..", "..")
    src_docs = joinpath(pkg_path, "docs", "src")
    src_readme = joinpath(pkg_path, "README.md")
    # destination
    dst_root = abspath(pathof(JuliaFEMDocs), "..", "..", "docs", "src", "packages")
    dst_path = joinpath(dst_root, string(package))
    dst_readme = joinpath(dst_path, "README.md")
    # copy
    isdir(dst_root) || mkdir(dst_root)
    cp(src_docs, dst_path)
    cp(src_readme, dst_readme)
    return nothing
end

end
