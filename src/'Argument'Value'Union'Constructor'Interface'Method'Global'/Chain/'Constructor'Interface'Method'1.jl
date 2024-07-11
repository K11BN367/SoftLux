#'Constructor'
u__Argument = u{v, a}
function c__Chain(Value_Tuple::u__Argument...)
 	return c__Chain(pack_arguments(a__Layer_Tuple, Value_Tuple...)...)
end
u__Argument = u{a__Layer_Tuple, a__Name, a__Input, a__Output, a__Reduce_Structure}
function c__Chain(Value_Tuple::u__Argument...)
    Name,               Value_Tuple = unpack_arguments(a__Name(Chain_Name_Default), Value_Tuple...)
    Layer_Tuple,        Value_Tuple = unpack_arguments(a__Layer_Tuple, Value_Tuple...)
    Input_Tuple,        Value_Tuple = unpack_arguments(a__Input(SoftLux.Infer), Value_Tuple...)
    Output_Tuple,       Value_Tuple = unpack_arguments(a__Output(SoftLux.Infer), Value_Tuple...)
    Reduce_Structure,   Value_Tuple = unpack_arguments(a__Reduce_Structure(false), Value_Tuple...)
    #println("CHAIN")
    Layer_Tuple, Input_Tuple, Output_Tuple = c__chain(a__Layer_Tuple(Layer_Tuple), a__Input(Input_Tuple), a__Output(Output_Tuple))
    #println(Input_Tuple, " ", Output_Tuple)
    #println(Layer_Tuple)

    if Reduce_Structure == true
        New_Layer_Tuple = ()
        for Layer in Layer_Tuple
            New_Layer_Tuple = (New_Layer_Tuple..., reduce_structure(Layer))
        end
        return v__Chain_Parametric_Value_Sparse(New_Layer_Tuple)
    else
        return v__Chain_Unparametric(Name, Layer_Tuple, Input_Tuple, Output_Tuple)
    end
end
u__Argument = u{a__Layer_Tuple, a__Input, a__Output}
function c__chain(Value_Tuple::u__Argument...)
    Layer_Tuple,        Value_Tuple = unpack_arguments(a__Layer_Tuple, Value_Tuple...)
    Input_Tuple,        Value_Tuple = unpack_arguments(a__Input(SoftLux.Infer), Value_Tuple...)
    Output_Tuple,       Value_Tuple = unpack_arguments(a__Output(SoftLux.Infer), Value_Tuple...)

    if to_infer(Input_Tuple) == false
        Layer_Tuple = inference_forward(u__Chain, Layer_Tuple, Input_Tuple)
    end
    if to_infer(Output_Tuple) == false
        Layer_Tuple = inference_backward(u__Chain, Layer_Tuple, Output_Tuple)
    end
    Layer_Tuple = inference(u__Chain, Layer_Tuple)

    Input_Tuple = Layer_Tuple[firstindex(Layer_Tuple)].Input_Tuple
    Output_Tuple = Layer_Tuple[lastindex(Layer_Tuple)].Output_Tuple

    return Layer_Tuple, Input_Tuple, Output_Tuple
end
export c__Chain
#'Interface'
function t__inference(::v__Type{Type}) where {Type <: u__Chain}
    return t__inference_Chain()
end
function t__inference_forward(::v__Type{Type}) where {Type <: u__Chain}
    return t__inference_forward_Chain()
end
function t__inference_backward(::v__Type{Type}) where {Type <: u__Chain}
    return t__inference_backward_Chain()
end
#'Method'
function is_chain(::u__Chain)
    return true
