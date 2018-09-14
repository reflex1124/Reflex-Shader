// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Watch Amplify"
{
	Properties
	{
		_NumberTex("Number Tex", 2D) = "white" {}
		_NumberColor("Number Color", Color) = (0,0,0,0)
		_WallpaperTexture("Wallpaper Texture", 2D) = "black" {}
		_WallpaperColor("Wallpaper Color", Color) = (1,1,1,0)
		_WallpaperPos("Wallpaper Pos", Vector) = (0,0,0,0)
		_Mask("Mask", 2D) = "white" {}
		_Size("Size", Range( 0 , 50)) = 7.5
		_Size_H("Size_H", Range( 0 , 50)) = 7.5
		_ClochHight("Cloch Hight", Range( -5 , 5)) = 0
		_HPos("H Pos", Vector) = (0,-1.5,0,0)
		_HourKerning("Hour Kerning", Range( 0 , 0.5)) = 0.5
		_MinPos("Min Pos", Range( 0 , 2)) = 1.5
		_MinKerning("Min Kerning", Range( 0 , 0.5)) = 0.5
		_SecPos("Sec Pos", Range( 0 , 2)) = 1.5
		_SecKerning("Sec Kerning", Range( 0 , 0.5)) = 0.5
		[Toggle]_NumberCutout("Number Cutout", Float) = 0
		_ClockDepth("Clock Depth", Range( 0 , 1)) = 0
		_WallpaperDepth("Wallpaper Depth", Range( 0 , 1)) = 0.2
		_WallpaperScale("Wallpaper Scale", Range( 0 , 1)) = 1
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[Toggle]_DebugMode("Debug Mode", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Off
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform sampler2D _WallpaperTexture;
		uniform float2 _WallpaperPos;
		uniform float _WallpaperScale;
		uniform float _WallpaperDepth;
		uniform float4 _WallpaperColor;
		uniform float4 _NumberColor;
		uniform sampler2D _NumberTex;
		uniform float _Size_H;
		uniform float _ClockDepth;
		uniform float2 _HPos;
		uniform float _HourKerning;
		uniform float _ClochHight;
		uniform float _DebugMode;
		uniform float _Size;
		uniform float _MinPos;
		uniform float _MinKerning;
		uniform float _SecPos;
		uniform float _SecKerning;
		uniform float _NumberCutout;
		uniform sampler2D _Mask;
		uniform float4 _Mask_ST;
		uniform float _Cutoff = 0.5;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 Offset384 = ( ( 0.0 - 1 ) * i.viewDir.xy * _ClockDepth ) + ( ( i.uv_texcoord * _Size_H ) + ( ( 1.0 - _Size_H ) / 2.0 ) );
			float2 UVH222 = Offset384;
			float temp_output_298_0 = ( _HPos.y + _ClochHight );
			float2 appendResult291 = (float2(( _HPos.x + _HourKerning ) , temp_output_298_0));
			float2 clampResult206 = clamp( ( UVH222 + appendResult291 ) , float2( 0,0 ) , float2( 1,1 ) );
			float temp_output_4_0_g18 = 11.0;
			float temp_output_5_0_g18 = 1.0;
			float2 appendResult7_g18 = (float2(temp_output_4_0_g18 , temp_output_5_0_g18));
			float totalFrames39_g18 = ( temp_output_4_0_g18 * temp_output_5_0_g18 );
			float2 appendResult8_g18 = (float2(totalFrames39_g18 , temp_output_5_0_g18));
			float Time69 = lerp(( _Time.y / 10.0 ),( _Time.y * 100.0 ),_DebugMode);
			float clampResult42_g18 = clamp( 0.0 , 0.0001 , ( totalFrames39_g18 - 1.0 ) );
			float temp_output_35_0_g18 = frac( ( ( floor( (0.0 + (frac( ( ( Time69 / 36000.0 ) * ( 10.0 / 6.0 ) ) ) - 0.0) * (6.0 - 0.0) / (1.0 - 0.0)) ) + clampResult42_g18 ) / totalFrames39_g18 ) );
			float2 appendResult29_g18 = (float2(temp_output_35_0_g18 , ( 1.0 - temp_output_35_0_g18 )));
			float2 temp_output_15_0_g18 = ( ( clampResult206 / appendResult7_g18 ) + ( floor( ( appendResult8_g18 * appendResult29_g18 ) ) / appendResult7_g18 ) );
			float2 appendResult225 = (float2(( _HPos.x - _HourKerning ) , temp_output_298_0));
			float2 clampResult204 = clamp( ( UVH222 + appendResult225 ) , float2( 0,0 ) , float2( 1,1 ) );
			float temp_output_4_0_g17 = 11.0;
			float temp_output_5_0_g17 = 1.0;
			float2 appendResult7_g17 = (float2(temp_output_4_0_g17 , temp_output_5_0_g17));
			float totalFrames39_g17 = ( temp_output_4_0_g17 * temp_output_5_0_g17 );
			float2 appendResult8_g17 = (float2(totalFrames39_g17 , temp_output_5_0_g17));
			float clampResult42_g17 = clamp( 0.0 , 0.0001 , ( totalFrames39_g17 - 1.0 ) );
			float temp_output_35_0_g17 = frac( ( ( floor( (0.0 + (frac( ( Time69 / 3600.0 ) ) - 0.0) * (10.0 - 0.0) / (1.0 - 0.0)) ) + clampResult42_g17 ) / totalFrames39_g17 ) );
			float2 appendResult29_g17 = (float2(temp_output_35_0_g17 , ( 1.0 - temp_output_35_0_g17 )));
			float2 temp_output_15_0_g17 = ( ( clampResult204 / appendResult7_g17 ) + ( floor( ( appendResult8_g17 * appendResult29_g17 ) ) / appendResult7_g17 ) );
			float2 Offset385 = ( ( 0.0 - 1 ) * i.viewDir.xy * _ClockDepth ) + ( ( i.uv_texcoord * _Size ) + ( ( 1.0 - _Size ) / 2.0 ) );
			float2 UV62 = Offset385;
			float2 appendResult269 = (float2(( _MinPos + _MinKerning ) , _ClochHight));
			float2 clampResult137 = clamp( ( UV62 + appendResult269 ) , float2( 0,0 ) , float2( 1,1 ) );
			float temp_output_4_0_g27 = 11.0;
			float temp_output_5_0_g27 = 1.0;
			float2 appendResult7_g27 = (float2(temp_output_4_0_g27 , temp_output_5_0_g27));
			float totalFrames39_g27 = ( temp_output_4_0_g27 * temp_output_5_0_g27 );
			float2 appendResult8_g27 = (float2(totalFrames39_g27 , temp_output_5_0_g27));
			float clampResult42_g27 = clamp( 0.0 , 0.0001 , ( totalFrames39_g27 - 1.0 ) );
			float temp_output_35_0_g27 = frac( ( ( floor( (0.0 + (frac( ( ( Time69 / 600.0 ) * ( 10.0 / 6.0 ) ) ) - 0.0) * (6.0 - 0.0) / (1.0 - 0.0)) ) + clampResult42_g27 ) / totalFrames39_g27 ) );
			float2 appendResult29_g27 = (float2(temp_output_35_0_g27 , ( 1.0 - temp_output_35_0_g27 )));
			float2 temp_output_15_0_g27 = ( ( clampResult137 / appendResult7_g27 ) + ( floor( ( appendResult8_g27 * appendResult29_g27 ) ) / appendResult7_g27 ) );
			float2 appendResult275 = (float2(( _MinPos - _MinKerning ) , _ClochHight));
			float2 clampResult129 = clamp( ( UV62 + appendResult275 ) , float2( 0,0 ) , float2( 1,1 ) );
			float temp_output_4_0_g26 = 11.0;
			float temp_output_5_0_g26 = 1.0;
			float2 appendResult7_g26 = (float2(temp_output_4_0_g26 , temp_output_5_0_g26));
			float totalFrames39_g26 = ( temp_output_4_0_g26 * temp_output_5_0_g26 );
			float2 appendResult8_g26 = (float2(totalFrames39_g26 , temp_output_5_0_g26));
			float clampResult42_g26 = clamp( 0.0 , 0.0001 , ( totalFrames39_g26 - 1.0 ) );
			float temp_output_35_0_g26 = frac( ( ( floor( (0.0 + (frac( ( Time69 / 60.0 ) ) - 0.0) * (10.0 - 0.0) / (1.0 - 0.0)) ) + clampResult42_g26 ) / totalFrames39_g26 ) );
			float2 appendResult29_g26 = (float2(temp_output_35_0_g26 , ( 1.0 - temp_output_35_0_g26 )));
			float2 temp_output_15_0_g26 = ( ( clampResult129 / appendResult7_g26 ) + ( floor( ( appendResult8_g26 * appendResult29_g26 ) ) / appendResult7_g26 ) );
			float temp_output_287_0 = ( _SecPos * -1.0 );
			float2 appendResult274 = (float2(( temp_output_287_0 + _SecKerning ) , _ClochHight));
			float2 clampResult114 = clamp( ( UV62 + appendResult274 ) , float2( 0,0 ) , float2( 1,1 ) );
			float temp_output_4_0_g25 = 11.0;
			float temp_output_5_0_g25 = 1.0;
			float2 appendResult7_g25 = (float2(temp_output_4_0_g25 , temp_output_5_0_g25));
			float totalFrames39_g25 = ( temp_output_4_0_g25 * temp_output_5_0_g25 );
			float2 appendResult8_g25 = (float2(totalFrames39_g25 , temp_output_5_0_g25));
			float clampResult42_g25 = clamp( 0.0 , 0.0001 , ( totalFrames39_g25 - 1.0 ) );
			float temp_output_35_0_g25 = frac( ( ( floor( (0.0 + (frac( ( ( Time69 / 10.0 ) * ( 10.0 / 6.0 ) ) ) - 0.0) * (6.0 - 0.0) / (1.0 - 0.0)) ) + clampResult42_g25 ) / totalFrames39_g25 ) );
			float2 appendResult29_g25 = (float2(temp_output_35_0_g25 , ( 1.0 - temp_output_35_0_g25 )));
			float2 temp_output_15_0_g25 = ( ( clampResult114 / appendResult7_g25 ) + ( floor( ( appendResult8_g25 * appendResult29_g25 ) ) / appendResult7_g25 ) );
			float2 appendResult283 = (float2(( temp_output_287_0 - _SecKerning ) , _ClochHight));
			float2 clampResult81 = clamp( ( UV62 + appendResult283 ) , float2( 0,0 ) , float2( 1,1 ) );
			float temp_output_4_0_g24 = 11.0;
			float temp_output_5_0_g24 = 1.0;
			float2 appendResult7_g24 = (float2(temp_output_4_0_g24 , temp_output_5_0_g24));
			float totalFrames39_g24 = ( temp_output_4_0_g24 * temp_output_5_0_g24 );
			float2 appendResult8_g24 = (float2(totalFrames39_g24 , temp_output_5_0_g24));
			float clampResult42_g24 = clamp( 0.0 , 0.0001 , ( totalFrames39_g24 - 1.0 ) );
			float temp_output_35_0_g24 = frac( ( ( floor( (0.0 + (frac( Time69 ) - 0.0) * (10.0 - 0.0) / (1.0 - 0.0)) ) + clampResult42_g24 ) / totalFrames39_g24 ) );
			float2 appendResult29_g24 = (float2(temp_output_35_0_g24 , ( 1.0 - temp_output_35_0_g24 )));
			float2 temp_output_15_0_g24 = ( ( clampResult81 / appendResult7_g24 ) + ( floor( ( appendResult8_g24 * appendResult29_g24 ) ) / appendResult7_g24 ) );
			float4 temp_cast_3 = (0.0).xxxx;
			float2 appendResult303 = (float2(0 , _ClochHight));
			float2 clampResult264 = clamp( ( UV62 + appendResult303 ) , float2( 0,0 ) , float2( 1,1 ) );
			float temp_output_4_0_g19 = 11.0;
			float temp_output_5_0_g19 = 1.0;
			float2 appendResult7_g19 = (float2(temp_output_4_0_g19 , temp_output_5_0_g19));
			float totalFrames39_g19 = ( temp_output_4_0_g19 * temp_output_5_0_g19 );
			float2 appendResult8_g19 = (float2(totalFrames39_g19 , temp_output_5_0_g19));
			float clampResult42_g19 = clamp( 0.0 , 0.0001 , ( totalFrames39_g19 - 1.0 ) );
			float temp_output_35_0_g19 = frac( ( ( 10.0 + clampResult42_g19 ) / totalFrames39_g19 ) );
			float2 appendResult29_g19 = (float2(temp_output_35_0_g19 , ( 1.0 - temp_output_35_0_g19 )));
			float2 temp_output_15_0_g19 = ( ( clampResult264 / appendResult7_g19 ) + ( floor( ( appendResult8_g19 * appendResult29_g19 ) ) / appendResult7_g19 ) );
			float4 lerpResult232 = lerp( temp_cast_3 , tex2D( _NumberTex, temp_output_15_0_g19 ) , floor( fmod( _Time.y , 2.0 ) ));
			float4 temp_output_299_0 = ( ( tex2D( _NumberTex, temp_output_15_0_g18 ) + tex2D( _NumberTex, temp_output_15_0_g17 ) ) + tex2D( _NumberTex, temp_output_15_0_g27 ) + tex2D( _NumberTex, temp_output_15_0_g26 ) + tex2D( _NumberTex, temp_output_15_0_g25 ) + tex2D( _NumberTex, temp_output_15_0_g24 ) + lerpResult232 );
			float3 temp_output_156_0 = (temp_output_299_0).rgb;
			float2 uv_Mask = i.uv_texcoord * _Mask_ST.xy + _Mask_ST.zw;
			float4 lerpResult408 = lerp( float4( temp_output_156_0 , 0.0 ) , tex2D( _Mask, uv_Mask ) , 1.0);
			c.rgb = 0;
			c.a = 1;
			clip( lerp(lerpResult408,( float4( temp_output_156_0 , 0.0 ) + lerpResult408 ),_NumberCutout).r - _Cutoff );
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float2 Offset394 = ( ( 0.0 - 1 ) * i.viewDir.xy * _WallpaperDepth ) + ( ( ( i.uv_texcoord + _WallpaperPos ) * _WallpaperScale ) + ( ( 1.0 - _WallpaperScale ) / 2.0 ) );
			float2 Offset384 = ( ( 0.0 - 1 ) * i.viewDir.xy * _ClockDepth ) + ( ( i.uv_texcoord * _Size_H ) + ( ( 1.0 - _Size_H ) / 2.0 ) );
			float2 UVH222 = Offset384;
			float temp_output_298_0 = ( _HPos.y + _ClochHight );
			float2 appendResult291 = (float2(( _HPos.x + _HourKerning ) , temp_output_298_0));
			float2 clampResult206 = clamp( ( UVH222 + appendResult291 ) , float2( 0,0 ) , float2( 1,1 ) );
			float temp_output_4_0_g18 = 11.0;
			float temp_output_5_0_g18 = 1.0;
			float2 appendResult7_g18 = (float2(temp_output_4_0_g18 , temp_output_5_0_g18));
			float totalFrames39_g18 = ( temp_output_4_0_g18 * temp_output_5_0_g18 );
			float2 appendResult8_g18 = (float2(totalFrames39_g18 , temp_output_5_0_g18));
			float Time69 = lerp(( _Time.y / 10.0 ),( _Time.y * 100.0 ),_DebugMode);
			float clampResult42_g18 = clamp( 0.0 , 0.0001 , ( totalFrames39_g18 - 1.0 ) );
			float temp_output_35_0_g18 = frac( ( ( floor( (0.0 + (frac( ( ( Time69 / 36000.0 ) * ( 10.0 / 6.0 ) ) ) - 0.0) * (6.0 - 0.0) / (1.0 - 0.0)) ) + clampResult42_g18 ) / totalFrames39_g18 ) );
			float2 appendResult29_g18 = (float2(temp_output_35_0_g18 , ( 1.0 - temp_output_35_0_g18 )));
			float2 temp_output_15_0_g18 = ( ( clampResult206 / appendResult7_g18 ) + ( floor( ( appendResult8_g18 * appendResult29_g18 ) ) / appendResult7_g18 ) );
			float2 appendResult225 = (float2(( _HPos.x - _HourKerning ) , temp_output_298_0));
			float2 clampResult204 = clamp( ( UVH222 + appendResult225 ) , float2( 0,0 ) , float2( 1,1 ) );
			float temp_output_4_0_g17 = 11.0;
			float temp_output_5_0_g17 = 1.0;
			float2 appendResult7_g17 = (float2(temp_output_4_0_g17 , temp_output_5_0_g17));
			float totalFrames39_g17 = ( temp_output_4_0_g17 * temp_output_5_0_g17 );
			float2 appendResult8_g17 = (float2(totalFrames39_g17 , temp_output_5_0_g17));
			float clampResult42_g17 = clamp( 0.0 , 0.0001 , ( totalFrames39_g17 - 1.0 ) );
			float temp_output_35_0_g17 = frac( ( ( floor( (0.0 + (frac( ( Time69 / 3600.0 ) ) - 0.0) * (10.0 - 0.0) / (1.0 - 0.0)) ) + clampResult42_g17 ) / totalFrames39_g17 ) );
			float2 appendResult29_g17 = (float2(temp_output_35_0_g17 , ( 1.0 - temp_output_35_0_g17 )));
			float2 temp_output_15_0_g17 = ( ( clampResult204 / appendResult7_g17 ) + ( floor( ( appendResult8_g17 * appendResult29_g17 ) ) / appendResult7_g17 ) );
			float2 Offset385 = ( ( 0.0 - 1 ) * i.viewDir.xy * _ClockDepth ) + ( ( i.uv_texcoord * _Size ) + ( ( 1.0 - _Size ) / 2.0 ) );
			float2 UV62 = Offset385;
			float2 appendResult269 = (float2(( _MinPos + _MinKerning ) , _ClochHight));
			float2 clampResult137 = clamp( ( UV62 + appendResult269 ) , float2( 0,0 ) , float2( 1,1 ) );
			float temp_output_4_0_g27 = 11.0;
			float temp_output_5_0_g27 = 1.0;
			float2 appendResult7_g27 = (float2(temp_output_4_0_g27 , temp_output_5_0_g27));
			float totalFrames39_g27 = ( temp_output_4_0_g27 * temp_output_5_0_g27 );
			float2 appendResult8_g27 = (float2(totalFrames39_g27 , temp_output_5_0_g27));
			float clampResult42_g27 = clamp( 0.0 , 0.0001 , ( totalFrames39_g27 - 1.0 ) );
			float temp_output_35_0_g27 = frac( ( ( floor( (0.0 + (frac( ( ( Time69 / 600.0 ) * ( 10.0 / 6.0 ) ) ) - 0.0) * (6.0 - 0.0) / (1.0 - 0.0)) ) + clampResult42_g27 ) / totalFrames39_g27 ) );
			float2 appendResult29_g27 = (float2(temp_output_35_0_g27 , ( 1.0 - temp_output_35_0_g27 )));
			float2 temp_output_15_0_g27 = ( ( clampResult137 / appendResult7_g27 ) + ( floor( ( appendResult8_g27 * appendResult29_g27 ) ) / appendResult7_g27 ) );
			float2 appendResult275 = (float2(( _MinPos - _MinKerning ) , _ClochHight));
			float2 clampResult129 = clamp( ( UV62 + appendResult275 ) , float2( 0,0 ) , float2( 1,1 ) );
			float temp_output_4_0_g26 = 11.0;
			float temp_output_5_0_g26 = 1.0;
			float2 appendResult7_g26 = (float2(temp_output_4_0_g26 , temp_output_5_0_g26));
			float totalFrames39_g26 = ( temp_output_4_0_g26 * temp_output_5_0_g26 );
			float2 appendResult8_g26 = (float2(totalFrames39_g26 , temp_output_5_0_g26));
			float clampResult42_g26 = clamp( 0.0 , 0.0001 , ( totalFrames39_g26 - 1.0 ) );
			float temp_output_35_0_g26 = frac( ( ( floor( (0.0 + (frac( ( Time69 / 60.0 ) ) - 0.0) * (10.0 - 0.0) / (1.0 - 0.0)) ) + clampResult42_g26 ) / totalFrames39_g26 ) );
			float2 appendResult29_g26 = (float2(temp_output_35_0_g26 , ( 1.0 - temp_output_35_0_g26 )));
			float2 temp_output_15_0_g26 = ( ( clampResult129 / appendResult7_g26 ) + ( floor( ( appendResult8_g26 * appendResult29_g26 ) ) / appendResult7_g26 ) );
			float temp_output_287_0 = ( _SecPos * -1.0 );
			float2 appendResult274 = (float2(( temp_output_287_0 + _SecKerning ) , _ClochHight));
			float2 clampResult114 = clamp( ( UV62 + appendResult274 ) , float2( 0,0 ) , float2( 1,1 ) );
			float temp_output_4_0_g25 = 11.0;
			float temp_output_5_0_g25 = 1.0;
			float2 appendResult7_g25 = (float2(temp_output_4_0_g25 , temp_output_5_0_g25));
			float totalFrames39_g25 = ( temp_output_4_0_g25 * temp_output_5_0_g25 );
			float2 appendResult8_g25 = (float2(totalFrames39_g25 , temp_output_5_0_g25));
			float clampResult42_g25 = clamp( 0.0 , 0.0001 , ( totalFrames39_g25 - 1.0 ) );
			float temp_output_35_0_g25 = frac( ( ( floor( (0.0 + (frac( ( ( Time69 / 10.0 ) * ( 10.0 / 6.0 ) ) ) - 0.0) * (6.0 - 0.0) / (1.0 - 0.0)) ) + clampResult42_g25 ) / totalFrames39_g25 ) );
			float2 appendResult29_g25 = (float2(temp_output_35_0_g25 , ( 1.0 - temp_output_35_0_g25 )));
			float2 temp_output_15_0_g25 = ( ( clampResult114 / appendResult7_g25 ) + ( floor( ( appendResult8_g25 * appendResult29_g25 ) ) / appendResult7_g25 ) );
			float2 appendResult283 = (float2(( temp_output_287_0 - _SecKerning ) , _ClochHight));
			float2 clampResult81 = clamp( ( UV62 + appendResult283 ) , float2( 0,0 ) , float2( 1,1 ) );
			float temp_output_4_0_g24 = 11.0;
			float temp_output_5_0_g24 = 1.0;
			float2 appendResult7_g24 = (float2(temp_output_4_0_g24 , temp_output_5_0_g24));
			float totalFrames39_g24 = ( temp_output_4_0_g24 * temp_output_5_0_g24 );
			float2 appendResult8_g24 = (float2(totalFrames39_g24 , temp_output_5_0_g24));
			float clampResult42_g24 = clamp( 0.0 , 0.0001 , ( totalFrames39_g24 - 1.0 ) );
			float temp_output_35_0_g24 = frac( ( ( floor( (0.0 + (frac( Time69 ) - 0.0) * (10.0 - 0.0) / (1.0 - 0.0)) ) + clampResult42_g24 ) / totalFrames39_g24 ) );
			float2 appendResult29_g24 = (float2(temp_output_35_0_g24 , ( 1.0 - temp_output_35_0_g24 )));
			float2 temp_output_15_0_g24 = ( ( clampResult81 / appendResult7_g24 ) + ( floor( ( appendResult8_g24 * appendResult29_g24 ) ) / appendResult7_g24 ) );
			float4 temp_cast_0 = (0.0).xxxx;
			float2 appendResult303 = (float2(0 , _ClochHight));
			float2 clampResult264 = clamp( ( UV62 + appendResult303 ) , float2( 0,0 ) , float2( 1,1 ) );
			float temp_output_4_0_g19 = 11.0;
			float temp_output_5_0_g19 = 1.0;
			float2 appendResult7_g19 = (float2(temp_output_4_0_g19 , temp_output_5_0_g19));
			float totalFrames39_g19 = ( temp_output_4_0_g19 * temp_output_5_0_g19 );
			float2 appendResult8_g19 = (float2(totalFrames39_g19 , temp_output_5_0_g19));
			float clampResult42_g19 = clamp( 0.0 , 0.0001 , ( totalFrames39_g19 - 1.0 ) );
			float temp_output_35_0_g19 = frac( ( ( 10.0 + clampResult42_g19 ) / totalFrames39_g19 ) );
			float2 appendResult29_g19 = (float2(temp_output_35_0_g19 , ( 1.0 - temp_output_35_0_g19 )));
			float2 temp_output_15_0_g19 = ( ( clampResult264 / appendResult7_g19 ) + ( floor( ( appendResult8_g19 * appendResult29_g19 ) ) / appendResult7_g19 ) );
			float4 lerpResult232 = lerp( temp_cast_0 , tex2D( _NumberTex, temp_output_15_0_g19 ) , floor( fmod( _Time.y , 2.0 ) ));
			float4 temp_output_299_0 = ( ( tex2D( _NumberTex, temp_output_15_0_g18 ) + tex2D( _NumberTex, temp_output_15_0_g17 ) ) + tex2D( _NumberTex, temp_output_15_0_g27 ) + tex2D( _NumberTex, temp_output_15_0_g26 ) + tex2D( _NumberTex, temp_output_15_0_g25 ) + tex2D( _NumberTex, temp_output_15_0_g24 ) + lerpResult232 );
			float4 lerpResult307 = lerp( ( tex2D( _WallpaperTexture, Offset394 ) + _WallpaperColor ) , _NumberColor , temp_output_299_0.r);
			float4 clampResult164 = clamp( lerpResult307 , float4( 0,0,0,0 ) , float4( 1,1,1,1 ) );
			o.Emission = clampResult164.rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = IN.tSpace0.xyz * worldViewDir.x + IN.tSpace1.xyz * worldViewDir.y + IN.tSpace2.xyz * worldViewDir.z;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
956;92;964;926;1483.248;445.9421;2.14063;True;False
Node;AmplifyShaderEditor.CommentaryNode;70;-3374.804,-176.8907;Float;False;914.4998;279.4209;Time;5;153;69;67;228;214;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TimeNode;67;-3332.804,-83.23751;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;63;-4512.311,307.5139;Float;False;2343.342;553.957;UV;10;62;60;58;102;101;218;59;381;385;382;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;215;-4505.654,942.0799;Float;False;2330.889;589.0569;UV-Hour;7;222;221;219;220;217;216;384;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;214;-3080.544,-3.448547;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;153;-3080.71,-109.0877;Float;False;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;216;-4426.904,1352.053;Float;False;Property;_Size_H;Size_H;7;0;Create;True;0;0;False;0;7.5;7.5;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-4433.561,717.4865;Float;False;Property;_Size;Size;6;0;Create;True;0;0;False;0;7.5;7.5;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;228;-2923.853,-66.37735;Float;False;Property;_DebugMode;Debug Mode;20;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;101;-4006.276,682.9979;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;218;-4402.488,438.8615;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;217;-3999.619,1317.564;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;191;-2165.815,-2308.537;Float;False;69;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;69;-2687.951,-60.89065;Float;False;Time;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;220;-3964.055,1063.78;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-3970.712,429.2135;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;219;-3805.618,1315.564;Float;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;102;-3812.276,680.9979;Float;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;192;-1968.036,-1650.02;Float;False;69;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;297;-2182.704,-1421.733;Float;False;Property;_ClochHight;Cloch Hight;8;0;Create;True;0;0;False;0;0;0;-5;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;212;-1943.682,-2303.762;Float;False;2;0;FLOAT;0;False;1;FLOAT;36000;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;294;-1914.409,-1998.11;Float;False;Property;_HourKerning;Hour Kerning;10;0;Create;True;0;0;False;0;0.5;0;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;211;-1943.995,-2147.974;Float;False;2;0;FLOAT;10;False;1;FLOAT;6;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;60;-3660.479,459.6577;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;146;-2101.696,-1122.894;Float;False;69;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;104;-2078.897,24.71548;Float;False;69;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;382;-3315.593,664.2841;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;285;-1838.187,398.3242;Float;False;Property;_SecPos;Sec Pos;13;0;Create;True;0;0;False;0;1.5;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;196;-1773.719,-2396.728;Float;False;Property;_HPos;H Pos;9;0;Create;True;0;0;False;0;0,-1.5;0.5,-1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;381;-3348.569,561.0714;Float;False;Property;_ClockDepth;Clock Depth;16;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;221;-3653.821,1094.224;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;193;-1740.115,-1646.809;Float;False;2;0;FLOAT;0;False;1;FLOAT;3600;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;266;-1788.179,-1182.17;Float;False;Property;_MinKerning;Min Kerning;12;0;Create;True;0;0;False;0;0.5;0;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;148;-1879.563,-1118.12;Float;False;2;0;FLOAT;0;False;1;FLOAT;600;False;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxMappingNode;384;-2875.087,1100.509;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;210;-1771.571,-2230.704;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;292;-1539.795,-2413.746;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;287;-1520.384,400.4907;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;280;-1810.678,-859.1604;Float;False;Property;_MinPos;Min Pos;11;0;Create;True;0;0;False;0;1.5;1.5;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;141;-1894.069,-567.7789;Float;False;69;0;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxMappingNode;385;-2908.864,478.063;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;105;-1857.077,185.279;Float;False;2;0;FLOAT;10;False;1;FLOAT;6;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;273;-2082.365,535.2285;Float;False;Property;_SecKerning;Sec Kerning;14;0;Create;True;0;0;False;0;0.5;0;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;293;-1591.219,-1856.11;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;147;-1898.313,-1023.786;Float;False;2;0;FLOAT;10;False;1;FLOAT;6;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;262;-780.3244,1024.517;Float;False;Constant;_Vector4;Vector 4;2;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;298;-1535.113,-1776.411;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;103;-1856.764,29.48993;Float;False;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;197;-1492.281,-1937.884;Float;False;222;0;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;279;-1511.117,-1174.246;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;62;-2416.809,451.8058;Float;True;UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;-1684.653,102.5487;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;225;-1388.668,-1825.375;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FractNode;198;-1578.87,-1634.809;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;276;-1495.461,-691.5478;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;194;-1402.29,-2495.322;Float;False;222;0;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;288;-1776.747,754.3074;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;195;-1575.411,-2230.757;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;261;-679.0565,930.1367;Float;False;62;0;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;289;-1291.573,496.9747;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;93;-1819.674,867.9074;Float;False;69;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;142;-1666.148,-564.5683;Float;False;2;0;FLOAT;0;False;1;FLOAT;60;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;303;-592.532,1063.587;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;291;-1361.463,-2404.667;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;222;-2415.165,1096.4;Float;True;UVH;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;149;-1707.452,-1045.061;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;168;787.5852,516.4224;Float;False;Property;_WallpaperPos;Wallpaper Pos;4;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;388;570.4521,451.2522;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;399;851.1213,652.8547;Float;False;Property;_WallpaperScale;Wallpaper Scale;18;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;201;-1248.28,-1931.884;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;203;-1382.912,-1650.075;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;107;-1488.493,102.4954;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;110;-1283.667,-170.7896;Float;False;62;0;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;274;-1052.165,487.4284;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;200;-1158.289,-2489.322;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;283;-1599.016,751.2127;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FractNode;144;-1504.903,-552.5683;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;269;-1326.778,-1218.17;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FractNode;90;-1585.521,872.7769;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;77;-1668.842,-269.7928;Float;True;Property;_NumberTex;Number Tex;0;0;Create;True;0;0;False;0;None;None;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FractNode;150;-1511.292,-1045.114;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;133;-1338.17,-1309.679;Float;False;62;0;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;125;-1484.161,-776.2418;Float;False;62;0;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;275;-1345.142,-698.8152;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;79;-1668.068,639.1073;Float;False;62;0;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;202;-1403.115,-2226.035;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;6;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;263;-436.1464,965.3572;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TimeNode;242;-375.6534,1054.029;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;264;-288.9598,937.4183;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;400;1175.576,601.4447;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;136;-1216.996,-1052.393;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;6;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;205;-1162.289,-2219.321;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;169;1001.587,452.4222;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;206;-994.2892,-2489.322;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;135;-1094.17,-1303.679;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;108;-1290.493,102.4954;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;6;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;265;-298.7395,851.2478;Float;False;Constant;_Float1;Float 1;9;0;Create;True;0;0;False;0;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;78;-1429.157,688.3278;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FmodOpNode;256;-94.69461,1074.796;Float;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;113;-1039.667,-164.7896;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;127;-1184.161,-746.2418;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;128;-1308.945,-567.8336;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;91;-1399.048,872.4647;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;207;-1136.087,-1647.36;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;204;-1084.28,-1931.884;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;124;-804.6313,-247.8273;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;398;1173.121,452.8547;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;81;-1253.97,690.3889;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FloorOpNode;258;55.13806,1070.47;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;401;1347.17,527.9302;Float;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;260;-83.58916,836.1713;Float;False;Flipbook;-1;;19;53c2488c220f6564ca6c90721ee16673;2,71,1,68,0;8;51;SAMPLER2D;0.0;False;13;FLOAT2;0,0;False;4;FLOAT;11;False;5;FLOAT;1;False;24;FLOAT;0;False;2;FLOAT;0;False;55;FLOAT;0;False;70;FLOAT;0;False;5;COLOR;53;FLOAT2;0;FLOAT;47;FLOAT;48;FLOAT;62
Node;AmplifyShaderEditor.FloorOpNode;130;-1062.12,-565.1186;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;233;217.6478,914.0342;Float;False;Constant;_Float2;Float 2;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;137;-930.1705,-1303.679;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FloorOpNode;92;-1177.692,866.6968;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;208;-682.2909,-1773.527;Float;False;Flipbook;-1;;17;53c2488c220f6564ca6c90721ee16673;2,71,1,68,0;8;51;SAMPLER2D;sampler51132;False;13;FLOAT2;0,0;False;4;FLOAT;11;False;5;FLOAT;1;False;24;FLOAT;0;False;2;FLOAT;0;False;55;FLOAT;0;False;70;FLOAT;0;False;5;COLOR;53;FLOAT2;0;FLOAT;47;FLOAT;48;FLOAT;62
Node;AmplifyShaderEditor.FloorOpNode;109;-1043.667,105.2104;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;209;-711.2694,-2375.47;Float;False;Flipbook;-1;;18;53c2488c220f6564ca6c90721ee16673;2,71,1,68,0;8;51;SAMPLER2D;sampler51209;False;13;FLOAT2;0,0;False;4;FLOAT;11;False;5;FLOAT;1;False;24;FLOAT;0;False;2;FLOAT;0;False;55;FLOAT;0;False;70;FLOAT;0;False;5;COLOR;53;FLOAT2;0;FLOAT;47;FLOAT;48;FLOAT;62
Node;AmplifyShaderEditor.FloorOpNode;138;-998.17,-1051.678;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;129;-1020.161,-746.2418;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;114;-875.6674,-164.7896;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;391;1433.638,347.3021;Float;False;Property;_WallpaperDepth;Wallpaper Depth;17;0;Create;True;0;0;False;0;0.2;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;392;894.6138,840.515;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;402;1493.452,441.1326;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;140;-647.151,-1189.827;Float;False;Flipbook;-1;;27;53c2488c220f6564ca6c90721ee16673;2,71,1,68,0;8;51;SAMPLER2D;sampler51140;False;13;FLOAT2;0,0;False;4;FLOAT;11;False;5;FLOAT;1;False;24;FLOAT;0;False;2;FLOAT;0;False;55;FLOAT;0;False;70;FLOAT;0;False;5;COLOR;53;FLOAT2;0;FLOAT;47;FLOAT;48;FLOAT;62
Node;AmplifyShaderEditor.SimpleAddOpNode;213;-197.0999,-1925.793;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;115;-596.4379,-42.53973;Float;False;Flipbook;-1;;25;53c2488c220f6564ca6c90721ee16673;2,71,1,68,0;8;51;SAMPLER2D;sampler51115;False;13;FLOAT2;0,0;False;4;FLOAT;11;False;5;FLOAT;1;False;24;FLOAT;0;False;2;FLOAT;0;False;55;FLOAT;0;False;70;FLOAT;0;False;5;COLOR;53;FLOAT2;0;FLOAT;47;FLOAT;48;FLOAT;62
Node;AmplifyShaderEditor.FunctionNode;85;-609.3336,488.3563;Float;False;Flipbook;-1;;24;53c2488c220f6564ca6c90721ee16673;2,71,1,68,0;8;51;SAMPLER2D;0.0;False;13;FLOAT2;0,0;False;4;FLOAT;11;False;5;FLOAT;1;False;24;FLOAT;0;False;2;FLOAT;0;False;55;FLOAT;0;False;70;FLOAT;0;False;5;COLOR;53;FLOAT2;0;FLOAT;47;FLOAT;48;FLOAT;62
Node;AmplifyShaderEditor.LerpOp;232;439.0952,909.5829;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;132;-672.3346,-735.601;Float;False;Flipbook;-1;;26;53c2488c220f6564ca6c90721ee16673;2,71,1,68,0;8;51;SAMPLER2D;sampler51132;False;13;FLOAT2;0,0;False;4;FLOAT;11;False;5;FLOAT;1;False;24;FLOAT;0;False;2;FLOAT;0;False;55;FLOAT;0;False;70;FLOAT;0;False;5;COLOR;53;FLOAT2;0;FLOAT;47;FLOAT;48;FLOAT;62
Node;AmplifyShaderEditor.ParallaxMappingNode;394;1745.126,409.1878;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;299;768.4943,-128.8135;Float;False;6;6;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;301;2095.311,587.4131;Float;False;Property;_WallpaperColor;Wallpaper Color;3;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;403;2521.305,440.6286;Float;True;Property;_Mask;Mask;5;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;156;2358.933,292.9119;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;160;2021.502,338.7413;Float;True;Property;_WallpaperTexture;Wallpaper Texture;2;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;408;2835.425,404.239;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;163;782.3088,202.1599;Float;False;Property;_NumberColor;Number Color;1;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;300;2355.309,431.4142;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;411;3075.49,351.4274;Float;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;307;2425.69,64.813;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;295;3245.793,328.4597;Float;False;Property;_NumberCutout;Number Cutout;15;0;Create;True;0;0;False;0;0;2;0;COLOR;1,1,1,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;164;2638.202,68.18324;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,1;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3512.378,113.6542;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;Watch Amplify;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;19;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;214;0;67;2
WireConnection;153;0;67;2
WireConnection;228;0;153;0
WireConnection;228;1;214;0
WireConnection;101;0;59;0
WireConnection;217;0;216;0
WireConnection;69;0;228;0
WireConnection;220;0;218;0
WireConnection;220;1;216;0
WireConnection;58;0;218;0
WireConnection;58;1;59;0
WireConnection;219;0;217;0
WireConnection;102;0;101;0
WireConnection;212;0;191;0
WireConnection;60;0;58;0
WireConnection;60;1;102;0
WireConnection;221;0;220;0
WireConnection;221;1;219;0
WireConnection;193;0;192;0
WireConnection;148;0;146;0
WireConnection;384;0;221;0
WireConnection;384;2;381;0
WireConnection;384;3;382;0
WireConnection;210;0;212;0
WireConnection;210;1;211;0
WireConnection;292;0;196;1
WireConnection;292;1;294;0
WireConnection;287;0;285;0
WireConnection;385;0;60;0
WireConnection;385;2;381;0
WireConnection;385;3;382;0
WireConnection;293;0;196;1
WireConnection;293;1;294;0
WireConnection;298;0;196;2
WireConnection;298;1;297;0
WireConnection;103;0;104;0
WireConnection;279;0;280;0
WireConnection;279;1;266;0
WireConnection;62;0;385;0
WireConnection;106;0;103;0
WireConnection;106;1;105;0
WireConnection;225;0;293;0
WireConnection;225;1;298;0
WireConnection;198;0;193;0
WireConnection;276;0;280;0
WireConnection;276;1;266;0
WireConnection;288;0;287;0
WireConnection;288;1;273;0
WireConnection;195;0;210;0
WireConnection;289;0;287;0
WireConnection;289;1;273;0
WireConnection;142;0;141;0
WireConnection;303;0;262;1
WireConnection;303;1;297;0
WireConnection;291;0;292;0
WireConnection;291;1;298;0
WireConnection;222;0;384;0
WireConnection;149;0;148;0
WireConnection;149;1;147;0
WireConnection;201;0;197;0
WireConnection;201;1;225;0
WireConnection;203;0;198;0
WireConnection;107;0;106;0
WireConnection;274;0;289;0
WireConnection;274;1;297;0
WireConnection;200;0;194;0
WireConnection;200;1;291;0
WireConnection;283;0;288;0
WireConnection;283;1;297;0
WireConnection;144;0;142;0
WireConnection;269;0;279;0
WireConnection;269;1;297;0
WireConnection;90;0;93;0
WireConnection;150;0;149;0
WireConnection;275;0;276;0
WireConnection;275;1;297;0
WireConnection;202;0;195;0
WireConnection;263;0;261;0
WireConnection;263;1;303;0
WireConnection;264;0;263;0
WireConnection;400;0;399;0
WireConnection;136;0;150;0
WireConnection;205;0;202;0
WireConnection;169;0;388;0
WireConnection;169;1;168;0
WireConnection;206;0;200;0
WireConnection;135;0;133;0
WireConnection;135;1;269;0
WireConnection;108;0;107;0
WireConnection;78;0;79;0
WireConnection;78;1;283;0
WireConnection;256;0;242;2
WireConnection;113;0;110;0
WireConnection;113;1;274;0
WireConnection;127;0;125;0
WireConnection;127;1;275;0
WireConnection;128;0;144;0
WireConnection;91;0;90;0
WireConnection;207;0;203;0
WireConnection;204;0;201;0
WireConnection;124;0;77;0
WireConnection;398;0;169;0
WireConnection;398;1;399;0
WireConnection;81;0;78;0
WireConnection;258;0;256;0
WireConnection;401;0;400;0
WireConnection;260;51;124;0
WireConnection;260;13;264;0
WireConnection;260;2;265;0
WireConnection;130;0;128;0
WireConnection;137;0;135;0
WireConnection;92;0;91;0
WireConnection;208;51;124;0
WireConnection;208;13;204;0
WireConnection;208;2;207;0
WireConnection;109;0;108;0
WireConnection;209;51;124;0
WireConnection;209;13;206;0
WireConnection;209;2;205;0
WireConnection;138;0;136;0
WireConnection;129;0;127;0
WireConnection;114;0;113;0
WireConnection;402;0;398;0
WireConnection;402;1;401;0
WireConnection;140;51;124;0
WireConnection;140;13;137;0
WireConnection;140;2;138;0
WireConnection;213;0;209;53
WireConnection;213;1;208;53
WireConnection;115;51;124;0
WireConnection;115;13;114;0
WireConnection;115;2;109;0
WireConnection;85;51;124;0
WireConnection;85;13;81;0
WireConnection;85;2;92;0
WireConnection;232;0;233;0
WireConnection;232;1;260;53
WireConnection;232;2;258;0
WireConnection;132;51;124;0
WireConnection;132;13;129;0
WireConnection;132;2;130;0
WireConnection;394;0;402;0
WireConnection;394;2;391;0
WireConnection;394;3;392;0
WireConnection;299;0;213;0
WireConnection;299;1;140;53
WireConnection;299;2;132;53
WireConnection;299;3;115;53
WireConnection;299;4;85;53
WireConnection;299;5;232;0
WireConnection;156;0;299;0
WireConnection;160;1;394;0
WireConnection;408;0;156;0
WireConnection;408;1;403;0
WireConnection;300;0;160;0
WireConnection;300;1;301;0
WireConnection;411;0;156;0
WireConnection;411;1;408;0
WireConnection;307;0;300;0
WireConnection;307;1;163;0
WireConnection;307;2;299;0
WireConnection;295;0;408;0
WireConnection;295;1;411;0
WireConnection;164;0;307;0
WireConnection;0;2;164;0
WireConnection;0;10;295;0
ASEEND*/
//CHKSM=0802D0A2FAC31C629BCDD9AB41B8C879F66062D9