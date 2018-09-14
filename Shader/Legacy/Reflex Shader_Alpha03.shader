// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:True,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:35292,y:31942,varname:node_3138,prsc:2|normal-6566-RGB,emission-3584-OUT,custl-5717-OUT,olwid-3861-OUT,olcol-289-OUT;n:type:ShaderForge.SFN_Tex2d,id:490,x:34290,y:32133,ptovrint:False,ptlb:Diffuse,ptin:_Diffuse,varname:node_490,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:55bdab7268f04f744b223f6411b3ff7c,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:4629,x:33649,y:31868,ptovrint:False,ptlb:Emission,ptin:_Emission,varname:node_4629,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:2,isnm:False;n:type:ShaderForge.SFN_Multiply,id:5717,x:34826,y:32374,varname:node_5717,prsc:2|A-3178-OUT,B-7480-OUT;n:type:ShaderForge.SFN_ToggleProperty,id:6062,x:33948,y:32012,ptovrint:False,ptlb:Emission Toggle,ptin:_EmissionToggle,varname:node_6062,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False;n:type:ShaderForge.SFN_Clamp01,id:3930,x:34218,y:32993,varname:node_3930,prsc:2|IN-7826-OUT;n:type:ShaderForge.SFN_ComponentMask,id:1541,x:34401,y:32993,varname:node_1541,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-3930-OUT;n:type:ShaderForge.SFN_Add,id:9804,x:34581,y:32993,varname:node_9804,prsc:2|A-1541-R,B-1541-G,C-1541-B;n:type:ShaderForge.SFN_Divide,id:2348,x:34766,y:32993,varname:node_2348,prsc:2|A-9804-OUT,B-3404-OUT;n:type:ShaderForge.SFN_Vector1,id:3404,x:34581,y:33124,varname:node_3404,prsc:2,v1:3;n:type:ShaderForge.SFN_If,id:7480,x:34535,y:32838,varname:node_7480,prsc:2|A-2633-OUT,B-8041-OUT,GT-3930-OUT,EQ-3930-OUT,LT-2348-OUT;n:type:ShaderForge.SFN_ToggleProperty,id:8041,x:34278,y:32906,ptovrint:False,ptlb:Light Limiter,ptin:_LightLimiter,varname:node_8041,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False;n:type:ShaderForge.SFN_Vector1,id:2633,x:34278,y:32830,varname:node_2633,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Lerp,id:8840,x:34346,y:31860,varname:node_8840,prsc:2|A-3023-OUT,B-7427-OUT,T-594-OUT;n:type:ShaderForge.SFN_Vector1,id:7427,x:34114,y:31915,varname:node_7427,prsc:2,v1:0;n:type:ShaderForge.SFN_OneMinus,id:594,x:34114,y:31968,varname:node_594,prsc:2|IN-6062-OUT;n:type:ShaderForge.SFN_Fresnel,id:1672,x:33218,y:31562,varname:node_1672,prsc:2|EXP-2730-OUT;n:type:ShaderForge.SFN_Posterize,id:9648,x:33628,y:31561,varname:node_9648,prsc:2|IN-5282-OUT,STPS-7206-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7206,x:33440,y:31764,ptovrint:False,ptlb:RimLight Steps,ptin:_RimLightSteps,varname:node_7206,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:2;n:type:ShaderForge.SFN_Slider,id:1749,x:32696,y:31585,ptovrint:False,ptlb:RimLight Stength,ptin:_RimLightStength,varname:node_1749,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_RemapRange,id:2730,x:33046,y:31562,varname:node_2730,prsc:2,frmn:0,frmx:1,tomn:4,tomx:1|IN-1749-OUT;n:type:ShaderForge.SFN_Blend,id:3584,x:34557,y:31635,varname:node_3584,prsc:2,blmd:6,clmp:True|SRC-4688-OUT,DST-8840-OUT;n:type:ShaderForge.SFN_Lerp,id:4688,x:34284,y:31561,varname:node_4688,prsc:2|A-664-OUT,B-7427-OUT,T-7916-OUT;n:type:ShaderForge.SFN_ToggleProperty,id:5105,x:34063,y:31707,ptovrint:False,ptlb:RimLight Toggle,ptin:_RimLightToggle,varname:node_5105,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False;n:type:ShaderForge.SFN_OneMinus,id:7916,x:34259,y:31707,varname:node_7916,prsc:2|IN-5105-OUT;n:type:ShaderForge.SFN_Slider,id:2458,x:34669,y:32292,ptovrint:False,ptlb:Outline Width,ptin:_OutlineWidth,varname:node_2458,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Color,id:8415,x:34517,y:32193,ptovrint:False,ptlb:Outline Tint,ptin:_OutlineTint,varname:node_8415,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_RemapRange,id:3861,x:35003,y:32292,varname:node_3861,prsc:2,frmn:0,frmx:1,tomn:0,tomx:0.01|IN-2458-OUT;n:type:ShaderForge.SFN_Multiply,id:289,x:34732,y:32137,varname:node_289,prsc:2|A-490-RGB,B-8415-RGB;n:type:ShaderForge.SFN_NormalVector,id:4921,x:31848,y:32114,prsc:2,pt:False;n:type:ShaderForge.SFN_Transform,id:5219,x:32013,y:32114,varname:node_5219,prsc:2,tffrom:0,tfto:3|IN-4921-OUT;n:type:ShaderForge.SFN_ComponentMask,id:1545,x:32187,y:32114,varname:node_1545,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-5219-XYZ;n:type:ShaderForge.SFN_RemapRange,id:2923,x:32354,y:32114,varname:node_2923,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-1545-OUT;n:type:ShaderForge.SFN_Tex2d,id:6215,x:32568,y:32114,ptovrint:False,ptlb:MatCap,ptin:_MatCap,varname:node_1382,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:2,isnm:False|UVIN-2923-OUT;n:type:ShaderForge.SFN_Add,id:4701,x:34290,y:32357,varname:node_4701,prsc:2|A-490-RGB,B-2504-OUT;n:type:ShaderForge.SFN_Lerp,id:2504,x:33597,y:32113,varname:node_2504,prsc:2|A-8760-OUT,B-1243-OUT,T-3219-OUT;n:type:ShaderForge.SFN_Tex2d,id:9573,x:33203,y:32523,ptovrint:False,ptlb:MatCap Mask,ptin:_MatCapMask,varname:node_9573,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:2,isnm:False;n:type:ShaderForge.SFN_Vector1,id:1243,x:33411,y:32147,varname:node_1243,prsc:2,v1:0;n:type:ShaderForge.SFN_Code,id:5315,x:33341,y:33144,varname:node_5315,prsc:2,code:ZgBsAG8AYQB0ADQAIAB2AGEAbAAgAD0AIABVAE4ASQBUAFkAXwBTAEEATQBQAEwARQBfAFQARQBYAEMAVQBCAEUAXwBMAE8ARAAoAHUAbgBpAHQAeQBfAFMAcABlAGMAQwB1AGIAZQAwACwAIAByAGUAZgBsAFYAZQBjAHQALAAgADcAKQA7AAoAZgBsAG8AYQB0ADMAIAByAGUAZgBsAEMAbwBsACAAPQAgAEQAZQBjAG8AZABlAEgARABSACgAdgBhAGwALAAgAHUAbgBpAHQAeQBfAFMAcABlAGMAQwB1AGIAZQAwAF8ASABEAFIAKQA7AAoAcgBlAHQAdQByAG4AIAByAGUAZgBsAEMAbwBsACAAKgAgADAALgAwADIAOwA=,output:2,fname:CubemapReflections,width:515,height:130,input:2,input_1_label:reflVect|A-4739-OUT;n:type:ShaderForge.SFN_Code,id:8053,x:33564,y:32996,varname:node_8053,prsc:2,code:cgBlAHQAdQByAG4AIABTAGgAYQBkAGUAUwBIADkAKABoAGEAbABmADQAKABuAG8AcgBtAGEAbAAsACAAMQAuADAAKQApADsACgA=,output:2,fname:Function_ShadeSH9,width:292,height:112,input:2,input_1_label:normal|A-8567-OUT;n:type:ShaderForge.SFN_ViewPosition,id:3425,x:32768,y:33063,varname:node_3425,prsc:2;n:type:ShaderForge.SFN_Subtract,id:6801,x:32969,y:33144,varname:node_6801,prsc:2|A-3425-XYZ,B-3449-XYZ;n:type:ShaderForge.SFN_ObjectPosition,id:3449,x:32768,y:33206,varname:node_3449,prsc:2;n:type:ShaderForge.SFN_Add,id:7826,x:33979,y:32993,varname:node_7826,prsc:2|A-8053-OUT,B-5315-OUT,C-1751-OUT;n:type:ShaderForge.SFN_Normalize,id:4739,x:33140,y:33144,varname:node_4739,prsc:2|IN-6801-OUT;n:type:ShaderForge.SFN_Vector3,id:8567,x:33352,y:32995,varname:node_8567,prsc:2,v1:0,v2:1,v3:0;n:type:ShaderForge.SFN_LightColor,id:2779,x:33336,y:33519,varname:node_2779,prsc:2;n:type:ShaderForge.SFN_LightAttenuation,id:9483,x:33336,y:33376,varname:node_9483,prsc:2;n:type:ShaderForge.SFN_ToggleProperty,id:7716,x:33549,y:33321,ptovrint:False,ptlb:Shading Support,ptin:_ShadingSupport,varname:node_1186,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True;n:type:ShaderForge.SFN_If,id:1751,x:33748,y:33418,varname:node_1751,prsc:2|A-7716-OUT,B-1112-OUT,GT-4884-OUT,EQ-2779-RGB,LT-2779-RGB;n:type:ShaderForge.SFN_Multiply,id:4884,x:33549,y:33435,varname:node_4884,prsc:2|A-9483-OUT,B-2779-RGB;n:type:ShaderForge.SFN_Vector1,id:1112,x:33549,y:33376,varname:node_1112,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Multiply,id:5282,x:33421,y:31561,varname:node_5282,prsc:2|A-1672-OUT,B-8190-RGB;n:type:ShaderForge.SFN_Color,id:8190,x:33218,y:31740,ptovrint:False,ptlb:Rim Light Color,ptin:_RimLightColor,varname:node_8190,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0.4206896,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:4939,x:32795,y:32114,varname:node_4939,prsc:2|A-6215-RGB,B-2218-OUT;n:type:ShaderForge.SFN_Color,id:2998,x:32958,y:32230,ptovrint:False,ptlb:MatCap Color,ptin:_MatCapColor,varname:node_2998,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_If,id:3219,x:33597,y:32355,varname:node_3219,prsc:2|A-9132-OUT,B-4411-OUT,GT-9522-OUT,EQ-9522-OUT,LT-9573-RGB;n:type:ShaderForge.SFN_ToggleProperty,id:4411,x:33203,y:32386,ptovrint:False,ptlb:MatCap Mask Toggle,ptin:_MatCapMaskToggle,varname:_LightLimiter_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False;n:type:ShaderForge.SFN_Vector1,id:9132,x:33203,y:32310,varname:node_9132,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Vector1,id:9522,x:33203,y:32445,varname:node_9522,prsc:2,v1:0;n:type:ShaderForge.SFN_ToggleProperty,id:2218,x:32568,y:32322,ptovrint:False,ptlb:MatCap Toggle,ptin:_MatCapToggle,varname:_MatCapMaskToggle_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False;n:type:ShaderForge.SFN_If,id:664,x:34063,y:31561,varname:node_664,prsc:2|A-4984-OUT,B-915-OUT,GT-9648-OUT,EQ-5282-OUT,LT-5282-OUT;n:type:ShaderForge.SFN_Vector1,id:915,x:33839,y:31625,varname:node_915,prsc:2,v1:0.5;n:type:ShaderForge.SFN_ToggleProperty,id:4984,x:33839,y:31561,ptovrint:False,ptlb:Rim Light Posterize Toggle,ptin:_RimLightPosterizeToggle,varname:node_4984,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False;n:type:ShaderForge.SFN_Multiply,id:3023,x:33948,y:31867,varname:node_3023,prsc:2|A-4629-RGB,B-6258-RGB;n:type:ShaderForge.SFN_Color,id:6258,x:33788,y:31936,ptovrint:False,ptlb:Emission Color,ptin:_EmissionColor,varname:node_6258,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Tex2d,id:6566,x:34961,y:32011,ptovrint:False,ptlb:Normal,ptin:_Normal,varname:node_6566,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2d,id:866,x:33701,y:32529,ptovrint:False,ptlb:MatCap Shadow,ptin:_MatCapShadow,varname:_MatCap_Shadow_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-2923-OUT;n:type:ShaderForge.SFN_If,id:6221,x:34067,y:32529,varname:node_6221,prsc:2|A-1330-OUT,B-5779-OUT,GT-866-RGB,EQ-18-OUT,LT-18-OUT;n:type:ShaderForge.SFN_ToggleProperty,id:1330,x:33869,y:32529,ptovrint:False,ptlb:MatCap Shadow Toggle,ptin:_MatCapShadowToggle,varname:_MatCapToggle_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False;n:type:ShaderForge.SFN_Vector1,id:5779,x:33869,y:32590,varname:node_5779,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Multiply,id:3178,x:34527,y:32450,varname:node_3178,prsc:2|A-4701-OUT,B-4928-OUT;n:type:ShaderForge.SFN_Blend,id:8760,x:33196,y:32095,varname:node_8760,prsc:2,blmd:1,clmp:True|SRC-4939-OUT,DST-2998-RGB;n:type:ShaderForge.SFN_Vector1,id:18,x:33869,y:32650,varname:node_18,prsc:2,v1:1;n:type:ShaderForge.SFN_Blend,id:4928,x:34290,y:32529,varname:node_4928,prsc:2,blmd:8,clmp:True|SRC-6221-OUT,DST-2327-RGB;n:type:ShaderForge.SFN_Color,id:2327,x:34067,y:32682,ptovrint:False,ptlb:MatCap Shadow Color,ptin:_MatCapShadowColor,varname:node_2327,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5019608,c2:0.5019608,c3:0.5019608,c4:1;proporder:490-6062-4629-6258-6566-5105-8190-4984-7206-1749-2458-8415-2218-6215-2998-4411-9573-1330-866-2327-8041-7716;pass:END;sub:END;*/

