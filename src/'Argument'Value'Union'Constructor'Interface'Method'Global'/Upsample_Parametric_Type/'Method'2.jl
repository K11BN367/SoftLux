@generated function apply_upsample(Layer::v__Upsample_Parametric_Type, Input, Parameter, State)
    Return = upsample_bilinear(Input, Layer.Output_Tuple[1:2], true) #FIX
    return Return, State
end