
"""
    format_angle(parts; delim=':')

Given the `(whole, minutes, seconds)` parts of an angle, will format into a
string with the given delimiter(s). These parts can be generated by the
`xxx2dms` and `xxx2hms` methods, for sexagesimal and `hour:minute:second`
outputs. Multiple delimiters can be given in a tuple or vector placed after
their respective values. For more control over formatting, consider using
[Printf](https://docs.julialang.org/en/v1/stdlib/Printf/) or a package like
[Format.jl](https://github.com/JuliaString/Format.jl).

# Examples
```jldoctest
julia> ang = 45.0; # degrees

julia> format_angle(deg2dms(ang))
"45:0:0.0"

julia> format_angle(deg2hms(ang))
"3:0:0.0"

julia> format_angle(rad2hms(1.5), delim=["h", "m", "s"])
"5h43m46.48062470963538s"
```

# See also
[`deg2dms`](@ref), [`deg2hms`](@ref), [`rad2dms`](@ref), [`rad2hms`](@ref),
[`ha2dms`](@ref), [`ha2hms`](@ref)
"""
format_angle(angle; delim=':') = format_angle(angle, delim)
format_angle(w, m, s; kwargs...) = format_angle((w, m, s); kwargs...)

function format_angle(angle, delim::Union{<:AbstractString, Char})
    whole, min, sec = angle
    sgn = signbit(whole) ? '-' : ""
    return string(sgn, Int(whole), delim, Int(min), delim, sec)
end

function format_angle(angle, delims::Union{<:AbstractVector, <:Tuple})
    whole, min, sec = angle
    d1, d2, d3 = delims
    #sgn = signbit(whole) ? '-' : ""
    #return string(sgn, Int(whole), d1, Int(min), d2, sec, d3)
    return string(Int(whole), d1, Int(min), d2, sec, d3)
end
