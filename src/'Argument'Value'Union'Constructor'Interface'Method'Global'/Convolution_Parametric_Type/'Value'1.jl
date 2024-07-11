struct v__Convolution_Parametric_Type{Name_Type, Kernel_Type, Activation_Function_Type, Pad_Type, Dilation_Type, Group_Type, Stride_Type, Input_Type, Output_Type} <: v
	Name::Name_Type
	Kernel::Kernel_Type
	Activation_Function::Activation_Function_Type
	Pad::Pad_Type
	Dilation::Dilation_Type
	Group::Group_Type
	Stride::Stride_Type
	Input_Tuple::Input_Type
	Output_Tuple::Output_Type
	function v__Convolution_Parametric_Type(Name, Kernel, Activation_Function, Pad, Dilation, Group, Stride, Input_Tuple, Output_Tuple)
	return new{
		v__(Name),
		v__(Kernel),
		v__(Activation_Function),
		v__(Pad),
		v__(Dilation),
		v__(Group),
		v__(Stride),
		v__(Input_Tuple),
		v__(Output_Tuple)
	}(Name, Kernel, Activation_Function, Pad, Dilation, Group, Stride, Input_Tuple, Output_Tuple)
	end
end