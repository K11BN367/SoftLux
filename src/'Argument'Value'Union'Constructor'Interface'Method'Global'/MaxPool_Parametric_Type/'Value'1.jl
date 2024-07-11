
struct v__MaxPool_Parametric_Type{Name_Type, Window_Type, Pad_Type, Dilation_Type, Stride_Type, Input_Tuple_Type, Output_Tuple_Type, MaxPool_Wrapper_Type} <: v
    Name::Name_Type
    Window::Window_Type
    Pad::Pad_Type
    Dilation::Dilation_Type
    Stride::Stride_Type
    Input_Tuple::Input_Tuple_Type
    Output_Tuple::Output_Tuple_Type
    MaxPool_Wrapper::MaxPool_Wrapper_Type
    function v__MaxPool_Parametric_Type(Name, Window, Pad, Dilation, Stride, Input_Tuple, Output_Tuple)
        MaxPool_Wrapper = maxpool_wrapper(Window, Pad, Stride)
        return new{
            v__(Name),
            v__(Window),
            v__(Pad),
            v__(Dilation),
            v__(Stride),
            v__(Input_Tuple),
            v__(Output_Tuple),
            v__(MaxPool_Wrapper)
        }(Name, Window, Pad, Dilation, Stride, Input_Tuple, Output_Tuple, MaxPool_Wrapper)
    end
end
