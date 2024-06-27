// CuNNy 2x8
// Copyright (c) 2024 cunnyplapper

// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 3.0 of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this program.  If not, see <https://www.gnu.org/licenses/>.
/* ------------------------------------------------------------------- */


//!DESC [CuNNy_2x8] -in
//!HOOK LUMA
//!COMPUTE 16 8 8 8
//!BIND LUMA
//!SAVE in
//!WIDTH LUMA.w 2 *
//!HEIGHT LUMA.h
//!COMPONENTS 4
//!WHEN OUTPUT.w LUMA.w / 1.2 > OUTPUT.h LUMA.h / 1.2 > *
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#ifdef GL_EXT_shader_explicit_arithmetic_types_float16
#	define V4 f16vec4
#	define M4 f16mat4
#	define F float16_t
#else
#	define V4 vec4
#	define M4 mat4
#	define F float
#endif
#define l0(x, y) F(LUMA_tex((vec2(clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(1, 1) + ivec2(0, 0)) + vec2(0.5)) * LUMA_pt).r)
shared F G[1][10][10];
void hook() {
	ivec2 xy = ivec2(gl_LocalInvocationID.xy);
	ivec2 pos = ivec2(gl_WorkGroupID.xy) * ivec2(8, 8) + xy;
	ivec2 opos = pos * ivec2(2, 1);
	ivec2 sz = ivec2(LUMA_size) - ivec2(1);
	for (int y = 0; y < 10; y += 8) {
		int ay = xy.y + y;
		if (ay >= 10) break;
		for (int x = 0; x < 10; x += 8) {
			int ax = xy.x + x;
			if (ax >= 10) break;
			G[0][ay][ax] = l0(x - 1, y - 1);
		}
	}
	barrier();
	F s0_0_0, s0_0_1, s0_0_2, s0_1_0, s0_1_1, s0_1_2, s0_2_0, s0_2_1, s0_2_2;
	V4 r0, r1;
	r0 = V4(0.0); r1 = V4(0.0);
	s0_0_0 = G[0][xy.y+0][xy.x+0]; s0_0_1 = G[0][xy.y+0][xy.x+1];
	s0_0_2 = G[0][xy.y+0][xy.x+2]; s0_1_0 = G[0][xy.y+1][xy.x+0];
	s0_1_1 = G[0][xy.y+1][xy.x+1]; s0_1_2 = G[0][xy.y+1][xy.x+2];
	s0_2_0 = G[0][xy.y+2][xy.x+0]; s0_2_1 = G[0][xy.y+2][xy.x+1];
	s0_2_2 = G[0][xy.y+2][xy.x+2];
	r0 += V4(1.612e-01, -1.632e-02, -2.977e-03, -4.032e-02) * s0_0_0;
	r1 += V4(5.384e-02, -1.049e-01, -2.023e-01, -3.488e-02) * s0_0_0;
	r0 += V4(1.936e-01, -1.513e-02, -3.731e-03, 1.284e-01) * s0_0_1;
	r1 += V4(1.184e-01, 1.713e-02, 6.037e-01, 8.617e-02) * s0_0_1;
	r0 += V4(5.804e-02, 2.193e-02, 6.902e-03, -2.568e-01) * s0_0_2;
	r1 += V4(8.788e-02, -4.494e-02, 2.747e-01, -4.177e-02) * s0_0_2;
	r0 += V4(2.022e-01, 4.207e-02, 7.612e-01, 6.274e-02) * s0_1_0;
	r1 += V4(1.360e-02, 7.106e-01, 2.012e-01, 1.060e-01) * s0_1_0;
	r0 += V4(2.444e-01, 7.559e-01, 5.855e-03, 6.951e-01) * s0_1_1;
	r1 += V4(-4.625e-01, -2.940e-01, -6.035e-01, -7.380e-01) * s0_1_1;
	r0 += V4(-6.703e-02, -7.838e-01, -1.412e-02, -3.291e-01) * s0_1_2;
	r1 += V4(5.372e-01, 1.153e-01, -2.764e-01, 3.046e-02) * s0_1_2;
	r0 += V4(-6.412e-02, -2.351e-02, -7.698e-01, -8.762e-02) * s0_2_0;
	r1 += V4(1.938e-02, -7.078e-02, -1.751e-04, -7.338e-02) * s0_2_0;
	r0 += V4(1.940e-02, -3.142e-02, 9.781e-03, -3.452e-02) * s0_2_1;
	r1 += V4(3.990e-01, -4.389e-02, 4.144e-02, 2.127e-01) * s0_2_1;
	r0 += V4(-1.445e-02, 5.212e-02, 7.431e-03, -9.034e-02) * s0_2_2;
	r1 += V4(3.989e-02, 6.492e-02, -3.593e-02, 4.522e-01) * s0_2_2;
	r0 += V4(1.530e-02, -4.552e-04, 1.234e-06, -4.276e-03);
	r0 = max(r0, V4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0));
	r1 += V4(1.958e-02, -8.934e-04, 7.102e-03, 3.649e-03);
	r1 = max(r1, V4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r1));
}

