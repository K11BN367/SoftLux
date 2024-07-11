struct v__Upsample_Parametric_Wrapper{Mode, Output_Tuple} <: v
    function v__Upsample_Parametric_Wrapper(Mode, Output_Tuple)
        return new{Mode, Output_Tuple}()
    end
end
