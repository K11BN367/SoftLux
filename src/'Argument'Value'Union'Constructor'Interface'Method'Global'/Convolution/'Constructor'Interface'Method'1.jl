#'Constructor'
u__Argument = u{
    a__Name,
    a__Kernel,
    a__Activation_Function,
    a__Pad,
    a__Dilation,
    a__Group,
    a__Stride,
    a__Input,
    a__Output,
    a__Reduce_Structure
}
function c__Convolution(Value_Tuple::u__Argument...)
    Name,                          Value_Tuple = unpack_arguments(a__Name(Convolution_Name_Default), Value_Tuple...)
    Activation_Function,           Value_Tuple = unpack_arguments(a__Activation_Function, Value_Tuple...)
    Kernel,                        Value_Tuple = unpack_arguments(a__Kernel, Value_Tuple...)
    Pad,                           Value_Tuple = unpack_arguments(a__Pad(Convolution_Pad_Default), Value_Tuple...)
    Dilation,                      Value_Tuple = unpack_arguments(a__Dilation(Convolution_Dilation_Default), Value_Tuple...)
    Group,                         Value_Tuple = unpack_arguments(a__Group(Convolution_Group_Default), Value_Tuple...)
    Stride,                        Value_Tuple = unpack_arguments(a__Stride(Convolution_Stride_Default), Value_Tuple...)
    Input_Tuple,                   Value_Tuple = unpack_arguments(a__Input(SoftLux.Infer), Value_Tuple...)
    Output_Tuple,                  Value_Tuple = unpack_arguments(a__Output(SoftLux.Infer), Value_Tuple...)
    Reduce_Structure,              Value_Tuple = unpack_arguments(a__Reduce_Structure(false), Value_Tuple...)

    Input_Tuple, Output_Tuple = c__convolution(a__Kernel(Kernel), a__Pad(Pad), a__Dilation(Dilation), a__Stride(Stride), a__Input(Input_Tuple), a__Output(Output_Tuple))

    if Reduce_Structure == true
        return v__Convolution_Parametric_Wrapper(Kernel, Activation_Function, Pad, Dilation, Group, Stride, Input_Tuple, Output_Tuple)
    else
        return v__Convolution_Unparametric(Name, Kernel, Activation_Function, Pad, Dilation, Group, Stride, Input_Tuple, Output_Tuple)
    end
end
u__Argument = u{a__Kernel, a__Pad, a__Dilation, a__Stride, a__Input, a__Output}
function c__convolution(Value_Tuple::u__Argument...)
    Kernel,                        Value_Tuple = unpack_arguments(a__Kernel, Value_Tuple...)
    Pad,                           Value_Tuple = unpack_arguments(a__Pad(Convolution_Pad_Default), Value_Tuple...)
    Dilation,                      Value_Tuple = unpack_arguments(a__Dilation(Convolution_Dilation_Default), Value_Tuple...)
    Stride,                        Value_Tuple = unpack_arguments(a__Stride(Convolution_Stride_Default), Value_Tuple...)
    Input_Tuple,                   Value_Tuple = unpack_arguments(a__Input(SoftLux.Infer), Value_Tuple...)
    Output_Tuple,                  Value_Tuple = unpack_arguments(a__Output(SoftLux.Infer), Value_Tuple...)

    if to_infer(Input_Tuple) == false
        Output_Tuple = inference_forward(u__Convolution, Input_Tuple, Output_Tuple, Kernel, Pad, Dilation, Stride)
    end
    if to_infer(Output_Tuple) == false
        Input_Tuple = inference_backward(u__Convolution, Output_Tuple, Input_Tuple, Kernel, Pad, Dilation, Stride)
    end

    return Input_Tuple, Output_Tuple
end
export c__Convolution
#'Interface'
function t__inference(::v__Type{Type}) where {Type <: u__Convolution}
    return t__inference_Convolution()
end
function t__inference_forward(::v__Type{Type}) where {Type <: u__Convolution}
    return t__inference_forward_Convolution()
end
function t__inference_backward(::v__Type{Type}) where {Type <: u__Convolution}
    return t__inference_backward_Convolution()
end
#'Method'
function convolution_check_forward(New_Output_Tuple, Old_Output_Tuple, Kernel_Tuple, Pad, Dilation, Stride)
    for Index in firstindex(New_Output_Tuple):lastindex(New_Output_Tuple)
        if New_Output_Tuple[Index] != SoftLux.Infer && Old_Output_Tuple[Index] != SoftLux.Infer
            if New_Output_Tuple[Index] != Old_Output_Tuple[Index]
                throw(ArgumentError("Convolution Inference Error"))
            end
        end
    end
end
function convolution_check_backward(New_Input_Tuple, Old_Input_Tuple, Kernel_Tuple, Pad, Dilation, Stride)
    for Index in firstindex(New_Input_Tuple):lastindex(New_Input_Tuple)
        if New_Input_Tuple[Index] != SoftLux.Infer && Old_Input_Tuple[Index] != SoftLux.Infer
            if New_Input_Tuple[Index] != Old_Input_Tuple[Index]
                throw(ArgumentError("Convolution Inference Error"))
            end
        end
    end
end