//!DESC [CuNNy_2x8] -conv1
//!HOOK LUMA
//!COMPUTE 16 8 8 8
//!BIND in
//!BIND LUMA
//!SAVE conv1
//!WIDTH LUMA.w 2 *
//!HEIGHT LUMA.h
//!COMPONENTS 4
//!WHEN OUTPUT.w LUMA.w / 1.2 > OUTPUT.h LUMA.h / 1.2 > *
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#ifdef GL_EXT_shader_explicit_arithmetic_types_float16
#	define V4 f16vec4
#	define M4 f16mat4
#	define F float16_t
#else
#	define V4 vec4
#	define M4 mat4
#	define F float
#endif
#define l0(x, y) V4(in_tex((vec2(clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(2, 1) + ivec2(0, 0)) + vec2(0.5)) * in_pt))
#define l1(x, y) V4(in_tex((vec2(clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(2, 1) + ivec2(1, 0)) + vec2(0.5)) * in_pt))
shared V4 G[2][10][10];
void hook() {
	ivec2 xy = ivec2(gl_LocalInvocationID.xy);
	ivec2 pos = ivec2(gl_WorkGroupID.xy) * ivec2(8, 8) + xy;
	ivec2 opos = pos * ivec2(2, 1);
	ivec2 sz = ivec2(LUMA_size) - ivec2(1);
	for (int y = 0; y < 10; y += 8) {
		int ay = xy.y + y;
		if (ay >= 10) break;
		for (int x = 0; x < 10; x += 8) {
			int ax = xy.x + x;
			if (ax >= 10) break;
			G[0][ay][ax] = l0(x - 1, y - 1);
			G[1][ay][ax] = l1(x - 1, y - 1);
		}
	}
	barrier();
	V4 s0_0_0, s0_0_1, s0_0_2, s0_1_0, s0_1_1, s0_1_2, s0_2_0, s0_2_1, s0_2_2, s1_0_0, s1_0_1, s1_0_2, s1_1_0, s1_1_1, s1_1_2, s1_2_0, s1_2_1, s1_2_2;
	V4 r0, r1;
	r0 = V4(0.0); r1 = V4(0.0);
	s0_0_0 = G[0][xy.y+0][xy.x+0]; s0_0_1 = G[0][xy.y+0][xy.x+1];
	s0_0_2 = G[0][xy.y+0][xy.x+2]; s0_1_0 = G[0][xy.y+1][xy.x+0];
	s0_1_1 = G[0][xy.y+1][xy.x+1]; s0_1_2 = G[0][xy.y+1][xy.x+2];
	s0_2_0 = G[0][xy.y+2][xy.x+0]; s0_2_1 = G[0][xy.y+2][xy.x+1];
	s0_2_2 = G[0][xy.y+2][xy.x+2]; s1_0_0 = G[1][xy.y+0][xy.x+0];
	s1_0_1 = G[1][xy.y+0][xy.x+1]; s1_0_2 = G[1][xy.y+0][xy.x+2];
	s1_1_0 = G[1][xy.y+1][xy.x+0]; s1_1_1 = G[1][xy.y+1][xy.x+1];
	s1_1_2 = G[1][xy.y+1][xy.x+2]; s1_2_0 = G[1][xy.y+2][xy.x+0];
	s1_2_1 = G[1][xy.y+2][xy.x+1]; s1_2_2 = G[1][xy.y+2][xy.x+2];
	r0 += M4(-1.171e-01, -3.037e-02, 1.325e-01, -5.578e-02, -4.528e-01, 1.851e-01, -5.227e-01, 3.173e-01, -2.038e-02, -2.888e-03, 8.801e-02, -5.608e-02, 1.349e-01, -1.808e-02, 2.233e-01, -7.429e-02) * s0_0_0;
	r1 += M4(4.160e-02, -3.751e-02, -6.250e-02, 2.026e-01, 4.774e-02, 9.090e-01, -4.422e-01, -2.853e-01, -1.711e-02, -8.946e-02, -6.375e-02, -2.566e-01, 4.018e-02, -9.766e-02, 3.643e-01, 1.803e-01) * s0_0_0;
	r0 += M4(2.925e-01, -1.890e-02, -2.363e-01, -5.405e-02, -4.123e-01, -4.043e-02, -1.847e-02, 1.352e-01, -5.033e-01, 8.964e-02, -1.000e+00, 2.057e-01, 3.495e-01, 1.138e-01, -2.074e-02, 1.495e-02) * s0_0_1;
	r1 += M4(1.176e-02, -2.112e-01, 1.111e-01, 1.397e-01, 4.801e-02, 2.268e-01, -3.135e-02, 1.403e-01, -1.902e-01, -3.001e-01, -1.000e+00, -7.353e-02, 1.789e-02, -3.900e-01, 1.524e-01, -1.210e-01) * s0_0_1;
	r0 += M4(3.827e-01, 2.516e-02, 2.694e-01, -1.213e-01, 1.210e-01, -5.211e-02, 2.313e-01, -5.927e-02, 1.534e-01, 8.625e-01, -1.000e+00, 4.993e-01, 4.101e-02, 1.382e-02, -1.106e-02, -2.821e-02) * s0_0_2;
	r1 += M4(6.027e-02, -3.545e-01, 2.468e-01, -2.061e-01, -4.331e-02, -3.564e-02, -3.700e-03, -8.238e-02, 5.766e-01, 1.000e+00, -2.218e-01, 2.555e-01, 4.107e-02, 2.555e-02, 9.449e-02, -2.717e-02) * s0_0_2;
	r0 += M4(3.272e-01, -2.428e-02, 2.826e-01, -3.320e-01, -4.362e-01, 3.779e-01, -1.000e+00, 5.569e-01, 3.188e-02, -3.633e-02, 1.288e-01, 2.528e-02, 1.382e-01, -1.382e-01, 2.702e-01, -2.356e-01) * s0_1_0;
	r1 += M4(3.504e-01, 4.014e-01, -1.015e-01, 2.682e-01, 7.461e-01, -7.046e-01, -5.723e-01, 1.000e+00, -8.179e-02, -1.446e-01, 1.967e-01, -4.225e-02, -1.273e-02, -5.990e-02, 6.514e-01, -4.674e-01) * s0_1_0;
	r0 += M4(-4.278e-01, -3.898e-01, -4.009e-02, -3.267e-01, 2.683e-01, 6.309e-01, -3.143e-01, 4.242e-01, -2.432e-01, 5.146e-02, -5.254e-01, 1.413e-01, 9.112e-02, -3.471e-01, 5.252e-01, -3.952e-01) * s0_1_1;
	r1 += M4(-6.424e-02, 7.228e-01, -2.753e-01, 4.486e-01, 6.494e-01, -1.509e-01, 1.558e-01, 2.922e-02, -3.232e-01, -4.111e-01, 3.090e-02, 9.229e-02, -4.383e-01, -1.749e-01, -2.232e-01, -4.502e-01) * s0_1_1;
	r0 += M4(-7.264e-01, -4.368e-01, 3.713e-01, 1.510e-02, 1.238e-01, -8.032e-02, 3.856e-01, -3.584e-02, 5.605e-01, 7.602e-01, -5.333e-01, 6.113e-01, -2.621e-01, -2.952e-03, -5.282e-01, 2.551e-02) * s0_1_2;
	r1 += M4(-2.654e-01, 8.418e-02, -1.728e-01, -4.649e-01, -6.519e-02, 2.243e-01, 5.269e-02, -1.680e-01, 5.527e-01, 3.038e-01, -2.763e-01, -6.645e-02, -3.769e-02, -4.355e-01, -6.086e-02, 2.069e-01) * s0_1_2;
	r0 += M4(1.195e-01, -1.120e-02, -5.964e-02, -2.397e-02, -4.273e-02, -9.681e-02, 4.463e-01, -1.558e-01, 1.471e-02, -2.142e-02, 5.419e-02, 3.430e-03, -1.698e-01, 3.098e-03, -2.723e-01, -6.514e-02) * s0_2_0;
	r1 += M4(1.373e-01, -4.080e-02, 1.714e-01, -6.797e-02, -5.010e-02, -2.434e-01, 8.848e-01, 2.436e-01, -2.552e-03, 1.425e-02, 2.428e-01, 2.879e-02, -2.607e-02, 1.584e-01, -7.246e-01, -1.357e-01) * s0_2_0;
	r0 += M4(-5.640e-01, -2.573e-01, -3.131e-01, -4.988e-02, 7.381e-01, 2.192e-01, 7.435e-01, 4.082e-01, -1.729e-03, -2.306e-02, 3.037e-01, -9.146e-02, -3.170e-01, -1.440e-05, -4.664e-01, -1.401e-01) * s0_2_1;
	r1 += M4(-2.646e-01, -1.248e-01, 1.561e-02, 5.142e-01, 1.655e-01, 6.529e-02, 3.563e-02, -5.767e-01, -3.585e-02, 5.160e-02, 5.344e-01, -5.689e-02, -4.169e-02, 2.678e-01, -1.724e-01, 1.975e-01) * s0_2_1;
	r0 += M4(3.605e-01, 4.276e-01, -6.843e-02, 7.766e-01, -2.318e-02, -9.084e-02, 1.101e-01, -9.448e-02, -1.933e-02, -5.369e-02, 2.660e-01, 1.654e-02, -1.583e-01, 9.720e-02, -2.877e-01, 5.469e-02) * s0_2_2;
	r1 += M4(4.327e-01, 9.545e-02, 1.941e-01, -5.472e-03, -3.202e-02, 1.528e-01, -3.657e-02, -2.082e-01, -8.056e-02, 3.128e-02, 7.968e-02, -2.920e-01, 5.198e-02, 5.332e-02, -1.037e-01, 1.098e-01) * s0_2_2;
	r0 += M4(-2.842e-01, 5.989e-02, 3.354e-02, 9.352e-02, 1.162e-01, 1.600e-02, -1.856e-01, 6.911e-02, 5.744e-02, -2.798e-03, -5.088e-02, -1.021e-02, -3.272e-01, 7.930e-02, -2.137e-01, 1.911e-01) * s1_0_0;
	r1 += M4(2.282e-02, 1.732e-01, 3.279e-01, -5.507e-01, -1.366e-01, -1.493e-01, 1.384e-01, -1.258e-01, -5.546e-02, -2.418e-01, -1.106e-02, -2.271e-01, -9.228e-03, 7.207e-01, -8.204e-02, -2.845e-01) * s1_0_0;
	r0 += M4(-1.956e-01, 1.095e-01, -5.409e-02, 3.913e-01, 9.546e-02, 3.723e-02, -4.131e-02, 4.314e-02, -2.002e-01, -2.741e-02, 1.388e-01, 6.598e-02, 4.573e-01, 3.512e-01, -1.023e-01, 4.073e-01) * s1_0_1;
	r1 += M4(-1.165e-01, 4.186e-01, -7.104e-02, 1.864e-01, 3.488e-03, -2.281e-01, 2.540e-01, 1.250e-01, -7.204e-02, 2.485e-01, -1.665e-01, 1.106e-01, 1.807e-01, 1.617e-01, 9.100e-02, 8.075e-02) * s1_0_1;
	r0 += M4(8.606e-02, -9.162e-03, -6.847e-02, -8.734e-02, 9.498e-02, 4.053e-02, 2.996e-01, 2.159e-02, -1.115e-01, -1.459e-02, -6.581e-02, -8.384e-03, -9.106e-03, 1.270e-02, 1.458e-01, 1.254e-01) * s1_0_2;
	r1 += M4(-8.984e-03, -1.988e-01, 7.253e-02, 8.221e-02, 1.166e-01, -1.145e-01, 1.344e-01, -2.127e-01, 2.452e-02, 6.716e-02, 3.062e-03, -1.613e-03, -3.369e-02, 2.025e-01, -2.941e-02, 6.301e-02) * s1_0_2;
	r0 += M4(-1.851e-01, 4.842e-03, -2.255e-01, 6.857e-01, -1.154e-01, 3.927e-02, -7.180e-02, 1.869e-01, 1.922e-01, -6.443e-03, 2.340e-01, -6.308e-02, -1.191e-03, 7.403e-02, -5.739e-01, 7.487e-02) * s1_1_0;
	r1 += M4(-3.870e-01, -6.203e-01, -9.677e-01, -3.047e-01, -2.295e-01, 7.622e-02, -2.888e-01, -1.807e-01, 2.253e-01, -1.000e+00, -2.341e-01, -1.160e-01, 1.387e-01, -9.109e-01, -2.184e-01, -7.051e-02) * s1_1_0;
	r0 += M4(7.520e-01, 5.020e-01, -3.499e-01, -7.296e-01, 5.873e-01, 2.936e-01, 1.624e-01, -4.418e-02, -5.215e-01, 1.714e-02, -1.401e-01, -2.085e-01, 6.060e-01, 3.124e-01, 4.439e-01, 2.183e-01) * s1_1_1;
	r1 += M4(2.755e-01, -5.977e-01, -3.057e-02, 6.080e-01, 5.084e-01, 2.664e-01, 4.082e-01, 5.920e-01, 1.396e-01, -9.688e-02, -7.542e-03, 1.880e-01, 2.834e-03, -6.113e-01, 9.267e-02, -1.674e-01) * s1_1_1;
	r0 += M4(2.012e-02, -1.059e-01, 7.811e-03, -5.417e-02, -4.769e-01, -4.555e-01, 7.716e-01, -1.211e-01, 1.299e-01, 7.297e-02, 2.623e-02, 3.403e-02, 2.148e-01, 3.663e-02, 6.531e-03, 5.428e-03) * s1_1_2;
	r1 += M4(-1.314e-01, 1.055e-01, -9.989e-02, -1.362e-01, -1.493e-01, -1.938e-01, 2.714e-01, -2.140e-01, 7.853e-02, 4.670e-02, -5.342e-02, -8.812e-02, 4.382e-02, 1.542e-01, 1.140e-01, 1.782e-01) * s1_1_2;
	r0 += M4(-9.986e-03, -5.489e-03, 2.924e-01, -2.588e-01, -9.218e-02, 7.954e-04, 4.748e-02, -6.852e-02, 2.491e-01, -1.513e-01, 7.365e-02, 1.195e-02, 3.202e-02, -4.268e-02, -1.234e-01, 1.070e-01) * s1_2_0;
	r1 += M4(-6.933e-02, 1.859e-01, 1.000e+00, -6.549e-02, 1.802e-02, -1.848e-01, 8.833e-02, 7.105e-02, -1.607e-01, 2.183e-01, 3.854e-01, 6.886e-02, 7.458e-02, 1.013e-01, -3.538e-01, 2.084e-01) * s1_2_0;
	r0 += M4(4.758e-02, -3.425e-02, 1.599e-01, 1.507e-01, 4.134e-01, 4.747e-02, -2.920e-01, -2.020e-01, -2.801e-02, -7.114e-02, -1.463e-02, 2.856e-01, 1.085e-01, 3.650e-02, 9.003e-02, -6.471e-02) * s1_2_1;
	r1 += M4(-6.998e-02, 2.025e-01, -1.611e-01, -3.537e-01, -1.940e-01, -2.203e-01, -1.000e+00, -2.514e-01, 9.699e-02, -2.671e-01, 2.348e-01, -8.924e-02, 5.152e-02, -9.011e-02, 1.504e-01, 1.284e-01) * s1_2_1;
	r0 += M4(-2.959e-01, -1.105e-02, -1.508e-01, 3.636e-03, 2.673e-01, 3.136e-01, -4.787e-01, 1.096e-01, -2.020e-01, -3.221e-02, 3.405e-02, -4.220e-02, 1.221e-01, -2.631e-02, 1.047e-01, -1.624e-03) * s1_2_2;
	r1 += M4(1.590e-02, 3.868e-02, -4.639e-02, -3.185e-02, 2.482e-01, 4.027e-01, -3.216e-01, -1.743e-01, 1.621e-03, 4.632e-02, -1.262e-01, -1.124e-01, -2.414e-02, -9.778e-02, 1.263e-02, 2.926e-02) * s1_2_2;
	r0 += V4(1.050e-02, 4.449e-03, -8.421e-03, -8.087e-03);
	r0 = max(r0, V4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0));
	r1 += V4(6.856e-04, -7.561e-03, -5.804e-03, -6.040e-03);
	r1 = max(r1, V4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r1));
}

