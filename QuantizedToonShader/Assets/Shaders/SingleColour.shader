Shader "ShaderProjects/SingleColour"
{
    SubShader
    {
        Pass
        {
            HLSLPROGRAM

            #pragma vertex vertColour
            #pragma fragment fragColour

            #include "UnityCG.cginc"

            void vertColour(float4 positionOS:POSITION, float3 normalOS:NORMAL, out float4 c:COLOR0, out float4 sv:SV_POSITION)
            {
                float4 positionWS = mul(unity_ObjectToWorld, float4(positionOS.xyz, 1.0));
                
                sv = mul(unity_MatrixVP, positionWS);

                c = float4((normalOS.xyz + 1) / 2, 1);
            }

            float4 fragColour(float4 c:COLOR0) : COLOR 
            {
                return c;
            }

            ENDHLSL
        }
    }
}
