struct t__setup_Layer <: t end
@__function(
    SoftOptimisers.setup,
    (
        ::t__setup, Value_1,
        ::t__setup_Layer, Value_2,
    ),
    (
        return Lux__setup(Value_1, Value_2)
    )
)