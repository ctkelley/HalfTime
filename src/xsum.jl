function xsumt(N)
x=rand(Float16,N)
xd=Float64.(x)
ss=sum(x)
sd=sum(xd)
sx=xsum(xd)
[ss, sd, sx]
end


function xsum(x)
elx=eltype(x)
sumx=zero(elx)
   @inbounds @simd for ix in eachindex(x)
       sumx += x[ix]
   end
sumx
end
