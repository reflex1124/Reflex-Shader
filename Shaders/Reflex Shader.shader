// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ReflexShaders/ReflexShader"
{
	Properties
	{
		_MainTex("Diffuse", 2D) = "white" {}
		_DiffuseColor("Diffuse Color", Color) = (1,1,1,1)
		_EmissionMap("Emission", 2D) = "black" {}
		_EmissionColor("Emission Color", Color) = (1,1,1,0)
		_Normal("Normal", 2D) = "bump" {}
		[Toggle]_MatCapToggle("MatCap Toggle", Float) = 1
		_Matcap("Matcap", 2D) = "black" {}
		_MatCapColor("MatCap Color", Color) = (1,1,1,0)
		[Toggle]_MatCapShadowToggle("MatCap Shadow Toggle", Float) = 1
		_MatCapShadow("MatCap Shadow", 2D) = "white" {}
		_MatCapShadowColor("MatCap Shadow Color", Color) = (0.7843137,0.7843137,0.7843137,0)
		[Toggle]_MatCapMaskToggle("MatCap Mask Toggle", Float) = 0
		_MatCapMask("MatCap Mask", 2D) = "black" {}
		[Toggle]_RimLightToggle("RimLight Toggle", Float) = 1
		_RimLightColor("RimLight Color", Color) = (1,1,1,0)
		_RimLightPower("RimLight Power", Range( 0 , 1)) = 0
		_RimLightContrast("RimLight Contrast", Range( 0 , 10)) = 3
		_RimLightMask("RimLight Mask", 2D) = "white" {}
		[Toggle]_OpacityCutoutToggle("Opacity Cutout Toggle", Float) = 0
		[Toggle]_ForceMatCap("Force MatCap", Float) = 0
		_OutlineWidth("Outline Width", Range( 0 , 1)) = 0
		_OutlineMask("Outline Mask", 2D) = "white" {}
		_OutlineColor("Outline Color", Color) = (0.2941176,0.2941176,0.2941176,0)
		_Cutoff( "Mask Clip Value", Float ) = 0.5
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
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv_OutlineMask = v.texcoord * _OutlineMask_ST.xy + _OutlineMask_ST.zw;
			float outlineVar = ( (0.0 + (_OutlineWidth - 0.0) * (0.0002 - 0.0) / (1.0 - 0.0)) * tex2Dlod( _OutlineMask, float4( uv_OutlineMask, 0, 0.0) ) ).r;
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 Diffuse154 = ( tex2D( _MainTex, uv_MainTex ) * _DiffuseColor );
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
			float3 clampResult26 = clamp( ( localFunction_ShadeSH95 + localCubemapReflections6 + ( 1 * ase_lightColor.rgb ) ) , float3( 0,0,0 ) , float3( 1,1,1 ) );
			float3 Lighting177 = clampResult26;
			o.Emission = ( ( Diffuse154 * _OutlineColor ) * float4( Lighting177 , 0.0 ) ).rgb;
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

		uniform sampler2D _EmissionMap;
		uniform float4 _EmissionMap_ST;
		uniform float4 _EmissionColor;
		uniform float _OpacityCutoutToggle;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _DiffuseColor;
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
		uniform float _MatCapShadowToggle;
		uniform sampler2D _MatCapShadow;
		uniform float4 _MatCapShadowColor;
		uniform float _Cutoff = 0.5;
		uniform float _OutlineWidth;
		uniform sampler2D _OutlineMask;
		uniform float4 _OutlineMask_ST;
		uniform float4 _OutlineColor;


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


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += 0;
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
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 Diffuse154 = ( tex2D( _MainTex, uv_MainTex ) * _DiffuseColor );
			float3 ase_worldNormal = i.worldNormal;
			float dotResult126 = dot( ase_worldNormal , i.viewDir );
			float2 uv_RimLightMask = i.uv_texcoord * _RimLightMask_ST.xy + _RimLightMask_ST.zw;
			float4 lerpResult70 = lerp( ( ( ( ( ( abs( ( 1.0 - dotResult126 ) ) * _RimLightPower ) - 0.5 ) * _RimLightContrast ) + 0.5 ) * _RimLightColor ) , float4( 0,0,0,0 ) , ( 1.0 - tex2D( _RimLightMask, uv_RimLightMask ) ).r);
			float4 clampResult97 = clamp( lerp(float4( 0,0,0,0 ),lerpResult70,_RimLightToggle) , float4( 0,0,0,0 ) , float4( 1,1,1,1 ) );
			float4 RimLight168 = clampResult97;
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float4 blendOpSrc77 = tex2D( _Normal, uv_Normal );
			float4 blendOpDest77 = float4( mul( UNITY_MATRIX_V, float4( ase_worldNormal , 0.0 ) ).xyz , 0.0 );
			float4 temp_output_33_0 = ( 0.5 + ( 0.5 * ((( blendOpDest77 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest77 - 0.5 ) ) * ( 1.0 - blendOpSrc77 ) ) : ( 2.0 * blendOpDest77 * blendOpSrc77 ) )).rgba ) );
			float4 blendOpSrc44 = lerp(float4( 0,0,0,0 ),tex2D( _Matcap, temp_output_33_0.rg ),_MatCapToggle);
			float4 blendOpDest44 = _MatCapColor;
			float2 uv_MatCapMask = i.uv_texcoord * _MatCapMask_ST.xy + _MatCapMask_ST.zw;
			float4 lerpResult67 = lerp( ( saturate( ( blendOpSrc44 * blendOpDest44 ) )) , float4( 0,0,0,0 ) , lerp(float4( 0,0,0,0 ),( 1.0 - lerp(tex2D( _MatCapMask, uv_MatCapMask ),float4( 1,1,1,0 ),_ForceMatCap) ),_MatCapMaskToggle).r);
			float4 lerpResult79 = lerp( Diffuse154 , float4( 0,0,0,0 ) , lerp(tex2D( _MatCapMask, uv_MatCapMask ),float4( 1,1,1,0 ),_ForceMatCap).r);
			float4 Matcap181 = ( lerpResult67 + lerpResult79 );
			float4 blendOpSrc47 = lerp(float4( 1,1,1,1 ),tex2D( _MatCapShadow, temp_output_33_0.rg ),_MatCapShadowToggle);
			float4 blendOpDest47 = _MatCapShadowColor;
			float4 MatcapShadow174 = ( saturate( ( blendOpSrc47 + blendOpDest47 ) ));
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
			float3 Lighting177 = clampResult26;
			float4 clampResult114 = clamp( ( ( RimLight168 + Matcap181 ) * MatcapShadow174 * float4( Lighting177 , 0.0 ) ) , float4( 0,0,0,0 ) , float4( 1,1,1,1 ) );
			c.rgb = clampResult114.rgb;
			c.a = 1;
			clip( lerp(1.0,Diffuse154.a,_OpacityCutoutToggle) - _Cutoff );
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			float2 uv_EmissionMap = i.uv_texcoord * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
			o.Emission = ( tex2D( _EmissionMap, uv_EmissionMap ) * _EmissionColor ).rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows noshadow exclude_path:deferred vertex:vertexDataFunc 

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
				vertexDataFunc( v, customInputData );
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
1136;92;784;926;-1281.015;1512.646;2.741359;True;False
Node;AmplifyShaderEditor.CommentaryNode;164;-1968.388,-1468.818;Float;False;3407.992;541.761;;21;97;62;70;51;73;72;113;52;112;111;109;110;103;128;104;127;126;149;148;168;190;Rim Light;0,0.7103448,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;183;-2172.789,-715.9241;Float;False;3782.673;847.3568;;28;27;28;74;29;77;30;31;32;33;69;150;34;45;36;78;44;39;46;40;47;170;174;88;79;67;180;181;189;Matcap;0.03448272,1,0,1;0;0
Node;AmplifyShaderEditor.WorldNormalVector;148;-1914.388,-1338.818;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;149;-1905.313,-1192.853;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;28;-2110.637,-271.5868;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewMatrixNode;27;-2084.737,-349.4158;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.DotProductOpNode;126;-1650.681,-1339.229;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;74;-2122.789,-575.2379;Float;True;Property;_Normal;Normal;4;0;Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-1871,-307.6683;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;127;-1516.82,-1324.789;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;104;-1428.984,-1217.797;Float;False;Property;_RimLightPower;RimLight Power;15;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;77;-1686.072,-336.5262;Float;False;Overlay;False;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.AbsOpNode;128;-1299.699,-1315.349;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;110;-1066.012,-1170.031;Float;False;Constant;_Float9;Float 9;20;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-1358.043,-467.9442;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;103;-1068.537,-1302.322;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;30;-1418.144,-340.1755;Float;False;True;True;True;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;109;-827.2319,-1310.323;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;111;-847.4457,-1205.826;Float;False;Property;_RimLightContrast;RimLight Contrast;16;0;Create;True;0;0;False;0;3;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-1167.664,-360.1647;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;190;-508.2236,-1152.896;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;112;-545.2318,-1312.323;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;69;-141.3358,-346.7426;Float;True;Property;_MatCapMask;MatCap Mask;12;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;33;-995.0739,-414.6097;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;159;-166.3673,356.9811;Float;False;1623.785;656.6963;;13;177;26;12;5;6;17;4;7;15;16;8;24;23;Lighting;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;173;-1442.904,467.3162;Float;False;1089.884;388.5471;;4;92;93;13;154;Diffuse;0,0.7931037,1,1;0;0
Node;AmplifyShaderEditor.ToggleSwitchNode;150;212.4854,-301.7975;Float;False;Property;_ForceMatCap;Force MatCap;19;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;23;-71.33855,705.5164;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;13;-1392.904,547.5065;Float;True;Property;_MainTex;Diffuse;0;0;Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;34;-807.8476,-570.8555;Float;True;Property;_Matcap;Matcap;6;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;52;-399.873,-1158.394;Float;False;Property;_RimLightColor;RimLight Color;14;0;Create;True;0;0;False;0;1,1,1,0;0.3676468,0.4243406,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;113;-330.5173,-1283.639;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;72;-142.9836,-1157.057;Float;True;Property;_RimLightMask;RimLight Mask;17;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;93;-1083.887,644.8634;Float;False;Property;_DiffuseColor;Diffuse Color;1;0;Create;True;0;0;False;0;1,1,1,1;0.8156863,0.8705882,0.8745098,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldSpaceCameraPos;24;-116.3673,537.1782;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;8;226.4471,603.7924;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ToggleSwitchNode;36;-401.5202,-496.3486;Float;False;Property;_MatCapToggle;MatCap Toggle;5;0;Create;True;0;0;False;0;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;45;-392.2925,-379.1928;Float;False;Property;_MatCapColor;MatCap Color;7;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;78;483.9146,-379.749;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;73;169.025,-1150.684;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-132.956,-1301.986;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;92;-801.7586,551.3162;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalizeNode;7;412.4484,606.7924;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;154;-600.0206,563.8215;Float;False;Diffuse;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;16;370.0883,843.6774;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.BlendOpsNode;44;-114.6535,-498.1403;Float;False;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;70;404.8893,-1293.297;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;170;610.0236,-276.2599;Float;False;154;0;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;4;264.7757,418.3586;Float;False;Constant;_Vector0;Vector 0;1;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ToggleSwitchNode;88;684.5101,-406.5995;Float;False;Property;_MatCapMaskToggle;MatCap Mask Toggle;11;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;189;534.0211,-206.7491;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightAttenuation;15;343.6742,749.024;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;6;579.4486,604.7925;Float;False;float4 val = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, 7)@$float3 reflCol = DecodeHDR(val, unity_SpecCube0_HDR)@$return reflCol * 0.02@;3;False;1;True;reflVect;FLOAT3;0,0,0;In;;Cubemap Reflections;True;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;5;511.2914,443.7103;Float;False;return ShadeSH9(half4(normal, 1.0))@$;3;False;1;True;normal;FLOAT3;0,0,0;In;;Function_ShadeSH9;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;79;820.8731,-272.1853;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;67;951.8707,-470.2652;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;62;691.0909,-1286.749;Float;False;Property;_RimLightToggle;RimLight Toggle;13;0;Create;True;0;0;False;0;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;39;-810.9142,-264.0157;Float;True;Property;_MatCapShadow;MatCap Shadow;9;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;636.4397,768.8351;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;180;1192.382,-346.9188;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;865.7114,585.1025;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;97;996.0849,-1291.919;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,1;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;40;-394.9583,-183.1548;Float;False;Property;_MatCapShadowToggle;MatCap Shadow Toggle;8;0;Create;True;0;0;False;0;1;2;0;COLOR;1,1,1,1;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;166;1723.831,153.7393;Float;False;1314.587;720.0694;;10;153;161;155;156;160;157;163;158;151;179;Outline;0.7793107,0,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;167;2013.052,-476.4133;Float;False;884.1853;492.4454;;10;84;114;41;35;169;175;178;182;185;187;Composite;1,0,0,1;0;0
Node;AmplifyShaderEditor.ColorNode;46;-389.9044,-75.56725;Float;False;Property;_MatCapShadowColor;MatCap Shadow Color;10;0;Create;True;0;0;False;0;0.7843137,0.7843137,0.7843137,0;0.5607843,0.2784311,0.3215683,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;153;1773.831,474.1793;Float;False;Property;_OutlineWidth;Outline Width;20;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;155;2156.599,203.7394;Float;False;154;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;181;1372.79,-343.7188;Float;False;Matcap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;161;2124.927,288.1386;Float;False;Property;_OutlineColor;Outline Color;22;0;Create;True;0;0;False;0;0.2941176,0.2941176,0.2941176,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;169;2063.237,-321.532;Float;False;168;0;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;26;1034.418,587.757;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;182;2063.293,-245.649;Float;False;181;0;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;47;-82.27655,-101.8826;Float;False;LinearDodge;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;168;1215.756,-1265.564;Float;False;RimLight;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;2298.549,-277.9474;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;185;2059.581,-421.692;Float;False;154;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;178;2062.917,-80.3663;Float;False;177;0;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;175;2062.857,-163.813;Float;False;174;0;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;160;2389.321,235.8357;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;157;2005.439,643.809;Float;True;Property;_OutlineMask;Outline Mask;21;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;174;176.4035,-102.4745;Float;False;MatcapShadow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;156;2085.581,470.8656;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.0002;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;165;2277.433,-1083.687;Float;False;609.6152;485.8191;;3;22;95;94;Emission;1,0.3931035,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;177;1245.142,629.6722;Float;False;Lighting;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;179;2383.702,345.0588;Float;False;177;0;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;187;2339.362,-429.8003;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;158;2347.441,547.8094;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;22;2327.433,-1033.687;Float;True;Property;_EmissionMap;Emission;2;0;Create;False;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;2442.296,-207.8543;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;163;2575.342,291.3399;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;95;2322.596,-840.8674;Float;False;Property;_EmissionColor;Emission Color;3;0;Create;True;0;0;False;0;1,1,1,0;0.8392157,0.8392157,0.8392157,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;114;2683.012,-206.3473;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;2718.048,-880.4301;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OutlineNode;151;2788.418,285.4423;Float;False;0;True;None;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;84;2614.553,-384.5427;Float;False;Property;_OpacityCutoutToggle;Opacity Cutout Toggle;18;0;Create;True;0;0;False;0;0;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;65;3198.803,-395.5486;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;ReflexShaders/ReflexShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;True;0.0001;0.2463776,0.3602941,0.3478668,1;VertexOffset;True;False;Cylindrical;False;Relative;0;;23;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;126;0;148;0
WireConnection;126;1;149;0
WireConnection;29;0;27;0
WireConnection;29;1;28;0
WireConnection;127;0;126;0
WireConnection;77;0;74;0
WireConnection;77;1;29;0
WireConnection;128;0;127;0
WireConnection;103;0;128;0
WireConnection;103;1;104;0
WireConnection;30;0;77;0
WireConnection;109;0;103;0
WireConnection;109;1;110;0
WireConnection;32;0;31;0
WireConnection;32;1;30;0
WireConnection;190;0;110;0
WireConnection;112;0;109;0
WireConnection;112;1;111;0
WireConnection;33;0;31;0
WireConnection;33;1;32;0
WireConnection;150;0;69;0
WireConnection;34;1;33;0
WireConnection;113;0;112;0
WireConnection;113;1;190;0
WireConnection;8;0;24;0
WireConnection;8;1;23;0
WireConnection;36;1;34;0
WireConnection;78;0;150;0
WireConnection;73;0;72;0
WireConnection;51;0;113;0
WireConnection;51;1;52;0
WireConnection;92;0;13;0
WireConnection;92;1;93;0
WireConnection;7;0;8;0
WireConnection;154;0;92;0
WireConnection;44;0;36;0
WireConnection;44;1;45;0
WireConnection;70;0;51;0
WireConnection;70;2;73;0
WireConnection;88;1;78;0
WireConnection;189;0;150;0
WireConnection;6;0;7;0
WireConnection;5;0;4;0
WireConnection;79;0;170;0
WireConnection;79;2;189;0
WireConnection;67;0;44;0
WireConnection;67;2;88;0
WireConnection;62;1;70;0
WireConnection;39;1;33;0
WireConnection;17;0;15;0
WireConnection;17;1;16;1
WireConnection;180;0;67;0
WireConnection;180;1;79;0
WireConnection;12;0;5;0
WireConnection;12;1;6;0
WireConnection;12;2;17;0
WireConnection;97;0;62;0
WireConnection;40;1;39;0
WireConnection;181;0;180;0
WireConnection;26;0;12;0
WireConnection;47;0;40;0
WireConnection;47;1;46;0
WireConnection;168;0;97;0
WireConnection;35;0;169;0
WireConnection;35;1;182;0
WireConnection;160;0;155;0
WireConnection;160;1;161;0
WireConnection;174;0;47;0
WireConnection;156;0;153;0
WireConnection;177;0;26;0
WireConnection;187;0;185;0
WireConnection;158;0;156;0
WireConnection;158;1;157;0
WireConnection;41;0;35;0
WireConnection;41;1;175;0
WireConnection;41;2;178;0
WireConnection;163;0;160;0
WireConnection;163;1;179;0
WireConnection;114;0;41;0
WireConnection;94;0;22;0
WireConnection;94;1;95;0
WireConnection;151;0;163;0
WireConnection;151;1;158;0
WireConnection;84;1;187;3
WireConnection;65;2;94;0
WireConnection;65;10;84;0
WireConnection;65;13;114;0
WireConnection;65;11;151;0
ASEEND*/
//CHKSM=5833EB7DE0FD0C54B1093FBEC6E8A6D36E7D43BF