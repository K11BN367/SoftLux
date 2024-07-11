
function getproperty(
    ::v__Cat_Parametric_Value{Name, Layer_Tuple, Dimension, Input_Tuple, Output_Tuple},
    Property::c__Symbol
    ) where {Name, Layer_Tuple, Dimension, Input_Tuple, Output_Tuple}
    if Property == c__Symbol("Name")
        return Name
    elseif Property == c__Symbol("Layer_Tuple")
        return Layer_Tuple
    elseif Property == c__Symbol("Dimension")
        return Dimension
    elseif Property == c__Symbol("Input_Tuple")
        return Input_Tuple
    elseif Property == c__Symbol("Output_Tuple")
        return Output_Tuple
    end
end