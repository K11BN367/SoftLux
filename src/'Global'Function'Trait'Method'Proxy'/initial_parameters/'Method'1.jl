@__function(SoftLux.initial_parameters, (Random::u__Random, Layer::u__Cat), (
    return NamedTuple{keys(Layer.Layer_Tuple)}(Lux__initial_parameters.(Random, values(Layer.Layer_Tuple)))
))
@__function(SoftLux.initial_parameters, (Random::u__Random, Layer::u__Chain), (
    return NamedTuple{keys(Layer.Layer_Tuple)}(Lux__initial_parameters.(Random, values(Layer.Layer_Tuple)))
))
@__function(SoftLux.initial_parameters, (Random::u__Random, Layer::u__Convolution), (
    return Lux__initial_parameters(Random, Layer.Conv_Wrapper)
))
@__function(SoftLux.initial_parameters, (Random::u__Random, Layer::u__MaxPool), (
    return Lux__initial_parameters(Random, Layer.MaxPool_Wrapper)
))
@__function(SoftLux.initial_parameters, (::u__Random, ::u__Upsample), (
    return NamedTuple()
))