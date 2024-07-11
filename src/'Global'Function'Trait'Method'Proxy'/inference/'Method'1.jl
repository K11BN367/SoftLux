function inference(
    ::t__inference_Chain, Value::v,
    ::t, Layer_Tuple
    )
    Layer_Tuple_Index_First = firstindex(Layer_Tuple)
    Layer_Tuple_Index_Last = lastindex(Layer_Tuple)

    Changed = false
    for Layer_Tuple_Index in Layer_Tuple_Index_First:Layer_Tuple_Index_Last
        Layer_Tuple, Changed = inference_backward(Value, Layer_Tuple, Layer_Tuple_Index_First, Changed)
        for Layer_Tuple_Index in (Layer_Tuple_Index_First + 1):(Layer_Tuple_Index_Last - 1)
            Layer_Tuple, Changed = inference_forward(Value, Layer_Tuple, Layer_Tuple_Index, Changed)
            Layer_Tuple, Changed = inference_backward(Value, Layer_Tuple, Layer_Tuple_Index, Changed)
        end
        Layer_Tuple, Changed = inference_forward(Value, Layer_Tuple, Layer_Tuple_Index_Last, Changed)

        if Changed == false
            break
        else
            Changed = false
        end
    end
    
    return Layer_Tuple
end
function inference(
    ::t__inference_Cat, ::v,
    ::t, Layer_Tuple,
    ::t, Old_Input_Tuple,
    ::t, Old_Output_Tuple,
    ::t, Dimension
    )
    Layer_Tuple_Index_First = firstindex(Layer_Tuple)
    Layer_Tuple_Index_Last = lastindex(Layer_Tuple)

    local Index_Range
    
    Input_Flag = false
    for Layer_Tuple_Index in Layer_Tuple_Index_First:Layer_Tuple_Index_Last
        if to_infer(Layer_Tuple[Layer_Tuple_Index].Input_Tuple) == false
            Index_Range = eachindex(Layer_Tuple[Layer_Tuple_Index].Input_Tuple)
            Input_Flag = true
            break
        end
    end
    local New_Input_Tuple
    if Input_Flag == true
        New_Input_Tuple = ()
        for Index in Index_Range
            local Input
            Input_Flag = false
            for Layer_Tuple_Index in Layer_Tuple_Index_First:Layer_Tuple_Index_Last
                if to_infer(Layer_Tuple[Layer_Tuple_Index].Input_Tuple, Index) == false
                    Input = Layer_Tuple[Layer_Tuple_Index].Input_Tuple[Index]
                    Input_Flag = true
                    break
                end
            end
            if Input_Flag == true
                New_Input_Tuple = (New_Input_Tuple..., Input)
            else
                New_Input_Tuple = (New_Input_Tuple..., SoftLux.Infer)
            end
        end
        New_Input_Tuple = merge_information(Old_Input_Tuple, New_Input_Tuple)
        New_Input_Tuple = compress_information(New_Input_Tuple)
    else
        New_Input_Tuple = SoftLux.Infer
    end

    Output_Flag = true
    for Layer_Tuple_Index in Layer_Tuple_Index_First:Layer_Tuple_Index_Last
        if to_infer(Layer_Tuple[Layer_Tuple_Index].Output_Tuple) == false
            Index_Range = eachindex(Layer_Tuple[Layer_Tuple_Index].Output_Tuple)
        else
            Output_Flag = false
            break
        end
    end
    if Output_Flag == true
        New_Output_Tuple = ()
        for Index in Index_Range
            local Output
            if Index == Dimension
                Output = 0
                Output_Flag = true
                for Layer_Tuple_Index in Layer_Tuple_Index_First:Layer_Tuple_Index_Last
                    if to_infer(Layer_Tuple[Layer_Tuple_Index].Output_Tuple, Index) == false
                        Output += Layer_Tuple[Layer_Tuple_Index].Output_Tuple[Index]
                    else
                        Output_Flag = false
                        break
                    end
                end
            else
                Output_Flag = false
                for Layer_Tuple_Index in Layer_Tuple_Index_First:Layer_Tuple_Index_Last
                    if to_infer(Layer_Tuple[Layer_Tuple_Index].Output_Tuple, Index) == false
                        Output = Layer_Tuple[Layer_Tuple_Index].Output_Tuple[Index]
                        Output_Flag = true
                        break
                    end
                end
            end
            if Output_Flag == true
                New_Output_Tuple = (New_Output_Tuple..., Output)
            else
                New_Output_Tuple = (New_Output_Tuple..., SoftLux.Infer)
            end
        end
        New_Output_Tuple = merge_information(Old_Output_Tuple, New_Output_Tuple)
        New_Output_Tuple = compress_information(New_Output_Tuple)
    else
        New_Output_Tuple = SoftLux.Infer
    end

    return Layer_Tuple, New_Input_Tuple, New_Output_Tuple
