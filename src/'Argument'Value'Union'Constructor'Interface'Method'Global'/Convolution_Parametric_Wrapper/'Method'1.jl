function getproperty(
    ::v__Convolution_Parametric_Wrapper{Conv_Wrapper},
    Property::c__Symbol
    ) where {Conv_Wrapper}
    if Property == c__Symbol("Conv_Wrapper")
        return Conv_Wrapper
    end
end