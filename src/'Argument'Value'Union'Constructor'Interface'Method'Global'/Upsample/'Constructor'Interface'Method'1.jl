#'Constructor'
u__Argument = u{a__Name, a__Mode, a__Scale, a__Input, a__Output, a__Reduce_Structure}
function c__Upsample(Value_Tuple::u__Argument...)
	Name, Value_Tuple = unpack_arguments(a__Name(Upsample_Name_Default), Value_Tuple...)
	Mode, Value_Tuple = unpack_arguments(a__Mode, Value_Tuple...)
	Scale, Value_Tuple = unpack_arguments(a__Scale(SoftLux.Infer), Value_Tuple...)
	Input_Tuple, Value_Tuple = unpack_arguments(a__Input(SoftLux.Infer), Value_Tuple...)
	Output_Tuple, Value_Tuple = unpack_arguments(a__Output(SoftLux.Infer), Value_Tuple...)
    Reduce_Structure, Value_Tuple = unpack_arguments(a__Reduce_Structure(false), Value_Tuple...)
    
	Input_Tuple, Output_Tuple = c__Upsample(a__Scale(Scale), a__Input(Input_Tuple), a__Output(Output_Tuple))

    if Reduce_Structure == true
        return v__Upsample_Parametric_Wrapper(Mode, Output_Tuple)
    else
        return v__Upsample_Unparametric(Name, Mode, Scale, Input_Tuple, Output_Tuple)
    end
end
u__Argument = u{a__Scale, a__Input, a__Output}
function c__Upsample(Value_Tuple::u__Argument...)
	Scale, Value_Tuple = unpack_arguments(a__Scale(SoftLux.Infer), Value_Tuple...)
	Input_Tuple, Value_Tuple = unpack_arguments(a__Input(SoftLux.Infer), Value_Tuple...)
	Output_Tuple, Value_Tuple = unpack_arguments(a__Output(SoftLux.Infer), Value_Tuple...)
    
    if to_infer(Scale) == false
        if to_infer(Input_Tuple) == false
            Input_Tuple, Output_Tuple = inference_forward(u__Upsample, Input_Tuple, Output_Tuple, Scale)
            Output_Tuple, Input_Tuple = inference_backward(u__Upsample, Output_Tuple, Input_Tuple, Scale)
        elseif to_infer(Output_Tuple) == false
            Output_Tuple, Input_Tuple = inference_backward(u__Upsample, Output_Tuple, Input_Tuple, Scale)
            Input_Tuple, Output_Tuple = inference_forward(u__Upsample, Input_Tuple, Output_Tuple, Scale)
        end
    end
    
    return Input_Tuple, Output_Tuple
end
export c__Upsample
#'Interface'
function t__inference(::v__Type{Type}) where {Type <: u__Upsample}
    return t__inference_Upsample()
end
function t__inference_forward(::v__Type{Type}) where {Type <: u__Upsample}
    return t__inference_forward_Upsample()
end
function t__inference_backward(::v__Type{Type}) where {Type <: u__Upsample}
    return t__inference_backward_Upsample()
end
#'Method'
function upsample_bilinear(x, scale, align_corners::Bool)
    return upsample_linear(x, scale, align_corners)
end
function upsample_bilinear(x::AbstractArray{<: Any, N}, scale::Real, align_corners::Bool) where N
 return upsample_linear(x, ntuple(_ -> scale, N-2), align_corners)
end
function upsample_linear(x::AbstractArray{T, <: Any}, size, align_corners::Bool) where T<:Integer
 y = float.(x)
 res = upsample_linear(y, size, align_corners)
 return round.(T, res)
end
function upsample_linear(x::AbstractArray{<: Any, N}, scale::NTuple{M, Real}, align_corners::Bool) where {N,M}
 M == N-2 || error("The scale argument should be an NTuple with length $(N-2), but it has length $M.")
 outsize = ntuple(i -> floor(Int, scale[i] * Base.size(x, i)), N-2)
 return upsample_linear(x, outsize, align_corners)
end

# this actually calls the upsamling kernel
function upsample_linear(x::AbstractArray{T,N}, size::Union{Integer, NTuple{<:Any,Integer}}, align_corners::Bool) where {T,N}
  length(size) == N-2 || error("The scale argument should be an NTuple with length $(N-2), but it has length $(length(size)).")

  if Base.size(x)[1:N-2] == size
    return x
  end

  y = similar(x, T, size..., Base.size(x)[end-1:end]...)
  return NNlib.upsample_linear_kernel!(y, x; align_corners)
end
function ∇upsample_linear(Δ::AbstractArray{T,N}, size::NTuple{<:Any,Integer}, align_corners::Bool) where {T,N}
  if Base.size(Δ)[1:N-2] == size
    return Δ
  end
  dx = fill!(similar(Δ, T, size..., Base.size(Δ)[end-1:end]...), zero(T))
  return NNlib.∇upsample_linear_kernel!(dx, Δ; align_corners)
end

function NNlib.rrule(::v__(upsample_linear), x::AbstractArray{<:Any,N}, size, align_corners::Bool) where N
  Ω = upsample_linear(x, size, align_corners)
  function upsample_linear_pullback(Δ)
    (NNlib.NoTangent(), ∇upsample_linear(NNlib.unthunk(Δ), Base.size(x)[1:N-2], align_corners), NNlib.NoTangent(), NNlib.NoTangent())
  end
  return Ω, upsample_linear_pullback
end