#'Constructor'
function c__Cat(Value_Tuple::u{v, a}...)
    return c__Cat(pack_arguments(a__Layer_Tuple, Value_Tuple...)...)
end
function c__Cat(Value_Tuple::u{a__Name, a__Layer_Tuple, a__Dimension, a__Input, a__Output, a__Reduce_Structure}...)
    Name,               Value_Tuple = unpack_arguments(a__Name(Cat_Name_Default), Value_Tuple...)
    Layer_Tuple,        Value_Tuple = unpack_arguments(a__Layer_Tuple, Value_Tuple...)
    Dimension,          Value_Tuple = unpack_arguments(a__Dimension, Value_Tuple...)
    Input_Tuple,        Value_Tuple = unpack_arguments(a__Input(SoftLux.Infer), Value_Tuple...)
    Output_Tuple,       Value_Tuple = unpack_arguments(a__Output(SoftLux.Infer), Value_Tuple...)
    Reduce_Structure,   Value_Tuple = unpack_arguments(a__Reduce_Structure(false), Value_Tuple...)
    #println("CAT")
    #println(Input_Tuple, " ", Output_Tuple)
    Layer_Tuple, Input_Tuple, Output_Tuple = c__cat(a__Layer_Tuple(Layer_Tuple), a__Input(Input_Tuple), a__Output(Output_Tuple), a__Dimension(Dimension))
    #println(Input_Tuple, " ", Output_Tuple)
    #println(Layer_Tuple)
    if Reduce_Structure == true
        New_Layer_Tuple = ()
        for Layer in Layer_Tuple
            New_Layer_Tuple = (New_Layer_Tuple..., reduce_structure(Layer))
        end
        return v__Cat_Parametric_Value_Sparse(New_Layer_Tuple, Dimension)
    else
        return v__Cat_Unparametric(Name, Layer_Tuple, Dimension, Input_Tuple, Output_Tuple)
    end
end
function c__cat(Value_Tuple::u{a__Layer_Tuple, a__Input, a__Output, a__Dimension}...)
    Layer_Tuple,        Value_Tuple = unpack_arguments(a__Layer_Tuple, Value_Tuple...)
    Input_Tuple,        Value_Tuple = unpack_arguments(a__Input(SoftLux.Infer), Value_Tuple...)
    Output_Tuple,       Value_Tuple = unpack_arguments(a__Output(SoftLux.Infer), Value_Tuple...)
    Dimension,          Value_Tuple = unpack_arguments(a__Dimension, Value_Tuple...)

    if to_infer(Input_Tuple) == false
        Layer_Tuple, Input_Tuple, Output_Tuple = inference_forward(u__Cat, Layer_Tuple, Input_Tuple, Output_Tuple, Dimension)
        Layer_Tuple, Output_Tuple, Input_Tuple = inference_backward(u__Cat, Layer_Tuple, Output_Tuple, Input_Tuple, Dimension)
    end
    if to_infer(Output_Tuple) == false
        Layer_Tuple, Input_Tuple, Output_Tuple = inference_forward(u__Cat, Layer_Tuple, Input_Tuple, Output_Tuple, Dimension)
        Layer_Tuple, Output_Tuple, Input_Tuple = inference_backward(u__Cat, Layer_Tuple, Output_Tuple, Input_Tuple, Dimension)
    end
    Layer_Tuple, Input_Tuple, Output_Tuple = inference(u__Cat, Layer_Tuple, Input_Tuple, Output_Tuple, Dimension)

    return Layer_Tuple, Input_Tuple, Output_Tuple
end
export c__Cat
#'Interface'
function t__inference(::v__Type{Type}) where {Type <: u__Cat}
    return t__inference_Cat()
end
function t__inference_forward(::v__Type{Type}) where {Type <: u__Cat}
    return t__inference_forward_Cat()
end
function t__inference_backward(::v__Type{Type}) where {Type <: u__Cat}
    return t__inference_backward_Cat()
end
#'Method'
function is_parallel(::u__Cat)
    return true
end