@generated function apply(::v__Convolution_Parametric_Wrapper{Conv_Wrapper}, Input, Parameter, State) where {Conv_Wrapper}
    ##println("apply Convolution")
    ##println(size(Input))
    return :(apply($(Conv_Wrapper), Input, Parameter, State))
end