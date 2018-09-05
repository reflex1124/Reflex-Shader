// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ReflexShader/ReflexShader_MAX"
{
	Properties
	{
		_ASEOutlineColor( "Outline Color", Color ) = (0.2463776,0.3602941,0.3478668,1)
		_ASEOutlineWidth( "Outline Width", Float ) = 0.0001
		_Diffuse("Diffuse", 2D) = "white" {}
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_DiffuseColor("Diffuse Color", Color) = (1,1,1,0)
		_Emission("Emission", 2D) = "black" {}
		_EmissionColor("Emission Color", Color) = (1,1,1,0)
		_Normal("Normal", 2D) = "bump" {}
		[Toggle]_MatCapToggle("MatCap Toggle", Float) = 1
		_Matcap("Matcap", 2D) = "black" {}
		_MatCapColor("MatCap Color", Color) = (1,1,1,0)
		[Toggle]_MatCapShadowToggle("MatCap Shadow Toggle", Float) = 1
		_MatCapShadow("MatCap Shadow", 2D) = "white" {}
		_MatCapShadowColor("MatCap Shadow Color", Color) = (0.1960784,0.1960784,0.1960784,0)
		[Toggle]_MatCapMaskToggle("MatCap Mask Toggle", Float) = 0
		_MatCapMask("MatCap Mask", 2D) = "black" {}
		[Toggle]_RimLightToggle("RimLight Toggle", Float) = 1
		_RimLightColor("RimLight Color", Color) = (1,1,1,0)
		_RimLightPower("RimLight Power", Range( 0 , 1)) = 0
		_RimLightContrast("RimLight Contrast", Range( 0 , 10)) = 3
		_RimLightMask("RimLight Mask", 2D) = "white" {}
		[Toggle]_DisableOpacityCutout("Disable Opacity Cutout", Float) = 0
		[Toggle]_ForceMatCap("Force MatCap", Float) = 0
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
		

		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			float3 viewDir;
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
		uniform float4 _EmissionColor;
		uniform float _DisableOpacityCutout;
		uniform sampler2D _Diffuse;
		uniform float4 _Diffuse_ST;
		uniform float _RimLightToggle;
		uniform float _RimLightPower;
		uniform float _RimLightContrast;
		uniform float4 _RimLightColor;
		uniform sampler2D _RimLightMask;
		uniform float4 _RimLightMask_ST;
		uniform float _MatCapToggle;
		uniform sampler2D _Matcap;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float4 _MatCapColor;
		uniform float _MatCapMaskToggle;
		uniform float _ForceMatCap;
		uniform sampler2D _MatCapMask;
		uniform float4 _MatCapMask_ST;
		uniform float4 _DiffuseColor;
		uniform float _MatCapShadowToggle;
		uniform sampler2D _MatCapShadow;
		uniform float4 _MatCapShadowColor;
		uniform float _Cutoff = 0.5;


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
			float2 uv_Diffuse = i.uv_texcoord * _Diffuse_ST.xy + _Diffuse_ST.zw;
			float4 tex2DNode13 = tex2D( _Diffuse, uv_Diffuse );
			float4 temp_cast_1 = (0.0).xxxx;
			float3 ase_worldNormal = i.worldNormal;
			float dotResult126 = dot( ase_worldNormal , i.viewDir );
			float4 temp_cast_2 = (0.0).xxxx;
			float2 uv_RimLightMask = i.uv_texcoord * _RimLightMask_ST.xy + _RimLightMask_ST.zw;
			float4 lerpResult70 = lerp( ( ( ( ( ( abs( ( 1.0 - dotResult126 ) ) * _RimLightPower ) - 0.5 ) * _RimLightContrast ) + 0.5 ) * _RimLightColor ) , temp_cast_2 , ( 1.0 - tex2D( _RimLightMask, uv_RimLightMask ) ).r);
			float4 clampResult97 = clamp( lerp(temp_cast_1,lerpResult70,_RimLightToggle) , float4( 0,0,0,0 ) , float4( 1,1,1,1 ) );
			float4 temp_cast_4 = (0.0).xxxx;
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float4 blendOpSrc77 = tex2D( _Normal, uv_Normal );
			float4 blendOpDest77 = float4( mul( UNITY_MATRIX_V, float4( ase_worldNormal , 0.0 ) ).xyz , 0.0 );
			float4 temp_output_33_0 = ( 0.5 + ( 0.5 * ((( blendOpDest77 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest77 - 0.5 ) ) * ( 1.0 - blendOpSrc77 ) ) : ( 2.0 * blendOpDest77 * blendOpSrc77 ) )).rgba ) );
			float4 blendOpSrc44 = lerp(temp_cast_4,tex2D( _Matcap, temp_output_33_0.rg ),_MatCapToggle);
			float4 blendOpDest44 = _MatCapColor;
			float4 temp_cast_9 = (0.0).xxxx;
			float4 temp_cast_10 = (0.0).xxxx;
			float2 uv_MatCapMask = i.uv_texcoord * _MatCapMask_ST.xy + _MatCapMask_ST.zw;
			float4 lerpResult67 = lerp( ( saturate( ( blendOpSrc44 * blendOpDest44 ) )) , temp_cast_9 , lerp(temp_cast_10,( 1.0 - lerp(tex2D( _MatCapMask, uv_MatCapMask ),float4( 1,1,1,0 ),_ForceMatCap) ),_MatCapMaskToggle).r);
			float4 temp_cast_12 = (0.0).xxxx;
			float4 lerpResult79 = lerp( ( tex2DNode13 * _DiffuseColor ) , temp_cast_12 , lerp(tex2D( _MatCapMask, uv_MatCapMask ),float4( 1,1,1,0 ),_ForceMatCap));
			float4 temp_cast_13 = (1.0).xxxx;
			float4 blendOpSrc47 = lerp(temp_cast_13,tex2D( _MatCapShadow, temp_output_33_0.rg ),_MatCapShadowToggle);
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
			float4 clampResult114 = clamp( ( ( clampResult97 + lerpResult67 + lerpResult79 ) * ( saturate( ( blendOpSrc47 + blendOpDest47 ) )) * float4( clampResult26 , 0.0 ) ) , float4( 0,0,0,0 ) , float4( 1,1,1,1 ) );
			c.rgb = clampResult114.rgb;
			c.a = 1;
			clip( lerp(tex2DNode13.a,1.0,_DisableOpacityCutout) - _Cutoff );
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
			o.Emission = ( tex2D( _Emission, uv_Emission ) * _EmissionColor ).rgb;
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
				surfIN.viewDir = worldViewDir;
				surfIN.worldNormal = IN.worldNormal;
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
8;524;1541;486;123.2877;769.3157;1;True;False
Node;AmplifyShaderEditor.WorldNormalVector;148;-1812.845,-1403.4;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;149;-1803.77,-1257.435;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;126;-1545.138,-1323.811;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewMatrixNode;27;-1726.458,-570.2852;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.WorldNormalVector;28;-1752.358,-492.4562;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.OneMinusNode;127;-1411.277,-1309.371;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;74;-1764.51,-796.1074;Float;True;Property;_Normal;Normal;5;0;Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.AbsOpNode;128;-1194.156,-1299.931;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;104;-1323.441,-1208.525;Float;False;Property;_RimLightPower;RimLight Power;16;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-1512.72,-528.5377;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;110;-971.6877,-1162.905;Float;False;Constant;_Float9;Float 9;20;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;103;-962.9938,-1286.904;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;77;-1327.792,-557.3956;Float;False;Overlay;False;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-1046.363,-695.2139;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;111;-795.9023,-1182.408;Float;False;Property;_RimLightContrast;RimLight Contrast;17;0;Create;True;0;0;False;0;3;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;30;-1059.864,-561.045;Float;False;True;True;True;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;109;-699.6885,-1296.905;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-809.3852,-581.0341;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;112;-459.6884,-1286.905;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;113;-224.9738,-1268.221;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;52;-344.3295,-1134.976;Float;False;Property;_RimLightColor;RimLight Color;15;0;Create;True;0;0;False;0;1,1,1,0;0.3676468,0.4243406,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;72;-37.44014,-1141.639;Float;True;Property;_RimLightMask;RimLight Mask;18;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldSpaceCameraPos;24;583.6185,290.1242;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;23;628.6473,458.4625;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;33;-636.795,-635.4793;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;69;216.9431,-567.612;Float;True;Property;_MatCapMask;MatCap Mask;13;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;73;282.5685,-1143.266;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-320.605,-886.7936;Float;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;34;-449.5687,-791.725;Float;True;Property;_Matcap;Matcap;7;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-27.41248,-1286.568;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;8;926.433,356.7384;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;71;143.6331,-1220.988;Float;False;Constant;_Float5;Float 5;13;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;150;570.7644,-522.6669;Float;False;Property;_ForceMatCap;Force MatCap;20;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;93;567.8779,-211.9866;Float;False;Property;_DiffuseColor;Diffuse Color;2;0;Create;True;0;0;False;0;1,1,1,0;0.8156863,0.8705882,0.8745098,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;70;510.4327,-1277.879;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;4;926.837,159.9272;Float;False;Constant;_Vector0;Vector 0;1;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LightAttenuation;15;1043.66,501.9701;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;16;1070.074,596.6234;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;63;474.0959,-1371.444;Float;False;Constant;_Float3;Float 3;10;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;45;-34.01346,-600.0623;Float;False;Property;_MatCapColor;MatCap Color;8;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;36;-43.24121,-717.2181;Float;False;Property;_MatCapToggle;MatCap Toggle;6;0;Create;True;0;0;False;0;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalizeNode;7;1112.434,359.7384;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;13;101.8535,-121.5731;Float;True;Property;_Diffuse;Diffuse;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;89;806.7901,-702.194;Float;False;Constant;_Float6;Float 6;17;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;78;842.1934,-600.6185;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CustomExpressionNode;5;1173.352,185.279;Float;False;return ShadeSH9(half4(normal, 1.0))@$;3;False;1;True;normal;FLOAT3;0,0,0;In;;Function_ShadeSH9;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;1336.425,521.7811;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendOpsNode;44;237.4265,-685.9493;Float;False;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;68;456.3132,-611.0014;Float;False;Constant;_Float4;Float 4;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-315.0429,-573.5999;Float;False;Constant;_Float2;Float 2;5;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;62;796.6344,-1271.331;Float;False;Property;_RimLightToggle;RimLight Toggle;14;0;Create;True;0;0;False;0;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;92;808.7463,-411.0303;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;88;1042.789,-652.2038;Float;False;Property;_MatCapMaskToggle;MatCap Mask Toggle;12;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;39;-452.6353,-484.8851;Float;True;Property;_MatCapShadow;MatCap Shadow;10;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomExpressionNode;6;1279.434,357.7386;Float;False;float4 val = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, 7)@$float3 reflCol = DecodeHDR(val, unity_SpecCube0_HDR)@$return reflCol * 0.02@;3;False;1;True;reflVect;FLOAT3;0,0,0;In;;Cubemap Reflections;True;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;40;-36.67926,-404.0242;Float;False;Property;_MatCapShadowToggle;MatCap Shadow Toggle;9;0;Create;True;0;0;False;0;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;97;1160.571,-1269.952;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;1565.696,338.0486;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;67;1310.15,-691.1347;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;79;1073.152,-475.0547;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;46;-31.62536,-296.4366;Float;False;Property;_MatCapShadowColor;MatCap Shadow Color;11;0;Create;True;0;0;False;0;0.1960784,0.1960784,0.1960784,0;0.5607843,0.2784311,0.3215683,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;26;1734.402,340.703;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendOpsNode;47;276.0024,-322.7519;Float;False;LinearDodge;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;1519.78,-588.2934;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;22;1976.686,-610.6523;Float;True;Property;_Emission;Emission;3;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;85;793.1063,12.75139;Float;False;Constant;_Float7;Float 7;17;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;2086.092,-88.24368;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;95;2001.849,-381.8332;Float;False;Property;_EmissionColor;Emission Color;4;0;Create;True;0;0;False;0;1,1,1,0;0.8392157,0.8392157,0.8392157,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;114;2374.373,-92.99813;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,1;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;84;975.1115,-110.6096;Float;False;Property;_DisableOpacityCutout;Disable Opacity Cutout;19;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;2367.301,-457.3961;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;65;2611.217,-332.1141;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;ReflexShader/ReflexShader_MAX;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;True;0.0001;0.2463776,0.3602941,0.3478668,1;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;126;0;148;0
WireConnection;126;1;149;0
WireConnection;127;0;126;0
WireConnection;128;0;127;0
WireConnection;29;0;27;0
WireConnection;29;1;28;0
WireConnection;103;0;128;0
WireConnection;103;1;104;0
WireConnection;77;0;74;0
WireConnection;77;1;29;0
WireConnection;30;0;77;0
WireConnection;109;0;103;0
WireConnection;109;1;110;0
WireConnection;32;0;31;0
WireConnection;32;1;30;0
WireConnection;112;0;109;0
WireConnection;112;1;111;0
WireConnection;113;0;112;0
WireConnection;113;1;110;0
WireConnection;33;0;31;0
WireConnection;33;1;32;0
WireConnection;73;0;72;0
WireConnection;34;1;33;0
WireConnection;51;0;113;0
WireConnection;51;1;52;0
WireConnection;8;0;24;0
WireConnection;8;1;23;0
WireConnection;150;0;69;0
WireConnection;70;0;51;0
WireConnection;70;1;71;0
WireConnection;70;2;73;0
WireConnection;36;0;37;0
WireConnection;36;1;34;0
WireConnection;7;0;8;0
WireConnection;78;0;150;0
WireConnection;5;0;4;0
WireConnection;17;0;15;0
WireConnection;17;1;16;1
WireConnection;44;0;36;0
WireConnection;44;1;45;0
WireConnection;62;0;63;0
WireConnection;62;1;70;0
WireConnection;92;0;13;0
WireConnection;92;1;93;0
WireConnection;88;0;89;0
WireConnection;88;1;78;0
WireConnection;39;1;33;0
WireConnection;6;0;7;0
WireConnection;40;0;38;0
WireConnection;40;1;39;0
WireConnection;97;0;62;0
WireConnection;12;0;5;0
WireConnection;12;1;6;0
WireConnection;12;2;17;0
WireConnection;67;0;44;0
WireConnection;67;1;68;0
WireConnection;67;2;88;0
WireConnection;79;0;92;0
WireConnection;79;1;68;0
WireConnection;79;2;150;0
WireConnection;26;0;12;0
WireConnection;47;0;40;0
WireConnection;47;1;46;0
WireConnection;35;0;97;0
WireConnection;35;1;67;0
WireConnection;35;2;79;0
WireConnection;41;0;35;0
WireConnection;41;1;47;0
WireConnection;41;2;26;0
WireConnection;114;0;41;0
WireConnection;84;0;13;4
WireConnection;84;1;85;0
WireConnection;94;0;22;0
WireConnection;94;1;95;0
WireConnection;65;2;94;0
WireConnection;65;10;84;0
WireConnection;65;13;114;0
ASEEND*/
//CHKSM=CA351F53CE04666C9F6DF0F1CF6888544364FF27