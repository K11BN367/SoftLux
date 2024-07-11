#'Function'
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("initial_parameters/'Function'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("initial_states/'Function'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("show_layer/'Function'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("reduce_structure/'Function'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("inference/'Function'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("inference_forward/'Function'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("inference_backward/'Function'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("setup/'Function'1.jl")))
include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("apply/'Function'1.jl")))
#'Trait'
struct t__inference <: t end
struct t__inference_Chain <: t end
struct t__inference_Cat <: t end
struct t__inference_Convolution <: t end
struct t__inference_MaxPool <: t end
struct t__inference_Nop <: t end
struct t__inference_Upsample <: t end

struct t__inference_forward <: t end
struct t__inference_forward_Chain <: t end
struct t__inference_forward_Cat <: t end
struct t__inference_forward_Convolution <: t end
struct t__inference_forward_Nop <: t end
struct t__inference_forward_Upsample <: t end

struct t__inference_backward <: t end
struct t__inference_backward_Chain <: t end
struct t__inference_backward_Cat <: t end
struct t__inference_backward_Convolution <: t end
struct t__inference_backward_Nop <: t end
struct t__inference_backward_Upsample <: t end

struct t__merge_information <: t end
struct t__merge_information_Container <: t end
struct t__merge_information_Definition <: t end

struct t__append_information <: t end
struct t__append_information_Container <: t end
struct t__append_information_Definition <: t end
struct t__append_information_Information <: t end


