function maxpool_wrapper(Window, Pad, Stride)
    local New_Window
    if v__(Window) <: Tuple
        New_Window = ()
        for Value in Window
            if Value != SoftLux.Infer && Value != SoftLux.Skip
                New_Window = (New_Window..., Value)
            end
        end
    else
        New_Window = Window
    end
    local New_Pad
    if v__(Pad) <: Tuple
        New_Pad = ()
        for Value in Pad
            if Value != SoftLux.Infer && Value != SoftLux.Skip
                New_Pad = (New_Pad..., Value)
            end
        end
    else
        New_Pad = Pad
    end
    local New_Stride
    if v__(Stride) <: Tuple
        New_Stride = ()
        for Value in Stride
            if Value != SoftLux.Infer && Value != SoftLux.Skip
                New_Stride = (New_Stride..., Value)
            end
        end
    else
        New_Stride = Stride
    end
    return Lux.MaxPool(New_Window, pad=New_Pad, stride=New_Stride)
end
struct v__MaxPool_Parametric_Wrapper{MaxPool_Wrapper} <: v
    function v__MaxPool_Parametric_Wrapper(Window, Pad, Dilation, Stride)

        MaxPool_Wrapper = maxpool_wrapper(Window, Pad, Stride)
        return MaxPool_Wrapper
        return new{MaxPool_Wrapper}()
    end
end
