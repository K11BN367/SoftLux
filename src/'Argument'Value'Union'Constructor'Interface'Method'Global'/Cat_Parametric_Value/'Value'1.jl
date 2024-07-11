struct v__Cat_Parametric_Value{Name, Layer_Tuple, Dimension, Input_Tuple, Output_Tuple} <: v
    function v__Cat_Parametric_Value(Name, Layer_Tuple, Dimension, Input_Tuple, Output_Tuple)
        return new{Name, Layer_Tuple, Dimension, Input_Tuple, Output_Tuple}()
    end
end