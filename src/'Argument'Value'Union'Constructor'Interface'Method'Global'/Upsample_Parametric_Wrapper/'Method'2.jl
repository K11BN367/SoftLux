@generated function apply(::v__Upsample_Parametric_Wrapper{Mode, Output_Tuple}, Input, Parameter, State) where {Mode, Output_Tuple}
    ##println("apply Upsample")
    ##println(size(Input))
    #Return = upsample_bilinear(Input, Output_Tuple[1:2], true) #FIX
    #return Return, State
    return :(upsample_bilinear(Input, $(Output_Tuple[1:2]), true), State)
end