Shader "Reflex Shader/ReflexShader_Alpha 03" {
    Properties {
        _Diffuse ("Diffuse", 2D) = "white" {}
        [MaterialToggle] _EmissionToggle ("Emission Toggle", Float ) = 0
        _Emission ("Emission", 2D) = "black" {}
        _EmissionColor ("Emission Color", Color) = (1,1,1,1)
        _Normal ("Normal", 2D) = "bump" {}
        [MaterialToggle] _RimLightToggle ("RimLight Toggle", Float ) = 0
        _RimLightColor ("Rim Light Color", Color) = (0,0.4206896,1,1)
        [MaterialToggle] _RimLightPosterizeToggle ("Rim Light Posterize Toggle", Float ) = 0
        _RimLightSteps ("RimLight Steps", Float ) = 2
        _RimLightStength ("RimLight Stength", Range(0, 1)) = 0
        _OutlineWidth ("Outline Width", Range(0, 1)) = 0
        _OutlineTint ("Outline Tint", Color) = (0.5,0.5,0.5,1)
        [MaterialToggle] _MatCapToggle ("MatCap Toggle", Float ) = 0
        _MatCap ("MatCap", 2D) = "black" {}
        _MatCapColor ("MatCap Color", Color) = (1,1,1,1)
        [MaterialToggle] _MatCapMaskToggle ("MatCap Mask Toggle", Float ) = 0
        _MatCapMask ("MatCap Mask", 2D) = "black" {}
        [MaterialToggle] _MatCapShadowToggle ("MatCap Shadow Toggle", Float ) = 0
        _MatCapShadow ("MatCap Shadow", 2D) = "white" {}
        _MatCapShadowColor ("MatCap Shadow Color", Color) = (0.5019608,0.5019608,0.5019608,1)
        [MaterialToggle] _LightLimiter ("Light Limiter", Float ) = 0
        [MaterialToggle] _ShadingSupport ("Shading Support", Float ) = 1
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "RenderType"="Opaque"
        }
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform float _OutlineWidth;
            uniform float4 _OutlineTint;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*(_OutlineWidth*0.01+0.0),1) );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                return fixed4((_Diffuse_var.rgb*_OutlineTint.rgb),0);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform sampler2D _Emission; uniform float4 _Emission_ST;
            uniform fixed _EmissionToggle;
            uniform fixed _LightLimiter;
            uniform float _RimLightSteps;
            uniform float _RimLightStength;
            uniform fixed _RimLightToggle;
            uniform sampler2D _MatCap; uniform float4 _MatCap_ST;
            uniform sampler2D _MatCapMask; uniform float4 _MatCapMask_ST;
            float3 CubemapReflections( float3 reflVect ){
            float4 val = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, 7);
            float3 reflCol = DecodeHDR(val, unity_SpecCube0_HDR);
            return reflCol * 0.02;
            }
            
            float3 Function_ShadeSH9( float3 normal ){
            return ShadeSH9(half4(normal, 1.0));
            
            }
            
            uniform fixed _ShadingSupport;
            uniform float4 _RimLightColor;
            uniform float4 _MatCapColor;
            uniform fixed _MatCapMaskToggle;
            uniform fixed _MatCapToggle;
            uniform fixed _RimLightPosterizeToggle;
            uniform float4 _EmissionColor;
            uniform sampler2D _Normal; uniform float4 _Normal_ST;
            uniform sampler2D _MatCapShadow; uniform float4 _MatCapShadow_ST;
            uniform fixed _MatCapShadowToggle;
            uniform float4 _MatCapShadowColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _Normal_var = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(i.uv0, _Normal)));
                float3 normalLocal = _Normal_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = 1;
