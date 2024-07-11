const u__Chain = u{
    v__Chain_Parametric_Value,
    v__Chain_Parametric_Type,
    v__Chain_Unparametric,
    v__Chain_Parametric_Value_Sparse
}
const u__Cat = u{
    v__Cat_Unparametric,
    v__Cat_Parametric_Value,
    v__Cat_Parametric_Type,
    v__Cat_Parametric_Value_Sparse
}
const u__Convolution = u{
    v__Convolution_Parametric_Value,
    v__Convolution_Parametric_Type,
    v__Convolution_Unparametric,
    v__Convolution_Parametric_Wrapper
}
u__MaxPool = u{
    v__MaxPool_Unparametric,
    v__MaxPool_Parametric_Type,
    v__MaxPool_Parametric_Wrapper
}
u__Nop = u{
    v__Nop_Unparametric,
    v__Nop_Wrapper_Flat
}
u__Upsample = u{
    v__Upsample_Unparametric,
    v__Upsample_Parametric_Wrapper,
    v__Upsample_Parametric_Value,
    v__Upsample_Parametric_Type
}
u__Layer = u{
    u__Chain,
    u__Cat,
    u__Convolution,
    u__MaxPool,
    u__Nop,
    u__Upsample
}