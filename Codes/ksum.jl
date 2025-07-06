function ksum(x, M)
    N=length(x);
    xb=N/M
    NB=Int(floor(xb));
    (NB == xb) || error("blocksize wrong")
    sumd=0.0
    @views for ib = 1:NB
        ilow=(ib-1)*M + 1
        ihigh=ib*M
        sumd += sum(x[ilow:ihigh])
    end
    sumd
end
