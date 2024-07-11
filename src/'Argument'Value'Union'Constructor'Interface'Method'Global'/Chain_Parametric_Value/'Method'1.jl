@__function(
    SoftBase.get_property,
    (
        ::v__Chain_Parametric_Value{Name, Layer_Tuple, Input_Tuple, Output_Tuple},
        Property::v__Symbol
    ),
    {Name, Layer_Tuple, Input_Tuple, Output_Tuple},
    (
        if Property == c__Symbol("Name")
            return Name
        elseif Property == c__Symbol("Layer_Tuple")
            return Layer_Tuple
        elseif Property == c__Symbol("Input_Tuple")
            return Input_Tuple
        elseif Property == c__Symbol("Output_Tuple")
            return Output_Tuple
        end
    )
)