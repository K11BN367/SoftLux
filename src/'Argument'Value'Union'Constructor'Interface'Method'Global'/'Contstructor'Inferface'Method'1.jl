include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("Nop/'Constructor'Interface'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("MaxPool/'Constructor'Interface'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("Upsample/'Constructor'Interface'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("Chain/'Constructor'Interface'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("Convolution/'Constructor'Interface'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("Cat/'Constructor'Interface'Method'1.jl")))
#'Interface'
function t__inference(::v)
    return t__inference()
end
function t__inference_forward(::v)
    return t__inference_forward()
end
function t__inference_backward(::v)
    return t__inference_backward()
end
function t__merge_information(::v__Tuple)
    return t__merge_information_Container()
end
function t__merge_information(::u{v__Infer, v__Skip})
    return t__merge_information_Definition()
end
function t__append_information(::v)
    return t__append_information_Information()
end
function t__append_information(::v__Tuple)
    return t__append_information_Container()
end
function t__append_information(::u{v__Infer, v__Skip})
    return t__append_information_Definition()
end
function t__setup(::u__Layer)
    return t__setup_Layer()
end
#'Method'
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("Chain_Parametric_Value/'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("Chain_Parametric_Value_Sparse/'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("Cat_Parametric_Value/'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("Cat_Parametric_Value_Sparse/'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("Cat_Parametric_Type/'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("Convolution_Parametric_Wrapper/'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("Convolution_Parametric_Value/'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("MaxPool_Parametric_Wrapper/'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("MaxPool_Parametric_Type/'Method'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("Upsample_Parametric_Value/'Method'1.jl")))
function (Layer::u{u__Chain, u__Cat, u__Convolution, u__Upsample})(Input, Parameter, State)
    return apply(Layer, Input, Parameter, State)
end
function is_chain(::v)
    return false
end
function is_parallel(::v)
    return false
end
const relu = Lux.relu; export relu
const sigmoid = Lux.sigmoid; export sigmoid