////// Emissive:
                float node_664_if_leA = step(_RimLightPosterizeToggle,0.5);
                float node_664_if_leB = step(0.5,_RimLightPosterizeToggle);
                float3 node_5282 = (pow(1.0-max(0,dot(normalDirection, viewDirection)),(_RimLightStength*-3.0+4.0))*_RimLightColor.rgb);
                float node_7427 = 0.0;
                float4 _Emission_var = tex2D(_Emission,TRANSFORM_TEX(i.uv0, _Emission));
                float3 emissive = saturate((1.0-(1.0-lerp(lerp((node_664_if_leA*node_5282)+(node_664_if_leB*floor(node_5282 * _RimLightSteps) / (_RimLightSteps - 1)),node_5282,node_664_if_leA*node_664_if_leB),float3(node_7427,node_7427,node_7427),(1.0 - _RimLightToggle)))*(1.0-lerp((_Emission_var.rgb*_EmissionColor.rgb),float3(node_7427,node_7427,node_7427),(1.0 - _EmissionToggle)))));
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float2 node_2923 = (mul( UNITY_MATRIX_V, float4(i.normalDir,0) ).xyz.rgb.rg*0.5+0.5);
                float4 _MatCap_var = tex2D(_MatCap,TRANSFORM_TEX(node_2923, _MatCap));
                float node_1243 = 0.0;
                float node_3219_if_leA = step(0.5,_MatCapMaskToggle);
                float node_3219_if_leB = step(_MatCapMaskToggle,0.5);
                float4 _MatCapMask_var = tex2D(_MatCapMask,TRANSFORM_TEX(i.uv0, _MatCapMask));
                float node_9522 = 0.0;
                float node_6221_if_leA = step(_MatCapShadowToggle,0.5);
                float node_6221_if_leB = step(0.5,_MatCapShadowToggle);
                float node_18 = 1.0;
                float4 _MatCapShadow_var = tex2D(_MatCapShadow,TRANSFORM_TEX(node_2923, _MatCapShadow));
                float node_7480_if_leA = step(0.5,_LightLimiter);
                float node_7480_if_leB = step(_LightLimiter,0.5);
                float node_1751_if_leA = step(_ShadingSupport,0.5);
                float node_1751_if_leB = step(0.5,_ShadingSupport);
                float3 node_3930 = saturate((Function_ShadeSH9( float3(0,1,0) )+CubemapReflections( normalize((_WorldSpaceCameraPos-objPos.rgb)) )+lerp((node_1751_if_leA*_LightColor0.rgb)+(node_1751_if_leB*(attenuation*_LightColor0.rgb)),_LightColor0.rgb,node_1751_if_leA*node_1751_if_leB)));
                float3 node_1541 = node_3930.rgb;
                float3 finalColor = emissive + (((_Diffuse_var.rgb+lerp(saturate(((_MatCap_var.rgb*_MatCapToggle)*_MatCapColor.rgb)),float3(node_1243,node_1243,node_1243),lerp((node_3219_if_leA*_MatCapMask_var.rgb)+(node_3219_if_leB*node_9522),node_9522,node_3219_if_leA*node_3219_if_leB)))*saturate((lerp((node_6221_if_leA*node_18)+(node_6221_if_leB*_MatCapShadow_var.rgb),node_18,node_6221_if_leA*node_6221_if_leB)+_MatCapShadowColor.rgb)))*lerp((node_7480_if_leA*((node_1541.r+node_1541.g+node_1541.b)/3.0))+(node_7480_if_leB*node_3930),node_3930,node_7480_if_leA*node_7480_if_leB));
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdadd
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform sampler2D _Emission; uniform float4 _Emission_ST;
            uniform fixed _EmissionToggle;
            uniform fixed _LightLimiter;
            uniform float _RimLightSteps;
            uniform float _RimLightStength;
            uniform fixed _RimLightToggle;
            uniform sampler2D _MatCap; uniform float4 _MatCap_ST;
            uniform sampler2D _MatCapMask; uniform float4 _MatCapMask_ST;
            float3 CubemapReflections( float3 reflVect ){
            float4 val = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, 7);
            float3 reflCol = DecodeHDR(val, unity_SpecCube0_HDR);
            return reflCol * 0.02;
            }
            
            float3 Function_ShadeSH9( float3 normal ){
            return ShadeSH9(half4(normal, 1.0));
            
            }
            
            uniform fixed _ShadingSupport;
            uniform float4 _RimLightColor;
            uniform float4 _MatCapColor;
            uniform fixed _MatCapMaskToggle;
            uniform fixed _MatCapToggle;
            uniform fixed _RimLightPosterizeToggle;
            uniform float4 _EmissionColor;
            uniform sampler2D _Normal; uniform float4 _Normal_ST;
            uniform sampler2D _MatCapShadow; uniform float4 _MatCapShadow_ST;
            uniform fixed _MatCapShadowToggle;
            uniform float4 _MatCapShadowColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _Normal_var = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(i.uv0, _Normal)));
                float3 normalLocal = _Normal_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float2 node_2923 = (mul( UNITY_MATRIX_V, float4(i.normalDir,0) ).xyz.rgb.rg*0.5+0.5);
                float4 _MatCap_var = tex2D(_MatCap,TRANSFORM_TEX(node_2923, _MatCap));
                float node_1243 = 0.0;
                float node_3219_if_leA = step(0.5,_MatCapMaskToggle);
                float node_3219_if_leB = step(_MatCapMaskToggle,0.5);
                float4 _MatCapMask_var = tex2D(_MatCapMask,TRANSFORM_TEX(i.uv0, _MatCapMask));
                float node_9522 = 0.0;
                float node_6221_if_leA = step(_MatCapShadowToggle,0.5);
                float node_6221_if_leB = step(0.5,_MatCapShadowToggle);
                float node_18 = 1.0;
                float4 _MatCapShadow_var = tex2D(_MatCapShadow,TRANSFORM_TEX(node_2923, _MatCapShadow));
                float node_7480_if_leA = step(0.5,_LightLimiter);
                float node_7480_if_leB = step(_LightLimiter,0.5);
                float node_1751_if_leA = step(_ShadingSupport,0.5);
                float node_1751_if_leB = step(0.5,_ShadingSupport);
                float3 node_3930 = saturate((Function_ShadeSH9( float3(0,1,0) )+CubemapReflections( normalize((_WorldSpaceCameraPos-objPos.rgb)) )+lerp((node_1751_if_leA*_LightColor0.rgb)+(node_1751_if_leB*(attenuation*_LightColor0.rgb)),_LightColor0.rgb,node_1751_if_leA*node_1751_if_leB)));
                float3 node_1541 = node_3930.rgb;
                float3 finalColor = (((_Diffuse_var.rgb+lerp(saturate(((_MatCap_var.rgb*_MatCapToggle)*_MatCapColor.rgb)),float3(node_1243,node_1243,node_1243),lerp((node_3219_if_leA*_MatCapMask_var.rgb)+(node_3219_if_leB*node_9522),node_9522,node_3219_if_leA*node_3219_if_leB)))*saturate((lerp((node_6221_if_leA*node_18)+(node_6221_if_leB*_MatCapShadow_var.rgb),node_18,node_6221_if_leA*node_6221_if_leB)+_MatCapShadowColor.rgb)))*lerp((node_7480_if_leA*((node_1541.r+node_1541.g+node_1541.b)/3.0))+(node_7480_if_leB*node_3930),node_3930,node_7480_if_leA*node_7480_if_leB));
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
