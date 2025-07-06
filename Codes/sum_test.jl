function sum_test(n = 1000)
    # M2 Mac using the Apple Accelerate Blas:w
    # random Float16 vector
    vh=rand(Float16, n);
    vh ./ n
    # double precision copy
    vd=Float64.(vh)
    # sum in half, sum in double
    sumh=sum(vh)
    sumd=sum(vd)
    println(sumh, "  ", sumd)
    #compare results
    del=abs(sumd-sumh)/sumd
    return del
end
