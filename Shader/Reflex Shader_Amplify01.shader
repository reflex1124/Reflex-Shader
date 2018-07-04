// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ReflexShader/ReflexShader_Amplify 01"
{
	Properties
	{
		_ASEOutlineColor( "Outline Color", Color ) = (0,0,0,0)
		_ASEOutlineWidth( "Outline Width", Float ) = 0
		_Diffuse("Diffuse", 2D) = "white" {}
		_Emission("Emission", 2D) = "black" {}
		[Toggle]_MatCapToggle("MatCap Toggle", Float) = 0
		_Matcap("Matcap", 2D) = "black" {}
		_MatCapColor("MatCap Color", Color) = (1,1,1,0)
		[Toggle]_MatCapShadowToggle("MatCap Shadow Toggle", Float) = 0
		_MatCapShadow("MatCap Shadow", 2D) = "white" {}
		_MatCapShadowColor("MatCap Shadow Color", Color) = (0.1960784,0.1960784,0.1960784,0)
		[Toggle]_RimLightToggle("RimLight Toggle", Float) = 0
		_RimLightColor("RimLight Color", Color) = (1,1,1,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ }
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		uniform half4 _ASEOutlineColor;
		uniform half _ASEOutlineWidth;
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += ( v.normal * _ASEOutlineWidth );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			o.Emission = _ASEOutlineColor.rgb;
			o.Alpha = 1;
		}
		ENDCG
		

		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Off
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
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

		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform float _RimLightToggle;
		uniform float4 _RimLightColor;
		uniform float _MatCapToggle;
		uniform sampler2D _Matcap;
		uniform float4 _MatCapColor;
		uniform sampler2D _Diffuse;
		uniform float4 _Diffuse_ST;
		uniform float _MatCapShadowToggle;
		uniform sampler2D _MatCapShadow;
		uniform float4 _MatCapShadowColor;


		float3 Function_ShadeSH9( float3 normal )
		{
			return ShadeSH9(half4(normal, 1.0));
		}


		float3 CubemapReflections6( float3 reflVect )
		{
			float4 val = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, 7);
			float3 reflCol = DecodeHDR(val, unity_SpecCube0_HDR);
			return reflCol * 0.02;
		}


		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float4 temp_cast_2 = (0.0).xxxx;
			float3 ase_worldNormal = i.worldNormal;
			float3 temp_output_33_0 = ( 0.5 + ( 0.5 * (mul( UNITY_MATRIX_V, float4( ase_worldNormal , 0.0 ) ).xyz).xyz ) );
			float4 blendOpSrc44 = lerp(temp_cast_2,tex2D( _Matcap, temp_output_33_0.xy ),_MatCapToggle);
			float4 blendOpDest44 = _MatCapColor;
			float2 uv_Diffuse = i.uv_texcoord * _Diffuse_ST.xy + _Diffuse_ST.zw;
			float4 temp_cast_6 = (1.0).xxxx;
			float4 blendOpSrc47 = lerp(temp_cast_6,tex2D( _MatCapShadow, temp_output_33_0.xy ),_MatCapShadowToggle);
			float4 blendOpDest47 = _MatCapShadowColor;
			float3 normal5 = float3(0,1,0);
			float3 localFunction_ShadeSH95 = Function_ShadeSH9( normal5 );
			float4 transform23 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float4 normalizeResult7 = normalize( ( float4( _WorldSpaceCameraPos , 0.0 ) - transform23 ) );
			float3 reflVect6 = normalizeResult7.xyz;
			float3 localCubemapReflections6 = CubemapReflections6( reflVect6 );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 clampResult26 = clamp( ( localFunction_ShadeSH95 + localCubemapReflections6 + ( ase_lightAtten * ase_lightColor.rgb ) ) , float3( 0,0,0 ) , float3( 1,1,1 ) );
			c.rgb = ( ( ( saturate( ( blendOpSrc44 * blendOpDest44 ) )) + tex2D( _Diffuse, uv_Diffuse ) ) * ( saturate( ( blendOpSrc47 + blendOpDest47 ) )) * float4( clampResult26 , 0.0 ) ).rgb;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			float4 temp_cast_0 = (0.0).xxxx;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV48 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode48 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV48, 5.0 ) );
			o.Emission = ( tex2D( _Emission, uv_Emission ) + lerp(temp_cast_0,( fresnelNode48 * _RimLightColor ),_RimLightToggle) ).rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows noshadow exclude_path:deferred 

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
				float3 worldPos : TEXCOORD2;
				float3 worldNormal : TEXCOORD3;
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
				o.worldNormal = worldNormal;
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
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
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
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
0;503;1534;515;1106.864;562.6285;1.7582;True;True
Node;AmplifyShaderEditor.ViewMatrixNode;27;-1505.268,-759.6079;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.WorldNormalVector;28;-1527.188,-668.9328;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-1236.352,-682.0499;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;30;-1051.108,-688.3481;Float;False;True;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-1252.922,-778.6464;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-796.5358,-728.801;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;24;-1048.982,133.3021;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;23;-1003.953,301.6404;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;33;-648.9456,-780.2463;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;8;-706.167,199.9164;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector3Node;4;-691.947,-47.39201;Float;False;Constant;_Vector0;Vector 0;1;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;7;-520.1669,202.9164;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LightColorNode;16;-562.5261,439.801;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;37;-320.605,-886.7936;Float;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;15;-588.9405,345.1479;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;34;-449.5687,-791.725;Float;True;Property;_Matcap;Matcap;3;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-296.1761,364.9588;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;6;-353.1669,200.9165;Float;False;float4 val = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, 7)@$float3 reflCol = DecodeHDR(val, unity_SpecCube0_HDR)@$return reflCol * 0.02@;3;False;1;True;reflVect;FLOAT3;0,0,0;In;;Cubemap Reflections;True;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-315.0429,-573.5999;Float;False;Constant;_Float2;Float 2;5;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;45;-34.01346,-600.0623;Float;False;Property;_MatCapColor;MatCap Color;4;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomExpressionNode;5;-467.3368,-40.29325;Float;False;return ShadeSH9(half4(normal, 1.0))@$;3;False;1;True;normal;FLOAT3;0,0,0;In;;Function_ShadeSH9;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FresnelNode;48;-1083.515,-1195.549;Float;False;Standard;TangentNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;36;-43.24121,-717.2181;Float;False;Property;_MatCapToggle;MatCap Toggle;2;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;39;-452.6353,-484.8851;Float;True;Property;_MatCapShadow;MatCap Shadow;6;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;52;-808.5128,-1072.354;Float;False;Property;_RimLightColor;RimLight Color;9;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-66.90486,181.2266;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-491.5953,-1211.732;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;44;237.4265,-685.9493;Float;False;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;46;-31.62536,-296.4366;Float;False;Property;_MatCapShadowColor;MatCap Shadow Color;7;0;Create;True;0;0;False;0;0.1960784,0.1960784,0.1960784,0;0.1960784,0.1960784,0.1960784,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;40;-36.67926,-404.0242;Float;False;Property;_MatCapShadowToggle;MatCap Shadow Toggle;5;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-489.178,-1289.758;Float;False;Constant;_Float3;Float 3;10;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;13;-89.47359,-63.11117;Float;True;Property;_Diffuse;Diffuse;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;26;101.801,183.8809;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;622.3865,115.2146;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;22;-867.163,-1418.755;Float;True;Property;_Emission;Emission;1;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;62;-239.3862,-1239.368;Float;False;Property;_RimLightToggle;RimLight Toggle;8;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;47;223.6917,-358.967;Float;False;LinearDodge;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;58;122.6572,-1289.047;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;789.1786,129.5874;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;2;1009.703,-94.95576;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;ReflexShader/ReflexShader_Amplify 01;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;True;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;29;0;27;0
WireConnection;29;1;28;0
WireConnection;30;0;29;0
WireConnection;32;0;31;0
WireConnection;32;1;30;0
WireConnection;33;0;31;0
WireConnection;33;1;32;0
WireConnection;8;0;24;0
WireConnection;8;1;23;0
WireConnection;7;0;8;0
WireConnection;34;1;33;0
WireConnection;17;0;15;0
WireConnection;17;1;16;1
WireConnection;6;0;7;0
WireConnection;5;0;4;0
WireConnection;36;0;37;0
WireConnection;36;1;34;0
WireConnection;39;1;33;0
WireConnection;12;0;5;0
WireConnection;12;1;6;0
WireConnection;12;2;17;0
WireConnection;51;0;48;0
WireConnection;51;1;52;0
WireConnection;44;0;36;0
WireConnection;44;1;45;0
WireConnection;40;0;38;0
WireConnection;40;1;39;0
WireConnection;26;0;12;0
WireConnection;35;0;44;0
WireConnection;35;1;13;0
WireConnection;62;0;63;0
WireConnection;62;1;51;0
WireConnection;47;0;40;0
WireConnection;47;1;46;0
WireConnection;58;0;22;0
WireConnection;58;1;62;0
WireConnection;41;0;35;0
WireConnection;41;1;47;0
WireConnection;41;2;26;0
WireConnection;2;2;58;0
WireConnection;2;13;41;0
ASEEND*/
//CHKSM=C3EC7963BB0FED68A3395095C7A108FF1A4D6D44