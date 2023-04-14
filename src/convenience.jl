# File extensions. GDAL is the catch-all for everything else
const EXT = Dict(
    GRDfile => (".grd", ".gri"), 
    NCDfile => (".nc",), 
    SMAPfile => (".h5",)
)
const REV_EXT = Dict(
    ".grd" => GRDfile, 
    ".gri" => GRDfile, 
    ".nc" => NCDfile, 
    ".h5" => SMAPfile
)

# Get the source backend for a file extension, falling back to GDALfile
_sourcetype(filename::AbstractString) = get(REV_EXT, splitext(filename)[2], GDALfile)
_sourcetype(filenames::NamedTuple) = _sourcetype(first(filenames))
_sourcetype(filename, ext::Nothing) = _sourcetype(filename)
_sourcetype(filename, ext) = get(REV_EXT, ext, GDALfile)

# Internal read method
function _open(f, filename::AbstractString; source=_sourcetype(filename), kw...)
    _open(f, source, filename; kw...)
end
