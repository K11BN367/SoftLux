@generated function apply(::v__Convolution_Parametric_Wrapper{Conv_Wrapper}, Input, Parameter, State) where {Conv_Wrapper}
    return :(apply($(Conv_Wrapper), Input, Parameter, State))
end