end
function chain_check_forward(Layer_Tuple, Layer_Tuple_Index, Input_Tuple)
    if Input_Tuple != SoftLux.Infer && Layer_Tuple[Layer_Tuple_Index].Input_Tuple != SoftLux.Infer && Input_Tuple != Layer_Tuple[Layer_Tuple_Index].Input_Tuple
        for Input_Tuple_Index in firstindex(Input_Tuple):lastindex(Input_Tuple)
            if Input_Tuple[Input_Tuple_Index] != SoftLux.Infer && Layer_Tuple[Layer_Tuple_Index].Input_Tuple[Input_Tuple_Index] != SoftLux.Infer && Input_Tuple[Input_Tuple_Index] != Layer_Tuple[Layer_Tuple_Index].Input_Tuple[Input_Tuple_Index]
                if Layer_Tuple_Index - 1 >= firstindex(Layer_Tuple)
                    throw(
                        ArgumentError(
                            string(
                                "Chain Inference Error: Input Dimension mismatch between Layer ",
                                Layer_Tuple[Layer_Tuple_Index - 1].Name,
                                " and Layer ",
                                Layer_Tuple[Layer_Tuple_Index].Name,
                                ". Layer ",
                                Layer_Tuple[Layer_Tuple_Index - 1].Name,
                                " has Output ",
                                Input_Tuple,
                                " and Layer ",
                                Layer_Tuple[Layer_Tuple_Index].Name,
                                " has Input ",
                                Layer_Tuple[Layer_Tuple_Index].Input_Tuple,
                                "."
                            )
                        )
                    )
                else
                    throw(
                        ArgumentError(
                            string(
                                "Input Dimension mismatch between Chain and Layer ",
                                Layer_Tuple[Layer_Tuple_Index].Name,
                                ". Chain has Input ",
                                Input_Tuple,
                                " and Layer ",
                                Layer_Tuple[Layer_Tuple_Index].Name,
                                " has Input ",
                                Layer_Tuple[Layer_Tuple_Index].Input_Tuple,
                                "."
                            )
                        )
                    )
                end
            end
        end
    end
end
function chain_check_backward(Layer_Tuple, Layer_Tuple_Index, Output_Tuple)
    if Output_Tuple != SoftLux.Infer && Layer_Tuple[Layer_Tuple_Index].Output_Tuple != SoftLux.Infer && Output_Tuple != Layer_Tuple[Layer_Tuple_Index].Output_Tuple
        for Output_Tuple_Index in firstindex(Output_Tuple):lastindex(Output_Tuple)
            if Output_Tuple[Output_Tuple_Index] != SoftLux.Infer && Layer_Tuple[Layer_Tuple_Index].Output_Tuple[Output_Tuple_Index] != SoftLux.Infer && Output_Tuple[Output_Tuple_Index] != Layer_Tuple[Layer_Tuple_Index].Output_Tuple[Output_Tuple_Index]
                if Layer_Tuple_Index + 1 <= lastindex(Layer_Tuple)
                    throw(
                        ArgumentError(
                            string(
                                "Chain Inference Error: Output Dimension mismatch between Layer ",
                                Layer_Tuple[Layer_Tuple_Index].Name,
                                " and Layer ",
                                Layer_Tuple[Layer_Tuple_Index + 1].Name,
                                ". Layer ",
                                Layer_Tuple[Layer_Tuple_Index].Name,
                                " has Output ",
                                Layer_Tuple[Layer_Tuple_Index].Output_Tuple,
                                " and Layer ",
                                Layer_Tuple[Layer_Tuple_Index + 1].Name,
                                " has Input ",
                                Output_Tuple,
                                "."
                            )
                        )
                    )
                else
                    throw(
                        ArgumentError(
                            string(
                                "Output Dimension mismatch between Layer ",
                                Layer_Tuple[Layer_Tuple_Index].Name,
                                " and Chain. Layer ",
                                Layer_Tuple[Layer_Tuple_Index].Name,
                                " has Output ",
                                Layer_Tuple[Layer_Tuple_Index].Output_Tuple,
                                " and Chain has Output ",
                                Output_Tuple,
                                "."
                            )
                        )
                    )
                end
            end
        end
    end
end
function construct_layers(Layer_Tuple)
    Name_Tuple = ()
    
    for Index in eachindex(Layer_Tuple)
     Name_Tuple = (Name_Tuple..., Symbol(string("layer_", Index)))
    end
    
    
    #=
    Index = 1
    Name_Tuple = __for((Name_Tuple, Index, Layer)->((Name_Tuple..., Symbol(:(layer_), Index)), Index + 1), (Name_Tuple, Index), Layer_Tuple...)[1]
    =#
   
    return NamedTuple{Name_Tuple}(Layer_Tuple)
    #return Name_Tuple
   end