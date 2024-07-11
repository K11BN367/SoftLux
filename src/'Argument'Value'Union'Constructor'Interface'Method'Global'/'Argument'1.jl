struct a__Name{Type} <: a
    Value::Type
    function a__Name(Value)
        return new{v__(Value)}(Value)
    end
end
export a__Name
struct a__Connection{Type} <: a
    Value::Type
    function a__Connection(Value)
        return new{v__(Value)}(Value)
    end
end
export a__Connection
struct a__Layer_Tuple{Type} <: a
    Value::Type
    function a__Layer_Tuple(Value...)
        return new{v__(Value)}(Value)
    end
    function a__Layer_Tuple(Value)
        return new{v__(Value)}(Value)
    end
end
export a__Layer_Tuple
struct a__Input{Type} <: a
    Value::Type
    function a__Input(Value...)
        return new{v__(Value)}(Value)
    end
    function a__Input(Value)
        return new{v__(Value)}(Value)
    end
end
export a__Input
struct a__Output{Type} <: a
    Value::Type
    function a__Output(Value...)
        return new{v__(Value)}(Value)
    end
    function a__Output(Value)
        return new{v__(Value)}(Value)
    end
end
export a__Output
struct a__Reduce_Structure{Type} <: a
    Value::Type
    function a__Reduce_Structure(Value)
        return new{v__(Value)}(Value)
    end
end
export a__Reduce_Structure
struct a__Dimension{Type} <: a
    Value::Type
    function a__Dimension(Value)
        return new{v__(Value)}(Value)
    end
end
export a__Dimension
struct a__Kernel{Type} <: a
	Value::Type
	function a__Kernel(Value...)
		return new{v__(Value)}(Value)
	end
	function a__Kernel(Value)
		return new{v__(Value)}(Value)
	end
end
export a__Kernel
struct a__Activation_Function{Type} <: a
	Value::Type
	function a__Activation_Function(Value)
		return new{v__(Value)}(Value)
	end
end
export a__Activation_Function
struct a__Pad{Type} <: a
	Value::Type
    function a__Pad(Value)
        return new{v__(Value)}(Value)
    end
	function a__Pad(Value...)
        return new{v__(Value)}(Value)
    end
    function a__Pad(Value::Tuple)
        return a__Pad(Value...)
    end
end
export a__Pad
struct a__Dilation{Type} <: a
	Value::Type
    function a__Dilation(Value)
        return new{v__(Value)}(Value)
    end
	function a__Dilation(Value...)
        return new{v__(Value)}(Value)
    end
end
export a__Dilation
struct a__Stride{Type} <: a
	Value::Type
    function a__Stride(Value)
        return new{v__(Value)}(Value)
    end
	function a__Stride(Value...)
        return new{v__(Value)}(Value)
    end
end
export a__Stride
struct a__Group{Type} <: a
	Value::Type
	function a__Group(Value)
		return new{v__(Value)}(Value)
	end
end
export a__Group
struct a__Init_Weight{Type} <: a
	Value::Type
	function a__Init_Weight(Value)
		return new{v__(Value)}(Value)
	end
end
export a__Init_Weight
struct a__Init_Bias{Type} <: a
	Value::Type
	function a__Init_Bias(Value)
		return new{v__(Value)}(Value)
	end
end
export a__Init_Bias
struct a__Window{Type} <: a
    Value::Type
    function a__Window(Value...)
        return new{v__(Value)}(Value)
    end
    function a__Window(Value)
        return new{v__(Value)}(Value)
    end
end
export a__Window
struct a__Scale{Type} <: a
    Value::Type
    function a__Scale(Value...)
        return new{v__(Value)}(Value)
    end
    function a__Scale(Value)
        return new{v__(Value)}(Value)
    end
end
export a__Scale
struct a__Mode{Type} <: a
    Value::Type
    function a__Mode(Value)
        return new{v__(Value)}(Value)
    end
end
export a__Mode