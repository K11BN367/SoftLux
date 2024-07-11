#'Constructor'
u__Argument = u{a__Name, a__Input, a__Output, a__Reduce_Structure}
function c__Nop(Value_Tuple::u__Argument...)
    Name,               Value_Tuple = unpack_arguments(a__Name, Value_Tuple...)
    Input_Tuple,        Value_Tuple = unpack_arguments(a__Input(SoftLux.Infer), Value_Tuple...)
    Output_Tuple,       Value_Tuple = unpack_arguments(a__Output(SoftLux.Infer), Value_Tuple...)
    Reduce_Structure,   Value_Tuple = unpack_arguments(a__Reduce_Structure(false), Value_Tuple...)
    #println("NOP")
    #println(Input_Tuple, " ", Output_Tuple)
    if to_infer(Input_Tuple) == false
        Output_Tuple = inference_forward(u__Nop, Input_Tuple, Output_Tuple)
    end
    if to_infer(Output_Tuple) == false
        Input_Tuple = inference_backward(u__Nop, Output_Tuple, Input_Tuple)
    end

    if Reduce_Structure == true
        return v__Nop_Wrapper_Flat()
    else
        return v__Nop_Unparametric(Name, Input_Tuple, Output_Tuple)
    end
end
export c__Nop
#'Interface'
function t__inference(::v__Type{Type}) where {Type <: u__Nop}
    return t__inference_Nop()
end
function t__inference_forward(::v__Type{Type}) where {Type <: u__Nop}
    return t__inference_forward_Nop()
end
function t__inference_backward(::v__Type{Type}) where {Type <: u__Nop}
    return t__inference_backward_Nop()
end