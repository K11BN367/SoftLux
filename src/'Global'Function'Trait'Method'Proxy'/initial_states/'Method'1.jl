@__function(SoftLux.initial_states, (Random::u__Random, Layer::u__Cat), (
    return NamedTuple{keys(Layer.Layer_Tuple)}(Lux__initial_states.(Random, values(Layer.Layer_Tuple)))
))
@__function(SoftLux.initial_states, (Random::u__Random, Layer::u__Chain), (
    return NamedTuple{keys(Layer.Layer_Tuple)}(Lux__initial_states.(Random, values(Layer.Layer_Tuple)))
))
@__function(SoftLux.initial_states, (Random::u__Random, Layer::u__Convolution), (
    return Lux__initial_states(Random, Layer.Conv_Wrapper)
))
@__function(SoftLux.initial_states, (Random::u__Random, Layer::u__MaxPool), (
    return Lux__initial_states(Random, Layer.MaxPool_Wrapper)
))
@__function(SoftLux.initial_states, (::u__Random, ::u__Upsample), (
    return NamedTuple()
))