//!DESC [CuNNy_2x8] -conv2
//!HOOK LUMA
//!COMPUTE 16 8 8 8
//!BIND conv1
//!BIND LUMA
//!SAVE conv2
//!WIDTH LUMA.w 2 *
//!HEIGHT LUMA.h
//!COMPONENTS 4
//!WHEN OUTPUT.w LUMA.w / 1.2 > OUTPUT.h LUMA.h / 1.2 > *
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#ifdef GL_EXT_shader_explicit_arithmetic_types_float16
#	define V4 f16vec4
#	define M4 f16mat4
#	define F float16_t
#else
#	define V4 vec4
#	define M4 mat4
#	define F float
#endif
#define l0(x, y) V4(conv1_tex((vec2(clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(2, 1) + ivec2(0, 0)) + vec2(0.5)) * conv1_pt))
#define l1(x, y) V4(conv1_tex((vec2(clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(2, 1) + ivec2(1, 0)) + vec2(0.5)) * conv1_pt))
shared V4 G[2][10][10];
void hook() {
	ivec2 xy = ivec2(gl_LocalInvocationID.xy);
	ivec2 pos = ivec2(gl_WorkGroupID.xy) * ivec2(8, 8) + xy;
	ivec2 opos = pos * ivec2(2, 1);
	ivec2 sz = ivec2(LUMA_size) - ivec2(1);
	for (int y = 0; y < 10; y += 8) {
		int ay = xy.y + y;
		if (ay >= 10) break;
		for (int x = 0; x < 10; x += 8) {
			int ax = xy.x + x;
			if (ax >= 10) break;
			G[0][ay][ax] = l0(x - 1, y - 1);
			G[1][ay][ax] = l1(x - 1, y - 1);
		}
	}
	barrier();
	V4 s0_0_0, s0_0_1, s0_0_2, s0_1_0, s0_1_1, s0_1_2, s0_2_0, s0_2_1, s0_2_2, s1_0_0, s1_0_1, s1_0_2, s1_1_0, s1_1_1, s1_1_2, s1_2_0, s1_2_1, s1_2_2;
	V4 r0, r1;
	r0 = V4(0.0); r1 = V4(0.0);
	s0_0_0 = G[0][xy.y+0][xy.x+0]; s0_0_1 = G[0][xy.y+0][xy.x+1];
	s0_0_2 = G[0][xy.y+0][xy.x+2]; s0_1_0 = G[0][xy.y+1][xy.x+0];
	s0_1_1 = G[0][xy.y+1][xy.x+1]; s0_1_2 = G[0][xy.y+1][xy.x+2];
	s0_2_0 = G[0][xy.y+2][xy.x+0]; s0_2_1 = G[0][xy.y+2][xy.x+1];
	s0_2_2 = G[0][xy.y+2][xy.x+2]; s1_0_0 = G[1][xy.y+0][xy.x+0];
	s1_0_1 = G[1][xy.y+0][xy.x+1]; s1_0_2 = G[1][xy.y+0][xy.x+2];
	s1_1_0 = G[1][xy.y+1][xy.x+0]; s1_1_1 = G[1][xy.y+1][xy.x+1];
	s1_1_2 = G[1][xy.y+1][xy.x+2]; s1_2_0 = G[1][xy.y+2][xy.x+0];
	s1_2_1 = G[1][xy.y+2][xy.x+1]; s1_2_2 = G[1][xy.y+2][xy.x+2];
	r0 += M4(-5.870e-03, 2.959e-02, -3.522e-02, -2.527e-02, -1.028e-01, 2.078e-02, 2.546e-01, 2.460e-01, 1.054e-02, 7.913e-02, -5.156e-02, -6.938e-02, 2.439e-02, 3.796e-02, -1.655e-01, -1.450e-01) * s0_0_0;
	r1 += M4(-2.869e-02, -4.155e-02, 2.983e-02, -2.553e-02, -4.490e-02, 1.881e-01, 6.323e-02, -1.031e-01, 4.232e-02, -7.198e-02, -6.044e-02, 2.655e-02, 1.078e-02, -2.180e-01, -3.518e-02, 3.722e-02) * s0_0_0;
	r0 += M4(8.571e-02, -1.048e-01, 2.380e-01, 2.433e-01, -8.903e-02, 3.227e-01, 3.135e-01, 2.639e-01, -1.108e-01, -2.606e-01, -2.771e-01, -2.402e-01, 2.717e-02, -3.090e-01, -6.074e-01, -6.543e-01) * s0_0_1;
	r1 += M4(2.066e-02, 3.281e-01, -2.783e-01, 2.876e-02, 1.577e-01, -1.820e-01, 2.103e-01, 8.581e-02, -9.713e-02, -1.000e+00, -9.090e-01, 2.534e-02, 3.135e-02, -2.389e-01, -1.534e-01, 3.332e-02) * s0_0_1;
	r0 += M4(9.565e-02, -2.152e-02, 1.213e-01, 1.067e-01, -7.994e-02, -1.518e-01, 4.590e-02, 7.721e-02, -4.164e-02, -2.508e-01, -6.511e-02, -1.112e-01, -1.655e-01, 1.498e-01, -2.466e-01, -2.221e-01) * s0_0_2;
	r1 += M4(4.623e-02, 1.190e-01, 1.487e-01, 5.375e-02, -1.042e-01, 3.307e-02, -9.448e-02, 7.397e-02, -2.152e-01, -1.173e-01, -8.199e-02, -8.390e-02, 5.413e-02, -6.958e-02, 7.124e-02, -6.421e-02) * s0_0_2;
	r0 += M4(2.116e-02, -1.840e-01, -1.273e-01, -2.781e-01, -2.160e-01, 3.378e-01, 9.496e-02, -6.777e-02, 3.952e-02, 3.150e-01, -1.002e-01, -1.801e-01, 4.519e-02, -3.227e-02, -5.351e-02, -9.230e-02) * s0_1_0;
	r1 += M4(3.894e-02, -5.370e-01, 4.082e-01, 2.381e-02, -1.520e-02, 5.703e-01, -7.205e-01, -1.661e-01, -8.220e-02, -5.641e-01, -1.471e-01, 1.867e-02, -2.984e-02, -4.028e-01, 8.042e-03, -2.760e-03) * s0_1_0;
	r0 += M4(-3.914e-01, 3.196e-01, -6.775e-01, -5.530e-01, 4.082e-01, -1.204e-01, 3.964e-01, -3.948e-01, -4.977e-02, -1.000e+00, -3.910e-01, -3.881e-01, 1.908e-01, -6.752e-01, 1.943e-01, 7.793e-01) * s0_1_1;
	r1 += M4(5.479e-02, -7.332e-01, -5.196e-01, -1.690e-01, 6.243e-01, 2.602e-01, 1.000e+00, 4.066e-01, -7.058e-01, -7.281e-01, -7.297e-01, -2.270e-02, -1.559e-01, 2.310e-01, 1.438e-01, 6.274e-02) * s0_1_1;
	r0 += M4(1.395e-01, -1.887e-01, -1.204e-01, -1.305e-01, -4.854e-01, -2.456e-01, 1.278e-01, -1.274e-01, -2.719e-01, -4.716e-01, -1.680e-01, -9.725e-02, 1.492e-01, 6.543e-01, -9.514e-02, 7.409e-02) * s0_1_2;
	r1 += M4(2.853e-02, -2.256e-02, 3.397e-01, 2.365e-01, -7.363e-01, -8.896e-02, -6.145e-01, -5.069e-01, -3.789e-01, -4.425e-02, -6.972e-02, -1.372e-01, 7.592e-01, 3.231e-02, -3.163e-02, 1.199e-02) * s0_1_2;
	r0 += M4(-1.374e-01, -1.467e-01, -1.766e-02, -9.291e-03, 1.523e-01, 2.290e-01, -1.235e-02, 4.407e-03, -1.729e-02, 2.480e-01, 1.171e-01, 1.097e-01, -9.305e-02, -3.671e-02, 4.364e-02, 3.542e-02) * s0_2_0;
	r1 += M4(3.153e-02, 1.990e-01, 1.019e-01, -2.995e-02, -2.732e-02, -3.000e-01, 2.047e-02, 9.249e-02, 1.382e-02, 1.140e-01, -7.343e-02, -1.399e-02, 2.326e-02, 1.733e-01, -5.228e-02, -4.720e-02) * s0_2_0;
	r0 += M4(-9.042e-02, -4.120e-03, 1.242e-01, -1.516e-01, 2.061e-01, 2.937e-01, -1.133e-01, 5.520e-01, -5.696e-01, -7.401e-01, -1.149e-01, -2.719e-02, -3.186e-01, -2.908e-01, 6.319e-02, -2.459e-01) * s0_2_1;
	r1 += M4(1.043e-01, 2.212e-01, 4.780e-02, -4.407e-02, -8.878e-02, -1.665e-01, 2.298e-02, 2.847e-02, -1.190e-01, -3.908e-02, -4.658e-01, -1.275e-01, 5.129e-02, 1.623e-01, -1.038e-01, -3.832e-02) * s0_2_1;
	r0 += M4(-3.252e-01, 2.223e-01, -3.002e-02, -1.009e-01, 3.700e-01, -4.338e-01, -1.714e-02, 1.470e-01, -3.607e-01, -2.926e-01, -4.689e-02, -3.510e-02, 3.976e-01, 3.199e-01, 5.234e-02, 1.031e-01) * s0_2_2;
	r1 += M4(1.247e-01, 7.863e-03, 5.788e-03, -4.124e-02, -1.307e-01, -5.866e-02, -1.097e-01, 4.194e-03, -8.049e-02, -5.290e-02, -8.032e-02, -7.593e-02, 1.183e-01, 1.499e-01, 9.261e-02, 8.943e-02) * s0_2_2;
	r0 += M4(5.810e-02, -9.308e-02, -1.088e-01, -1.049e-01, -2.840e-02, 2.676e-03, 6.220e-02, 4.390e-02, -2.761e-02, 2.686e-02, 1.878e-02, 7.251e-02, -1.740e-03, -1.799e-02, 1.731e-02, 2.300e-02) * s1_0_0;
	r1 += M4(-1.207e-02, -1.500e-01, -1.374e-01, 6.890e-02, -2.455e-02, 1.025e-01, 1.444e-02, -1.065e-02, -8.034e-04, -2.726e-03, 3.578e-03, 1.162e-02, 3.405e-02, 1.018e-02, 1.605e-01, -2.826e-02) * s1_0_0;
	r0 += M4(6.067e-02, -3.430e-01, -2.860e-01, -1.690e-01, 2.452e-02, -4.187e-02, 1.743e-01, 2.075e-01, -6.562e-02, 2.843e-02, 1.936e-01, 1.419e-01, -4.886e-02, 2.425e-01, 1.577e-01, 3.994e-02) * s1_0_1;
	r1 += M4(-1.124e-01, 1.006e-02, -3.195e-01, -9.722e-02, -8.180e-02, 1.181e-01, -8.792e-02, 8.346e-03, 2.907e-02, 1.971e-01, 2.047e-01, 2.479e-03, 1.647e-02, -5.022e-02, 3.369e-01, -1.521e-02) * s1_0_1;
	r0 += M4(4.292e-02, 1.062e-01, -1.753e-01, -2.890e-01, 7.601e-02, -6.978e-02, 2.125e-01, 2.220e-01, -7.848e-02, -2.327e-02, -1.859e-01, 9.031e-01, 8.462e-02, 2.474e-01, 1.782e-01, 1.875e-01) * s1_0_2;
	r1 += M4(7.152e-02, 4.067e-02, 1.035e-01, -4.722e-02, -8.684e-02, 5.515e-02, -2.259e-02, -1.980e-02, 2.196e-03, 3.969e-01, -4.135e-02, 2.652e-02, 3.299e-02, 1.782e-02, 1.660e-01, 9.057e-02) * s1_0_2;
	r0 += M4(9.482e-02, -5.674e-01, -2.744e-01, 7.201e-02, 2.397e-02, -1.032e-01, 8.200e-02, 9.010e-02, -3.524e-02, -7.347e-02, 1.303e-02, 2.453e-02, -3.407e-02, 4.659e-01, 1.250e-01, -1.154e-01) * s1_1_0;
	r1 += M4(-9.279e-02, -1.685e-01, -5.896e-02, 4.894e-02, -1.185e-02, 6.865e-02, 3.870e-02, 9.376e-03, 4.128e-02, 6.149e-03, -1.692e-02, 1.166e-03, 1.828e-02, -2.702e-02, 7.840e-02, -6.125e-03) * s1_1_0;
	r0 += M4(-3.584e-01, 2.742e-01, 3.952e-01, -5.716e-02, -7.226e-02, 4.409e-01, 2.936e-01, 3.339e-01, 4.503e-02, -7.342e-02, -2.663e-03, 1.339e-01, 8.602e-02, -1.830e-01, 2.178e-01, -2.131e-03) * s1_1_1;
	r1 += M4(-3.232e-01, 5.098e-01, -4.658e-01, -2.308e-01, -1.806e-02, -4.837e-01, -2.723e-01, -8.730e-03, 2.495e-02, 3.773e-01, 2.342e-02, -3.324e-02, 1.722e-01, -2.707e-01, 5.137e-01, 6.710e-02) * s1_1_1;
	r0 += M4(-3.946e-02, -1.123e-01, 1.270e-01, 3.389e-01, -1.711e-02, -4.423e-01, 1.961e-02, 6.913e-03, 4.713e-01, 6.274e-02, 2.180e-01, -7.394e-01, -3.479e-01, 1.000e+00, -1.217e-01, -6.984e-02) * s1_1_2;
	r1 += M4(4.248e-01, 3.772e-03, 4.653e-01, 7.559e-01, -3.355e-01, -8.292e-02, 1.588e-02, -8.389e-02, 5.313e-02, -2.570e-01, -1.180e-01, 1.512e-01, 3.993e-02, -3.792e-01, -2.746e-01, 3.435e-01) * s1_1_2;
	r0 += M4(-6.810e-02, -2.588e-01, -3.363e-02, -1.181e-01, -6.177e-02, -7.689e-02, 8.475e-02, 9.456e-02, 2.998e-02, -4.044e-02, -2.122e-02, -4.804e-02, -3.109e-02, 1.373e-01, 5.358e-02, 1.281e-01) * s1_2_0;
	r1 += M4(4.702e-02, 1.248e-01, -1.033e-01, -4.831e-02, -4.246e-02, 5.649e-02, 4.251e-02, -1.390e-02, 2.582e-02, -3.324e-02, 3.226e-03, 1.174e-02, -1.753e-02, -5.761e-02, 8.637e-02, 5.495e-03) * s1_2_0;
	r0 += M4(1.091e-01, -7.584e-02, -1.136e-01, -2.124e-01, -7.912e-02, 2.476e-01, 2.641e-01, 2.982e-01, 1.887e-01, 2.322e-02, -9.694e-02, -1.212e-01, -1.919e-01, -4.329e-02, 3.880e-02, 1.849e-01) * s1_2_1;
	r1 += M4(-1.265e-02, -1.792e-01, 1.194e-01, 1.132e-01, -2.326e-02, 3.892e-01, 3.780e-02, 1.013e-02, -3.726e-02, -1.954e-01, 2.487e-02, 4.626e-02, 8.036e-02, 2.163e-01, 1.483e-01, -5.033e-02) * s1_2_1;
	r0 += M4(8.253e-02, 1.451e-01, 8.651e-02, -3.678e-02, 7.547e-02, -4.326e-01, 4.619e-02, -1.248e-01, 8.708e-03, 1.190e-01, -3.006e-03, 1.026e-01, 4.195e-01, 2.686e-01, 6.030e-02, -1.656e-02) * s1_2_2;
	r1 += M4(-2.376e-01, -1.611e-01, 8.315e-02, -2.050e-02, -4.061e-02, 7.185e-02, -6.011e-02, -1.710e-02, -3.553e-02, -1.169e-01, 7.788e-02, -1.488e-02, 1.792e-01, 2.378e-01, 5.991e-02, 7.471e-02) * s1_2_2;
	r0 += V4(-1.090e-02, -1.166e-02, -1.145e-02, -1.243e-02);
	r0 = max(r0, V4(0.0));
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0));
	r1 += V4(-8.395e-03, -1.102e-02, -1.168e-02, -5.690e-03);
	r1 = max(r1, V4(0.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r1));
}

