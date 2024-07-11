function reduce_structure(Layer::u__Chain)
    return c__Chain(
        a__Name(Layer.Name),
        a__Layer_Tuple(values(Layer.Layer_Tuple)),
        a__Input(Layer.Input_Tuple),
        a__Output(Layer.Output_Tuple),
        a__Reduce_Structure(true),
    )
end
function reduce_structure(Layer::u__Cat)
    #println("#####################")
    #println(Layer.Layer_Tuple)
    #println(v__(Layer.Layer_Tuple))
    return c__Cat(
        a__Name(Layer.Name),
        a__Layer_Tuple(Layer.Layer_Tuple),
        a__Dimension(Layer.Dimension),
        a__Input(Layer.Input_Tuple),
        a__Output(Layer.Output_Tuple),
        a__Reduce_Structure(true)
    )
end
function reduce_structure(Layer::u__Convolution)
    return c__Convolution(
        a__Name(Layer.Name),
        a__Kernel(Layer.Kernel),
        a__Activation_Function(Layer.Activation_Function),
        a__Pad(Layer.Pad),
        a__Dilation(Layer.Dilation),
        a__Group(Layer.Group),
        a__Stride(Layer.Stride),
        a__Input(Layer.Input_Tuple),
        a__Output(Layer.Output_Tuple),
        a__Reduce_Structure(true)
    )
end
function reduce_structure(Layer::u__MaxPool)
    return c__MaxPool(
        a__Name(Layer.Name),
        a__Window(Layer.Window),
        a__Pad(Layer.Pad),
        a__Dilation(Layer.Dilation),
        a__Stride(Layer.Stride),
        a__Input(Layer.Input_Tuple),
        a__Output(Layer.Output_Tuple),
        a__Reduce_Structure(true)
    )
end
function reduce_structure(Layer::u__Nop)
    return c__Nop(
        a__Name(Layer.Name),
        a__Input(Layer.Input_Tuple),
        a__Output(Layer.Output_Tuple),
        a__Reduce_Structure(true)
    )
end
function reduce_structure(Layer::u__Upsample)
    return c__Upsample(
        a__Name(Layer.Name),
        a__Mode(Layer.Mode),
        a__Scale(Layer.Scale),
        a__Input(Layer.Input_Tuple),
        a__Output(Layer.Output_Tuple),
        a__Reduce_Structure(true)
    )
end
