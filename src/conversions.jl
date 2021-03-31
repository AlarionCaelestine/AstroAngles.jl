##
## Angle Conversions
##

const HOURS_PER_DEGREE = 24 / 360
const HOURS_PER_RADIAN = 24 / 2π
const DEGREES_PER_HOUR = 360 / 24
const RADIANS_PER_HOUR = 2π / 24


### rad2XXX

"""
    rad2ha(angle)

Convert radians to hour angles
"""
rad2ha(angle) = angle * HOURS_PER_RADIAN

"""
    rad2dms(angle)

Convert radians to (degrees, arcminutes, arcseconds) tuple
"""
rad2dms(angle) = rad2deg(angle) |> deg2dms

"""
    rad2hms(angle)

Convert radians to (hours, minutes, seconds) tuple
"""
rad2hms(angle) = rad2ha(angle) |> ha2hms

### deg2XXX

"""
    deg2ha(angle)

Convert degrees to hour angles
"""
deg2ha(angle) = angle * HOURS_PER_DEGREE

"""
    deg2dms(angle)

Convert degrees to (degrees, arcminutes, arcseconds) tuple
"""
function deg2dms(angle)
    remain_degrees, degrees = modf(angle)
    fraction_arcmin = remain_degrees * 60
    remain_arcmin, arcmin = modf(fraction_arcmin)
    arcsec = remain_arcmin * 60
    return degrees, arcmin, arcsec
end

"""
    deg2hms(angle)

Convert degrees to (hours, minutes, seconds) tuple
"""
deg2hms(angle) = deg2ha(angle) |> ha2hms

### ha2XXX

"""
    ha2rad(angle)

Convert hour angles to radians
"""
ha2rad(angle) = angle * RADIANS_PER_HOUR

"""
    ha2deg(angle)

Convert hour angles to degrees
"""
ha2deg(angle) = angle * DEGREES_PER_HOUR

"""
    ha2hms(angle)

Convert hour angles to (hours, minutes, seconds) tuple
"""
function ha2hms(angle)
    remain_hours, hours = modf(angle)
    fraction_min = remain_hours * 60
    remain_min, minutes = modf(fraction_min)
    seconds = remain_min * 60
    return hours, minutes, seconds
end

"""
    ha2dms(angle)

Convert hour angles to (degrees, arcminutes, arcseconds) tuple
"""
ha2dms(angle) = ha2deg(angle) |> deg2dms

### dms2XXX

"""
    dms2deg(degrees, arcmin, arcsec)
    dms2deg(tuple)

Convert (degrees, arcminutes, arcseconds) tuple to degrees
"""
dms2deg(degrees, arcminutes, arcseconds) = degrees + arcminutes * 60 + arcseconds * 3600

"""
    dms2rad(degrees, arcmin, arcsec)
    dms2rad(tuple)

Convert (degrees, arcminutes, arcseconds) tuple to radians
"""
dms2rad(degrees, arcminutes, arcseconds) = dms2deg(degrees, arcminutes, arcseconds) |> deg2rad

"""
    dms2ha(degrees, arcmin, arcsec)
    dms2ha(tuple)

Convert (degrees, arcminutes, arcseconds) tuple to hour angles
"""
dms2ha(degrees, arcminutes, arcseconds) = dms2deg(degrees, arcminutes, arcseconds) |> deg2ha

### hms2XXX

"""
    hms2ha(hours, mins, secs)
    hms2ha(tuple)

Convert (hours, minutes, seconds) tuple to hour angles
"""
hms2ha(hours, minutes, seconds) = hours + minutes * 60 + seconds * 3600

"""
    hms2deg(hours, mins, secs)
    hms2deg(tuple)

Convert (hours, minutes, seconds) tuple to degrees
"""
hms2deg(hours, minutes, seconds) = hms2ha(hours, minutes, seconds) |> ha2deg

"""
    hms2rad(hours, mins, secs)
    hms2rad(tuple)

Convert (hours, minutes, seconds) tuple to radians
"""
hms2rad(hours, minutes, seconds) = hms2ha(hours, minutes, seconds) |> ha2rad

for func in (:dms2rad, :dms2deg, :dms2ha, :hms2rad, :hms2deg, :hms2ha)
    @eval $func(args) = $func(args...)
end
