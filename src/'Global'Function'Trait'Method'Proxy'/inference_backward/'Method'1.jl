function inference_backward(Layer::u__Chain, Output_Tuple)
    Output_Tuple = merge_information(Output_Tuple, Layer.Output_Tuple)
    return c__Chain(
        a__Name(Layer.Name),
        a__Layer_Tuple(Layer.Layer_Tuple),
        a__Output(Output_Tuple),
        a__Input(Layer.Input_Tuple)
    )
end
function inference_backward(
    ::t__inference_backward_Chain, ::v,
    ::t, Layer_Tuple,
    ::t, Input_Tuple
    )
    Layer_Tuple_Index_Last = lastindex(Layer_Tuple)
    chain_check_backward(Layer_Tuple, Layer_Tuple_Index_Last, Input_Tuple)
    Layer = inference_backward(Layer_Tuple[Layer_Tuple_Index_Last], Input_Tuple)
    return (Layer_Tuple[firstindex(Layer_Tuple):(Layer_Tuple_Index_Last - 1)]..., Layer)
end
function inference_backward(
    ::t__inference_backward_Chain, ::v,
    ::t, Layer_Tuple,
    ::t, Layer_Tuple_Index,
    ::t, Changed
    )
    if to_infer(Layer_Tuple[Layer_Tuple_Index + 1].Input_Tuple) == false
        Input_Tuple = Layer_Tuple[Layer_Tuple_Index + 1].Input_Tuple
        if Input_Tuple != Layer_Tuple[Layer_Tuple_Index].Output_Tuple
            chain_check_backward(Layer_Tuple, Layer_Tuple_Index, Input_Tuple)
            Layer = inference_backward(Layer_Tuple[Layer_Tuple_Index], Input_Tuple)
            return (Layer_Tuple[firstindex(Layer_Tuple):(Layer_Tuple_Index - 1)]..., Layer, Layer_Tuple[(Layer_Tuple_Index + 1):lastindex(Layer_Tuple)]...), true
        end
    end
    
    return Layer_Tuple, Changed
end
function inference_backward(Layer::u__Cat, Output_Tuple)
    Output_Tuple = merge_information(Output_Tuple, Layer.Output_Tuple)
    return c__Cat(
        a__Name(Layer.Name),
        a__Layer_Tuple(values(Layer.Layer_Tuple)),
        a__Dimension(Layer.Dimension),
        a__Input(Layer.Input_Tuple),
        a__Output(Output_Tuple)
    )
end
function inference_backward(
    ::t__inference_backward_Cat, Trait,
    ::t, Layer_Tuple,
    ::t, Old_Output_Tuple,
    ::t, Old_Input_Tuple,
    ::t, Dimension
    )
    if Old_Output_Tuple != SoftLux.Infer
        for Layer_Tuple_Index in lastindex(Layer_Tuple):-1:firstindex(Layer_Tuple)
            if Layer_Tuple[Layer_Tuple_Index].Output_Tuple != SoftLux.Infer
                New_Output_Tuple = ()
                for Index in firstindex(Old_Output_Tuple):lastindex(Old_Output_Tuple)
                    ###check if the outputs match
                    if Layer_Tuple[Layer_Tuple_Index].Output_Tuple[Index] == SoftLux.Infer
                        New_Output_Tuple = (New_Output_Tuple..., Old_Output_Tuple[Index])
                    else
                        New_Output_Tuple = (New_Output_Tuple..., SoftLux.Infer)
                    end
                end
                Layer = inference_backward(Layer_Tuple[Layer_Tuple_Index], New_Output_Tuple)
                Layer_Tuple = (Layer_Tuple[1:Layer_Tuple_Index - 1]..., Layer, Layer_Tuple[Layer_Tuple_Index + 1:lastindex(Layer_Tuple)]...)
            end
        end
    end
    Layer_Tuple, New_Input_Tuple, New_Output_Tuple = inference(Trait, Layer_Tuple, Old_Input_Tuple, Old_Output_Tuple, Dimension)
    return Layer_Tuple, New_Output_Tuple, New_Input_Tuple
end
function inference_backward(Layer::u__Convolution, Output_Tuple)
	Output_Tuple = merge_information(Layer.Output_Tuple, Output_Tuple)
	return c__Convolution(
		a__Name(Layer.Name),
		a__Kernel(Layer.Kernel),
		a__Activation_Function(Layer.Activation_Function),
		a__Pad(Layer.Pad),
		a__Dilation(Layer.Dilation),
		a__Group(Layer.Group),
		a__Stride(Layer.Stride),
		a__Input(Layer.Input_Tuple),
		a__Output(Output_Tuple)
	)
end
function inference_backward(
    ::t__inference_backward_Convolution, Value,
    ::t, Old_Output_Tuple,
    ::t, Old_Input_Tuple,
    ::t, Kernel,
    ::t, Pad,
    ::t, Dilation,
    ::t, Stride
    )
    computation = (Output, Kernel, Pad, Dilation, Stride)->ceil(Int64, ((Output - 1) * Stride + Dilation * (Kernel - 1) + 1 - 2 * Pad))
    New_Input_Tuple = inference(Value, Old_Output_Tuple, Old_Input_Tuple, computation, Kernel, Pad, Dilation, Stride)
    #check_backward(Old_Input_Tuple, New_Input_Tuple, Kernel_Tuple, Pad, Dilation, Stride)
    return New_Input_Tuple
end
function inference_backward(Layer::u__MaxPool, Output_Tuple)
    Output_Tuple = merge_information(Output_Tuple, Layer.Output_Tuple)
    return c__MaxPool(
        a__Name(Layer.Name),
        a__Window(Layer.Window),
        a__Pad(Layer.Pad),
        a__Dilation(Layer.Dilation),
        a__Stride(Layer.Stride),
        a__Output(Output_Tuple),
        a__Input(Layer.Input_Tuple)
    )
end
function inference_backward(Layer::u__Nop, Output_Tuple)
    Output_Tuple = merge_information(Output_Tuple, Layer.Output_Tuple)
    return c__Nop(
        a__Name(Layer.Name),
        a__Input(Layer.Input_Tuple),
        a__Output(Output_Tuple)
    )
end
function inference_backward(
    ::t__inference_backward_Nop, Trat,
    ::t, Output_Tuple,
    ::t, Input_Tuple)
    Input_Tuple = inference(Trat, Output_Tuple, Input_Tuple)
    return Input_Tuple
end

function inference_backward(Layer::u__Upsample, Output_Tuple)
    Output_Tuple = merge_information(Output_Tuple, Layer.Output_Tuple)
    return c__Upsample(
        a__Name(Layer.Name),
        a__Mode(Layer.Mode),
        a__Scale(Layer.Scale),
        a__Input(Layer.Input_Tuple),
        a__Output(Output_Tuple)
    )
end
function inference_backward(
    ::t__inference_backward_Upsample, Trait, 
    ::t, Old_Output_Tuple,
    ::t, Old_Input_Tuple,
    ::t, Scale)
    New_Output_Tuple, New_Input_Tuple = inference(Trait, Old_Output_Tuple, Old_Input_Tuple, (Output, Scale)->round(Int, Output / Scale), Scale)
    return New_Output_Tuple, New_Input_Tuple
end