//!DESC [CuNNy_2x8] -out-shuffle
//!HOOK LUMA
//!COMPUTE 16 16 8 8
//!BIND conv2
//!BIND LUMA
//!WIDTH LUMA.w 2 *
//!HEIGHT LUMA.h 2 *
//!COMPONENTS 1
//!WHEN OUTPUT.w LUMA.w / 1.2 > OUTPUT.h LUMA.h / 1.2 > *
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable
#ifdef GL_EXT_shader_explicit_arithmetic_types_float16
#	define V4 f16vec4
#	define M4 f16mat4
#	define F float16_t
#else
#	define V4 vec4
#	define M4 mat4
#	define F float
#endif
#define l0(x, y) V4(conv2_tex((vec2(clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(2, 1) + ivec2(0, 0)) + vec2(0.5)) * conv2_pt))
#define l1(x, y) V4(conv2_tex((vec2(clamp(pos + ivec2(x, y), ivec2(0), sz) * ivec2(2, 1) + ivec2(1, 0)) + vec2(0.5)) * conv2_pt))
shared V4 G[2][10][10];
void hook() {
	ivec2 xy = ivec2(gl_LocalInvocationID.xy);
	ivec2 pos = ivec2(gl_WorkGroupID.xy) * ivec2(8, 8) + xy;
	ivec2 opos = pos * ivec2(2, 2);
	ivec2 sz = ivec2(LUMA_size) - ivec2(1);
	for (int y = 0; y < 10; y += 8) {
		int ay = xy.y + y;
		if (ay >= 10) break;
		for (int x = 0; x < 10; x += 8) {
			int ax = xy.x + x;
			if (ax >= 10) break;
			G[0][ay][ax] = l0(x - 1, y - 1);
			G[1][ay][ax] = l1(x - 1, y - 1);
		}
	}
	barrier();
	V4 s0_0_0, s0_0_1, s0_0_2, s0_1_0, s0_1_1, s0_1_2, s0_2_0, s0_2_1, s0_2_2, s1_0_0, s1_0_1, s1_0_2, s1_1_0, s1_1_1, s1_1_2, s1_2_0, s1_2_1, s1_2_2;
	V4 r0;
	r0 = V4(0.0);
	s0_0_0 = G[0][xy.y+0][xy.x+0]; s0_0_1 = G[0][xy.y+0][xy.x+1];
	s0_0_2 = G[0][xy.y+0][xy.x+2]; s0_1_0 = G[0][xy.y+1][xy.x+0];
	s0_1_1 = G[0][xy.y+1][xy.x+1]; s0_1_2 = G[0][xy.y+1][xy.x+2];
	s0_2_0 = G[0][xy.y+2][xy.x+0]; s0_2_1 = G[0][xy.y+2][xy.x+1];
	s0_2_2 = G[0][xy.y+2][xy.x+2]; s1_0_0 = G[1][xy.y+0][xy.x+0];
	s1_0_1 = G[1][xy.y+0][xy.x+1]; s1_0_2 = G[1][xy.y+0][xy.x+2];
	s1_1_0 = G[1][xy.y+1][xy.x+0]; s1_1_1 = G[1][xy.y+1][xy.x+1];
	s1_1_2 = G[1][xy.y+1][xy.x+2]; s1_2_0 = G[1][xy.y+2][xy.x+0];
	s1_2_1 = G[1][xy.y+2][xy.x+1]; s1_2_2 = G[1][xy.y+2][xy.x+2];
	r0 += M4(4.983e-02, -5.093e-02, -1.095e-01, 4.007e-02, 3.141e-03, -1.503e-03, -5.461e-02, -1.313e-03, -2.104e-02, 3.118e-02, 1.788e-03, -2.548e-04, 9.416e-03, -2.533e-02, 1.444e-03, -7.110e-04) * s0_0_0;
	r0 += M4(1.595e-02, 1.932e-01, -3.402e-02, -3.843e-01, 1.043e-01, -1.578e-01, -1.158e-02, 4.973e-02, 1.293e-01, 3.835e-02, -2.067e-02, -6.124e-03, -1.077e-01, -3.970e-02, 1.959e-02, 5.607e-03) * s0_0_1;
	r0 += M4(-1.666e-02, -1.402e-02, -1.164e-02, 1.550e-02, -2.170e-02, 3.119e-02, -1.114e-02, -6.410e-03, 1.766e-03, 4.211e-02, -2.029e-03, -9.838e-04, -5.226e-03, -3.991e-02, 1.722e-03, 2.369e-03) * s0_0_2;
	r0 += M4(-3.017e-02, 2.948e-02, 2.051e-01, 9.104e-02, 1.150e-02, -6.729e-03, 7.887e-02, 3.444e-03, -4.390e-02, 3.406e-02, -7.738e-02, 5.244e-02, -5.328e-03, -4.569e-04, 6.323e-02, -2.155e-02) * s0_1_0;
	r0 += M4(1.624e-03, -6.274e-02, -2.508e-02, 1.411e-01, 2.567e-01, -1.996e-01, 3.369e-01, -4.697e-01, -6.665e-02, -2.085e-01, 4.442e-01, 2.372e-02, 3.435e-01, 2.764e-01, -3.760e-01, -4.664e-02) * s0_1_1;
	r0 += M4(5.484e-04, -4.467e-04, 4.869e-03, -1.595e-03, -4.079e-02, 1.512e-02, -5.065e-02, 5.707e-02, -2.629e-02, 1.238e-01, -4.469e-02, 7.837e-02, 8.042e-03, 3.185e-03, 3.975e-02, -5.311e-02) * s0_1_2;
	r0 += M4(8.953e-03, 8.173e-03, -3.094e-02, -4.991e-03, 4.061e-03, -1.459e-03, 5.274e-03, -1.286e-03, -2.000e-03, 5.140e-03, -1.973e-02, 9.353e-03, -2.437e-03, 1.633e-03, 1.170e-03, 1.719e-02) * s0_2_0;
	r0 += M4(-7.434e-04, -6.742e-03, 1.510e-03, -4.637e-03, -2.753e-02, 5.269e-03, 6.844e-03, 2.462e-02, -2.421e-03, 4.495e-03, -2.228e-01, -1.194e-01, -1.143e-02, -1.226e-03, -9.191e-03, -4.911e-02) * s0_2_1;
	r0 += M4(-5.431e-04, 1.278e-03, 8.030e-04, 1.895e-03, 2.158e-03, 2.084e-03, -2.876e-03, 1.846e-02, -1.667e-03, -4.601e-02, -5.220e-03, -6.436e-02, -1.235e-02, -1.188e-02, 1.354e-02, -5.297e-03) * s0_2_2;
	r0 += M4(6.274e-02, -1.447e-02, -1.120e-02, -6.606e-03, -2.737e-03, 9.595e-04, -5.443e-03, 7.854e-04, 1.064e-02, -1.451e-02, 3.868e-03, 4.877e-03, -1.446e-01, 9.977e-03, 6.412e-03, 1.642e-02) * s1_0_0;
	r0 += M4(-1.309e-02, 9.741e-02, -1.151e-02, -3.259e-02, 6.043e-02, -6.662e-03, 4.919e-04, -5.203e-03, 2.257e-02, -6.036e-02, 3.003e-02, 1.800e-02, 1.484e-02, -8.113e-02, 1.064e-02, -2.153e-02) * s1_0_1;
	r0 += M4(1.833e-02, -1.171e-02, 6.349e-03, 4.718e-03, -2.974e-03, 3.894e-02, -3.883e-03, 1.311e-03, -3.784e-03, -4.235e-02, 8.845e-03, -1.706e-02, 1.906e-04, 5.713e-03, 1.170e-03, 3.671e-03) * s1_0_2;
	r0 += M4(1.260e-01, 7.544e-02, 2.282e-01, 5.603e-02, 5.243e-02, -3.186e-02, 1.201e-02, -2.763e-03, 2.659e-02, -6.958e-02, 1.447e-02, -7.300e-02, 1.181e-01, -1.434e-01, -2.481e-01, -1.845e-01) * s1_1_0;
	r0 += M4(-2.387e-01, -1.624e-01, -1.418e-01, 1.597e-01, -4.592e-01, 3.502e-02, 1.965e-01, 4.473e-02, -6.270e-01, 6.269e-01, -3.465e-01, 2.797e-01, 5.529e-02, 2.332e-01, 7.341e-02, 1.856e-01) * s1_1_1;
	r0 += M4(1.886e-02, -3.152e-02, 2.803e-02, -6.158e-02, -1.539e-02, -5.002e-01, 2.599e-02, 3.545e-01, -1.191e-03, 1.354e-01, -1.397e-02, 1.825e-02, 5.005e-04, -9.433e-03, 1.260e-03, -5.679e-03) * s1_1_2;
	r0 += M4(2.203e-02, 2.282e-02, -2.000e-02, 6.462e-03, -8.146e-03, -3.895e-03, -2.864e-03, -1.396e-02, -3.126e-05, 4.984e-03, 5.432e-02, -3.279e-03, -3.082e-02, -2.636e-02, 1.188e-01, -9.799e-03) * s1_2_0;
	r0 += M4(1.026e-02, 1.961e-02, -6.714e-02, -9.692e-02, 4.553e-02, 1.846e-02, 6.165e-02, 3.660e-02, 7.641e-02, -4.019e-02, -2.275e-01, 2.007e-01, 1.402e-03, 1.566e-02, 1.183e-03, 4.068e-02) * s1_2_1;
	r0 += M4(-9.960e-04, -3.469e-03, 1.493e-03, -1.702e-02, 2.530e-04, 4.922e-02, 2.716e-02, -3.107e-02, 1.021e-03, -8.416e-02, 7.759e-03, 5.553e-02, 1.467e-04, 7.122e-04, -1.074e-03, -1.156e-03) * s1_2_2;
	r0 += V4(-9.188e-05, -7.608e-05, -9.573e-05, -6.958e-05);
	r0 = tanh(r0);
	vec2 opt = 0.5 * LUMA_pt;
	vec2 fpos = (vec2(opos) + vec2(0.5)) * opt;
	imageStore(out_image, opos + ivec2(0, 0), vec4(r0.x + LUMA_tex(fpos + vec2(0.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 0), vec4(r0.y + LUMA_tex(fpos + vec2(1.0, 0.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(0, 1), vec4(r0.z + LUMA_tex(fpos + vec2(0.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
	imageStore(out_image, opos + ivec2(1, 1), vec4(r0.w + LUMA_tex(fpos + vec2(1.0, 1.0) * opt).r, 0.0, 0.0, 1.0));
}
