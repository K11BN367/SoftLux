struct v__Upsample_Parametric_Type{Name_Type, Mode_Type, Scale_Type, Input_Type, Output_Type} <: v
    Name::Name_Type
    Mode::Mode_Type
    Scale::Scale_Type
    Input_Tuple::Input_Type
    Output_Tuple::Output_Type
    function v__Upsample_Parametric_Type(Name, Mode, Scale, Input_Tuple, Output_Tuple)
        return new{
            v__(Name),
            v__(Mode),
            v__(Scale),
            v__(Input_Tuple),
            v__(Output_Tuple)
        }(Name, Mode, Scale, Input_Tuple, Output_Tuple)
    end
end