struct v__MaxPool_Unparametric <: v
    Name
    Window
    Pad
    Dilation
    Stride
    Input_Tuple
    Output_Tuple
    function v__MaxPool_Unparametric(Name, Window, Pad, Dilation, Stride, Input_Tuple, Output_Tuple)
        return new(Name, Window, Pad, Dilation, Stride, Input_Tuple, Output_Tuple)
    end
end