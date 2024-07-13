@generated function apply(::v__Upsample_Parametric_Wrapper{Mode, Output_Tuple}, Input, Parameter, State) where {Mode, Output_Tuple}
    return :(upsample_bilinear(Input, $(Output_Tuple[1:2]), true), State)
end