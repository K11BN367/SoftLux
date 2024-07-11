
struct v__Upsample_Parametric_Value{Name, Mode, Scale, Input_Tuple, Output_Tuple} <: v
    function v__Upsample_Parametric_Value(Name, Mode, Scale, Input_Tuple, Output_Tuple)
        return new{Name, Mode, Scale, Input_Tuple, Output_Tuple}()
    end
end
