function v__convolution_parametric_wrapper(Kernel, Activation_Function, Pad, Dilation, Group, Stride, Input_Tuple, Output_Tuple)
    if to_infer(Input_Tuple) == false && (true in to_infer.(Input_Tuple)) == false && to_infer(Output_Tuple) == false && (true in to_infer.(Output_Tuple)) == false
        local Input_Channels
        local Output_Channels
        New_Kernel = ()
        #for Value in Kernel
        for Index in eachindex(Kernel)
            Value = Kernel[Index]
            if Value != SoftLux.Infer && Value != SoftLux.Skip
                New_Kernel = (New_Kernel..., Value)
            else
                Input_Channels = Input_Tuple[Index]
                Output_Channels = Output_Tuple[Index]
            end
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
        local New_Dilation
        if v__(Dilation) <: Tuple
            New_Dilation = ()
            for Value in Dilation
                if Value != SoftLux.Infer && Value != SoftLux.Skip
                    New_Dilation = (New_Dilation..., Value)
                end
            end
        else
            New_Dilation = Dilation
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
        return Lux.Conv(New_Kernel, Input_Channels=>Output_Channels, Activation_Function, pad=New_Pad, stride=New_Stride, dilation=New_Dilation, groups=Group)
    else
        return  nothing
    end
end
struct v__Convolution_Parametric_Wrapper{Conv_Wrapper} <: v
    function v__Convolution_Parametric_Wrapper(Kernel, Activation_Function, Pad, Dilation, Group, Stride, Input_Tuple, Output_Tuple)
        Conv_Wrapper = v__convolution_parametric_wrapper(Kernel, Activation_Function, Pad, Dilation, Group, Stride, Input_Tuple, Output_Tuple)
        return Conv_Wrapper
        return new{Conv_Wrapper}()
    end
end