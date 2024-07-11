struct v__Convolution_Parametric_Value{Name, Kernel, Activation_Function, Pad, Dilation, Group, Stride, Input_Tuple, Output_Tuple} <: v
	function v__Convolution_Parametric_Value(Name, Kernel, Activation_Function, Pad, Dilation, Group, Stride, Input_Tuple, Output_Tuple)
		return new{Name, Kernel, Activation_Function, Pad, Dilation, Group, Stride, Input_Tuple, Output_Tuple}()
	end
end
