#'Constructor'
u__Argument = u{
    a__Name,
    a__Window,
    a__Pad,
    a__Dilation,
    a__Stride,
    a__Input,
    a__Output,
    a__Reduce_Structure
}
function c__MaxPool(Value_Tuple::u__Argument...)
    Name,                          Value_Tuple = unpack_arguments(a__Name(MaxPool_Name_Default), Value_Tuple...)
    Window,                        Value_Tuple = unpack_arguments(a__Window, Value_Tuple...)
    Pad,                           Value_Tuple = unpack_arguments(a__Pad(MaxPool_Pad_Default), Value_Tuple...)
    Dilation,                      Value_Tuple = unpack_arguments(a__Dilation(MaxPool_Dilation_Default), Value_Tuple...)
    Stride,                        Value_Tuple = unpack_arguments(a__Stride(Window), Value_Tuple...)
    Input_Tuple,                   Value_Tuple = unpack_arguments(a__Input(SoftLux.Infer), Value_Tuple...)
    Output_Tuple,                  Value_Tuple = unpack_arguments(a__Output(SoftLux.Infer), Value_Tuple...)
    Reduce_Structure,              Value_Tuple = unpack_arguments(a__Reduce_Structure(false), Value_Tuple...)
    #println("MAXPOOL")
    Input_Tuple, Output_Tuple = c__MaxPool(a__Window(Window), a__Pad(Pad), a__Dilation(Dilation), a__Stride(Stride), a__Input(Input_Tuple), a__Output(Output_Tuple))
    #println(Input_Tuple, " ", Output_Tuple)
    if Reduce_Structure == true
        return v__MaxPool_Parametric_Wrapper(Window, Pad, Dilation, Stride)

    else
        return v__MaxPool_Unparametric(Name, Window, Pad, Dilation, Stride, Input_Tuple, Output_Tuple)
    end
end
u__Argument = u{a__Window, a__Pad, a__Dilation, a__Stride, a__Input, a__Output}
function c__MaxPool(Value_Tuple::u__Argument...)
    Window,                        Value_Tuple = unpack_arguments(a__Window, Value_Tuple...)
    Pad,                           Value_Tuple = unpack_arguments(a__Pad(MaxPool_Pad_Default), Value_Tuple...)
    Dilation,                      Value_Tuple = unpack_arguments(a__Dilation(MaxPool_Dilation_Default), Value_Tuple...)
    Stride,                        Value_Tuple = unpack_arguments(a__Stride(Window), Value_Tuple...)
    Input_Tuple,                   Value_Tuple = unpack_arguments(a__Input(SoftLux.Infer), Value_Tuple...)
    Output_Tuple,                  Value_Tuple = unpack_arguments(a__Output(SoftLux.Infer), Value_Tuple...)

    if Input_Tuple != SoftLux.Infer
        Input_Tuple, Output_Tuple = inference_forward(u__MaxPool, Input_Tuple, Output_Tuple, Window, Pad, Dilation, Stride)
    end
    if Output_Tuple != SoftLux.Infer
        Output_Tuple, Input_Tuple = inference_backward(u__MaxPool, Output_Tuple, Input_Tuple, Window, Pad, Dilation, Stride)
    end

    return Input_Tuple, Output_Tuple
end
export c__MaxPool
#'Interface'
function t__inference(::v__Type{Type}) where {Type <: u__MaxPool}
    return t__inference_MaxPool()
end
function t__inference_forward(::v__Type{Type}) where {Type <: u__MaxPool}
    return t__inference_forward_Convolution()
end
function t__inference_backward(::v__Type{Type}) where {Type <: u__MaxPool}
    return t__inference_backward_Convolution()
end