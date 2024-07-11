function getproperty(
    ::v__Upsample_Parametric_Value{Name, Mode, Scale, Input_Tuple, Output_Tuple},
    Property::c__Symbol
    ) where {Name, Mode, Scale, Input_Tuple, Output_Tuple}
    if Property == c__Symbol("Name")
        return Name
    elseif Property == c__Symbol("Mode")
        return Mode
    elseif Property == c__Symbol("Scale")
        return Scale
    elseif Property == c__Symbol("Input_Tuple")
        return Input_Tuple
    elseif Property == c__Symbol("Output_Tuple")
        return Output_Tuple
    end
end
