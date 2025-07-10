"""
blocksum(x, M)

Compute sum(x) by blocking x into NB equally sized blocks of size M and
accumulate the sums of the block sums in double.

This keeps sums of Float16 arrays from overflowing.

I'm using the Julia ```sum``` command. Any other summation function would do.

Herewith an example
```jldoctest
julia> x=rand(Float16,512^2);

julia> M=512;

julia> xs=sum(x)
Inf

julia> # This overflows as you'd expect just from the array length.

julia> x64=Float64.(x); # Promote the whole thing.

julia> s64=sum(x64) # Sum the promoted array and avoid overflow.
1.30824e+05

julia> sk=blocksum(x,512) # Use blocksum and do all the work in Float16
1.30822e+05
```
"""
function blocksum(x, M)
    N=length(x);
# Stink test for consistency between array length and block size.
    xb=N/M
    NB=Int(floor(xb));
    (NB == xb) || error("blocksize wrong")
#
# Accumulate the block sums in double. Be aware that the
# block sums themselves are still in the precision of x.
#
    sumd=0.0
    @views for ib = 1:NB
        ilow=(ib-1)*M + 1
        ihigh=ib*M
        sumd += sum(x[ilow:ihigh])
    end
    sumd
end
