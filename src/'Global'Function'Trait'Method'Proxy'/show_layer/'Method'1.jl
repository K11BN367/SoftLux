function show_layer(Layer::u__Chain)
    Inset = ""
    return show_layer(Layer, Inset)[1]
end
function show_layer(Layer::u__Chain, Inset)
    String = string(Inset, "Chain", " ", Layer.Input_Tuple, " ", Layer.Output_Tuple)
    Inset = string(Inset, "  ")
    for Layer in Layer.Layer_Tuple
        String = string(String, "\n")
        Layer_String, Inset  = show_layer(Layer, Inset)
        String = string(String, Inset, "  ", Layer_String)
    end
    Inset = Inset[1:end-2]
    return String, Inset
end
function show_layer(Layer::u__Cat)
    Inset = ""
    return show_layer(Layer, Inset)[1]
end
function show_layer(Layer::u__Cat, Inset)
    String = string(Inset, "Cat", " ", Layer.Input_Tuple, " ", Layer.Output_Tuple)
    Inset = string(Inset, "  ")
    for Layer in Layer.Layer_Tuple
        String = string(String, "\n")
        Layer_String, Inset  = show_layer(Layer, Inset)
        String = string(String, Inset, "  ", Layer_String)
    end
    Inset = Inset[1:end-2]
    return String, Inset
end
function show_layer(Layer::u__Convolution, Inset)
    return string(Inset, "Convolution", " ", Layer.Input_Tuple, " ", Layer.Output_Tuple), Inset
end
function show_layer(Layer::u__MaxPool, Inset)
    return string(Inset, "MaxPool", " ", Layer.Input_Tuple, " ", Layer.Output_Tuple), Inset
end
function show_layer(Layer::u__Nop, Inset)
    return string(Inset, "Nop", " ", Layer.Input_Tuple, " ", Layer.Output_Tuple), Inset
end
function show_layer(Layer::u__Upsample, Inset)
    return string(Inset, "Upsample", " ", Layer.Input_Tuple, " ", Layer.Output_Tuple), Inset
end
