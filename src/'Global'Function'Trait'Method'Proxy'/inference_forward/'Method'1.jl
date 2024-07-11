function inference_forward(Layer::u__Chain, Input_Tuple)
    #println("inference_forward Chain")
    #println(Input_Tuple)
    Input_Tuple = merge_information(Input_Tuple, Layer.Input_Tuple)
    return c__Chain(
        a__Name(Layer.Name),
        a__Layer_Tuple(Layer.Layer_Tuple),
        a__Input(Input_Tuple),
        a__Output(Layer.Output_Tuple)
    )
end
function inference_forward(Layer::u__Cat, Input_Tuple)
    Input_Tuple = merge_information(Input_Tuple, Layer.Input_Tuple)
    return c__Cat(
        a__Name(Layer.Name),
        a__Layer_Tuple(values(Layer.Layer_Tuple)),
        a__Dimension(Layer.Dimension),
        a__Input(Input_Tuple),
        a__Output(Layer.Output_Tuple)
    )
end

function inference_forward(Layer::u__Convolution, Input_Tuple)
    #println("inference_forward Convolution")
    #println(Input_Tuple)
	Input_Tuple = merge_information(Layer.Input_Tuple, Input_Tuple)
	return c__Convolution(
		a__Name(Layer.Name),
		a__Kernel(Layer.Kernel),
		a__Activation_Function(Layer.Activation_Function),
		a__Pad(Layer.Pad),
		a__Dilation(Layer.Dilation),
		a__Group(Layer.Group),
		a__Stride(Layer.Stride),
		a__Input(Input_Tuple),
		a__Output(Layer.Output_Tuple)
	)
end

function inference_forward(
    ::t__inference_forward_Chain, ::v,
    ::t, Layer_Tuple,
    ::t, Output_Tuple
    )
    Layer_Tuple_Index_First = firstindex(Layer_Tuple)
    chain_check_forward(Layer_Tuple, Layer_Tuple_Index_First, Output_Tuple)
    Layer = inference_forward(Layer_Tuple[Layer_Tuple_Index_First], Output_Tuple)
    return (Layer, Layer_Tuple[(Layer_Tuple_Index_First + 1):lastindex(Layer_Tuple)]...)
end
function inference_forward(
    ::t__inference_forward_Chain, ::v,
    ::t, Layer_Tuple,
    ::t, Layer_Tuple_Index,
    ::t, Changed
    )
    if to_infer(Layer_Tuple[Layer_Tuple_Index - 1].Output_Tuple) == false
        Output_Tuple = Layer_Tuple[Layer_Tuple_Index - 1].Output_Tuple
        if Output_Tuple != Layer_Tuple[Layer_Tuple_Index].Input_Tuple
            chain_check_forward(Layer_Tuple, Layer_Tuple_Index, Output_Tuple)
            Layer = inference_forward(Layer_Tuple[Layer_Tuple_Index], Output_Tuple)
            return (Layer_Tuple[firstindex(Layer_Tuple):(Layer_Tuple_Index - 1)]..., Layer, Layer_Tuple[(Layer_Tuple_Index + 1):lastindex(Layer_Tuple)]...), true
        end
    end

    return Layer_Tuple, Changed
end
function inference_forward(
    ::t__inference_forward_Cat, Value,
    ::t, Layer_Tuple,
    ::t, Old_Input_Tuple,
    ::t, Old_Output_Tuple,
    ::t, Dimension
    )
    if Old_Input_Tuple != SoftLux.Infer
        for Layer_Tuple_Index in firstindex(Layer_Tuple):lastindex(Layer_Tuple)
            Layer = inference_forward(Layer_Tuple[Layer_Tuple_Index], Old_Input_Tuple)
            Layer_Tuple = (Layer_Tuple[1:Layer_Tuple_Index - 1]..., Layer, Layer_Tuple[Layer_Tuple_Index + 1:lastindex(Layer_Tuple)]...)
        end
    end
    Layer_Tuple, New_Input_Tuple, New_Output_Tuple = inference(Value, Layer_Tuple, Old_Input_Tuple, Old_Output_Tuple, Dimension)
    return Layer_Tuple, New_Input_Tuple, New_Output_Tuple
end
function inference_forward(
    ::t__inference_forward_Convolution, Value,
    ::t, Old_Input_Tuple,
    ::t, Old_Output_Tuple,
    ::t, Kernel,
    ::t, Pad,
    ::t, Dilation,
    ::t, Stride
    )
    computation = (Input, Kernel, Pad, Dilation, Stride)->floor(Int64, ((Input + 2 * Pad - Dilation * (Kernel - 1) - 1) / Stride) + 1)
    New_Output_Tuple = inference(Value, Old_Input_Tuple, Old_Output_Tuple, computation, Kernel, Pad, Dilation, Stride)
    #check_forward(Old_Output_Tuple, New_Output_Tuple, Kernel, Pad, Dilation, Stride)
    return New_Output_Tuple
end
function inference_forward(Layer::u__MaxPool, Input_Tuple)
    #println("inference_forward MaxPool")
    #println(Input_Tuple)
    Input_Tuple = merge_information(Input_Tuple, Layer.Input_Tuple)
    return c__MaxPool(
        a__Name(Layer.Name),
        a__Window(Layer.Window),
        a__Pad(Layer.Pad),
        a__Dilation(Layer.Dilation),
        a__Stride(Layer.Stride),
        a__Input(Input_Tuple),
        a__Output(Layer.Output_Tuple)
    )
end
function inference_forward(Layer::u__Nop, Input_Tuple)
    Input_Tuple = merge_information(Input_Tuple, Layer.Input_Tuple)
    return c__Nop(
        a__Name(Layer.Name),
        a__Input(Input_Tuple),
        a__Output(Layer.Output_Tuple)
    )
end
function inference_forward(
    ::t__inference_forward_Nop, Trait,
    ::t, Input_Tuple,
    ::t, Output_Tuple)
    Output_Tuple = inference(Trait, Input_Tuple, Output_Tuple)
    return Output_Tuple
end
function inference_forward(Layer::u__Upsample, Input_Tuple)
    #println("inference_forward Upsample")
    #println(Input_Tuple)
    Input_Tuple = merge_information(Input_Tuple, Layer.Input_Tuple)
    return c__Upsample(
        a__Name(Layer.Name),
        a__Mode(Layer.Mode),
        a__Scale(Layer.Scale),
        a__Input(Input_Tuple),
        a__Output(Layer.Output_Tuple)
    )
end
function inference_forward(
    ::t__inference_forward_Upsample, Trait,
    ::t, Old_Input_Tuple,
    ::t, Old_Output_Tuple,
    ::t, Scale)
    New_Input_Tuple, New_Output_Tuple = inference(Trait, Old_Input_Tuple, Old_Output_Tuple, (Input, Scale)->round(Int, Input * Scale), Scale)
    return New_Input_Tuple, New_Output_Tuple
end
