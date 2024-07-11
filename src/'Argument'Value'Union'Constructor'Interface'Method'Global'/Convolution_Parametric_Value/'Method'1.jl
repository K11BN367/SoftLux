function getproperty(
	::v__Convolution_Parametric_Value{Name,Kernel, Activation_Function, Pad, Dilation, Group, Stride, Input_Tuple, Output_Tuple},
	Property::c__Symbol
	) where {Name, Kernel, Activation_Function, Pad, Dilation, Group, Stride, Input_Tuple, Output_Tuple}
	if Property == c__Symbol("Kernel")
		return Kernel
	elseif Property == c__Symbol("Activation_Function")
		return Activation_Function
	elseif Property == c__Symbol("Pad")
		return Pad
	elseif Property == c__Symbol("Dilation")
		return Dilation
	elseif Property == c__Symbol("Group")
		return Group
	elseif Property == c__Symbol("Stride")
		return Stride
	elseif Property == c__Symbol("Input_Tuple")
		return Input_Tuple
	elseif Property == c__Symbol("Output_Tuple")
		return Output_Tuple
	elseif Property == c__Symbol("Name")
		return Name
	end
end