end
function inference(
    ::t__inference_Convolution, ::v,
    ::t, Old_Value_1,
    ::t, Old_Value_2,
    ::t, computation,
    ::t, Kernel,
    ::t, Pad,
    ::t, Dilation,
    ::t, Stride)
    Length = length(Old_Value_1)
    Pad = expand_information(Pad, Length)
    Dilation = expand_information(Dilation, Length)
    Stride = expand_information(Stride, Length)

    New_Value_2_Tuple = ()
    for Index in eachindex(Old_Value_1)
        if to_skip(Kernel, Index) == true
            New_Value_2_Tuple = append_information(New_Value_2_Tuple, Old_Value_2, Index)
        else
            if to_infer(Old_Value_1, Index) == true
                New_Value_2_Tuple = append_information(New_Value_2_Tuple, Old_Value_2, Index)
            else
                New_Value_2_Tuple = append_information(New_Value_2_Tuple, computation(Old_Value_1[Index], Kernel[Index], Pad[Index], Dilation[Index], Stride[Index]))
            end
        end
    end

    New_Value_2_Tuple = merge_information(New_Value_2_Tuple, Old_Value_2)
    New_Value_2_Tuple = compress_information(New_Value_2_Tuple)

    return New_Value_2_Tuple
end
function inference(
    ::t__inference_MaxPool, Trait,
    ::t, Old_Value_1,
    ::t, Old_Value_2,
    ::t, computation,
    ::t, Kernel,
    ::t, Pad,
    ::t, Dilation,
    ::t, Stride)
    Length = length(Old_Value_1)
    Pad = expand_information(Pad, Length)
    Dilation = expand_information(Dilation, Length)
    Stride = expand_information(Stride, Length)

    New_Value_1_Tuple = ()
    New_Value_2_Tuple = ()
    for Index in eachindex(Old_Value_1)
        if to_skip(Kernel, Index) == true
            if to_infer(Old_Value_1, Index) == false
                New_Value_1_Tuple = append_information(New_Value_1_Tuple, Old_Value_1, Index)
                New_Value_2_Tuple = append_information(New_Value_2_Tuple, Old_Value_1, Index)
            else
                New_Value_1_Tuple = append_information(New_Value_1_Tuple, Old_Value_2, Index)
                New_Value_2_Tuple = append_information(New_Value_2_Tuple, Old_Value_2, Index)
            end
        else
            if to_infer(Old_Value_1, Index) == true
                New_Value_1_Tuple = append_information(New_Value_1_Tuple, Old_Value_1, Index)
                New_Value_2_Tuple = append_information(New_Value_2_Tuple, Old_Value_2, Index)
            else
                New_Value_1_Tuple = append_information(New_Value_1_Tuple, Old_Value_1, Index)
                if to_infer(Old_Value_2, Index) == false
                    New_Value_2_Tuple = append_information(New_Value_2_Tuple, Old_Value_2, Index)
                else
                    New_Value_2_Tuple = append_information(New_Value_2_Tuple, computation(Old_Value_1[Index], Kernel[Index], Pad[Index], Dilation[Index], Stride[Index]))
                end
            end
        end
    end

    New_Value_1_Tuple = merge_information(New_Value_1_Tuple, Old_Value_1)
    New_Value_2_Tuple = merge_information(New_Value_2_Tuple, Old_Value_2)
    New_Value_1_Tuple = compress_information(New_Value_1_Tuple)
    New_Value_2_Tuple = compress_information(New_Value_2_Tuple)

    return New_Value_1_Tuple, New_Value_2_Tuple
end
function inference(
    ::t__inference_Nop, ::v,
    ::t, Input_Tuple,
    ::t, Output_Tuple)
    Output_Tuple = merge_information(Input_Tuple, Output_Tuple)
    return Output_Tuple
end
function inference(
    ::t__inference_Upsample, Trait,
    ::t, Old_Value_1,
    ::t, Old_Value_2,
    ::t, computation,
    ::t, Scale)
    Scale = expand_information(Scale, length(Old_Value_1))
    
    New_Value_1_Tuple = ()
    New_Value_2_Tuple = ()
    for Index in eachindex(Old_Value_1)
        if to_skip(Scale, Index) == true
            if to_infer(Old_Value_1, Index) == false
                New_Value_1_Tuple = append_information(New_Value_1_Tuple, Old_Value_1, Index)
                New_Value_2_Tuple = append_information(New_Value_2_Tuple, Old_Value_1, Index)
            else
                New_Value_1_Tuple = append_information(New_Value_1_Tuple, Old_Value_2, Index)
                New_Value_2_Tuple = append_information(New_Value_2_Tuple, Old_Value_2, Index)
            end
        else
            if to_infer(Old_Value_1, Index) == true || to_infer(Scale, Index) == true
                New_Value_1_Tuple = append_information(New_Value_1_Tuple, Old_Value_1, Index)
                New_Value_2_Tuple = append_information(New_Value_2_Tuple, Old_Value_2, Index)
            else
                New_Value_1_Tuple = append_information(New_Value_1_Tuple, Old_Value_1, Index)
                if to_infer(Old_Value_2, Index) == false
                    New_Value_2_Tuple = append_information(New_Value_2_Tuple, Old_Value_2, Index)
                else
                    New_Value_2_Tuple = append_information(New_Value_2_Tuple, computation(Old_Value_1[Index], Scale[Index]))
                end
            end 
        end
    end

    New_Value_1_Tuple = compress_information(New_Value_1_Tuple)
    New_Value_2_Tuple = compress_information(New_Value_2_Tuple)
    New_Value_1_Tuple = merge_information(New_Value_1_Tuple, Old_Value_1)
    New_Value_2_Tuple = merge_information(New_Value_2_Tuple, Old_Value_2)

    return New_Value_1_Tuple, New_Value_2_Tuple
end
