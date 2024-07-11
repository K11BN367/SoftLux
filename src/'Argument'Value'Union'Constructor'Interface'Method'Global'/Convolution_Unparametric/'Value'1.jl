struct v__Convolution_Unparametric
	Name
	Kernel
	Activation_Function
	Pad
	Dilation
	Group
	Stride
	Input_Tuple
	Output_Tuple
	function v__Convolution_Unparametric(Name, Kernel, Activation_Function, Pad, Dilation, Group, Stride, Input_Tuple, Output_Tuple)
		return new(Name, Kernel, Activation_Function, Pad, Dilation, Group, Stride, Input_Tuple, Output_Tuple)
	end
end