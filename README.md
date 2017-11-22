# HazeKernelForMac

一个基于mac os系统的自定义滤镜内核
这是一个去除雾霾的滤镜，内核算法如下
kernel vec4 myHazeRemovalKernel(sampler src,             // 1
__color color,
float distance,
float slope)
{
vec4   t;
float  d;

d = destCoord().y * slope  +  distance;              // 2
t = unpremultiply(sample(src, samplerCoord(src)));   // 3
t = (t - d*color) / (1.0-d);                         // 4

return premultiply(t);                               // 5
}

