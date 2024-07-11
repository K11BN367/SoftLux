#'Method'
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("initial_parameters/'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("initial_states/'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("reduce_structure/'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("show_layer/'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("inference/'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("inference_forward/'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("inference_backward/'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("setup/'Method'1.jl")))
function compress_information(Value_Tuple)
    if (v__(Value_Tuple) <: v__Infer) == false
        for Index in firstindex(Value_Tuple):lastindex(Value_Tuple)
            if Value_Tuple[Index] != SoftLux.Infer
                return Value_Tuple
            end
        end
    end
    return SoftLux.Infer
end
function expand_information(Value, Length)
    if (v__(Value) <: v__Tuple) == false
        return ntuple((_)->(Value), Length)
    else
        return Value
    end
end
function merge_information(::t__merge_information_Container, Value_1, ::t__merge_information_Container, Value_2)
    New_Value = ()
    
    for Tuple_Index in firstindex(Value_1):lastindex(Value_1)
        if Value_1[Tuple_Index] != SoftLux.Infer
            New_Value = (New_Value..., Value_1[Tuple_Index])
        else
            New_Value = (New_Value..., Value_2[Tuple_Index])
        end
    end
    
    #=
    New_Value = __for(
        function (New_Value, Tuple_Index)
            if Value_1[Tuple_Index] != SoftLux.Infer
                New_Value = (New_Value..., Value_1[Tuple_Index])
            else
                New_Value = (New_Value..., Value_2[Tuple_Index])
            end
            return (New_Value,)
        end,
        (New_Value,),
        (firstindex(Value_1):lastindex(Value_1))...
    )[1]
    =#
    return New_Value
end
function merge_information(::t__merge_information_Definition, ::v, ::t__merge_information_Container, Value)
    return Value
end
function merge_information(::t__merge_information_Container, Value, ::t__merge_information_Definition, ::v)
    return Value
end
function append_information(::t__append_information_Container, Value_1, ::t__append_information_Definition, Value_2, ::v, ::v)
    return (Value_1..., Value_2)
end
function append_information(::t__append_information_Container, Value_1, ::t__append_information_Container, Value_2, ::t__append_information_Information, Value_3)
    return (Value_1..., Value_2[Value_3])
end
function append_information(::t__append_information_Container, Value_1, ::v, Value_2)
    return (Value_1..., Value_2)
end
function to_skip(Value)
    return Value == SoftLux.Skip
end
function to_skip(Value, Index)
    Return = to_skip(Value)
    if Return == false
        Return = to_skip(Value[Index])
    end
    return Return
end
function to_infer(Value)
    return Value == SoftLux.Infer
end
function to_infer(Value, Index)
    Return = to_infer(Value)
    if Return == false
        Return = to_infer(Value[Index])
    end
    return Return
end
#'Proxy'
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("initial_parameters/'Proxy'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("initial_states/'Proxy'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("reduce_structure/'Proxy'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("show_layer/'Proxy'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("inference/'Proxy'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("inference_forward/'Proxy'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("inference_backward/'Proxy'1.jl")))
function merge_information(Value_1, Value_2)
    return merge_information(t__merge_information(Value_1), Value_1, t__merge_information(Value_2), Value_2)
end
function append_information(Value_1, Value_2)
    return append_information(t__append_information(Value_1), Value_1, t__append_information(Value_2), Value_2)
end
function append_information(Value_1, Value_2, Value_3)
    return append_information(t__append_information(Value_1), Value_1, t__append_information(Value_2), Value_2, t__append_information(Value_3), Value_3)
end