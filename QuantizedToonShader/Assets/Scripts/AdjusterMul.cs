using UnityEngine;
using UnityEngine.UI;

public class AdjusterMul : MonoBehaviour
{
    [SerializeField] private Slider sliderBox, sliderCircle, sliderTriangle;

    private MeshRenderer meshRenderer;

    private Material matCircle, matBox, matTriangle;

    private void Start()
    {
        meshRenderer = GetComponent<MeshRenderer>();

        matBox = meshRenderer.materials[0];
        matCircle = meshRenderer.materials[1];
        matTriangle = meshRenderer.materials[2];
    }

    private void Update()
    {
        matBox.SetFloat("_BaseVal", sliderBox.value);
        matCircle.SetFloat("_BaseVal", sliderCircle.value);
        matTriangle.SetFloat("_BaseVal", sliderTriangle.value);
    }
}
