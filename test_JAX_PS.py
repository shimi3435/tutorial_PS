import jax
import jax.numpy as jnp

print("devices:", jax.devices())

x = jnp.ones((1000, 1000))
y = jnp.dot(x, x).block_until_ready()

print("x.device:", x.device)
print("y.device:", y.device)