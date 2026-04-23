# Presidio Helm Chart

This chart deploys the Presidio services (analyzer, anonymizer, image-redactor) on OpenShift 4.21.

## Prerequisites
- OpenShift 4.21+ cluster
- Helm 3.x
- Access to an image registry (e.g., OpenShift internal registry)

## Installation

1. Clone the Presidio repository and navigate to the helm chart directory:
   ```sh
   git clone https://github.com/microsoft/presidio.git
   cd presidio/docs/samples/deployments/openshift/helm-chart
   ```
2. Update `values.yaml` with your image registry, namespace, and any custom settings.
3. Deploy the chart:
   ```sh
   helm upgrade --install presidio ./helm-chart --namespace presidio
   ```

## Configuration

- `values.yaml` contains all configurable parameters, including image registry, namespace, and service settings.
- The `ollamaHost` parameter configures the external Ollama service used by the analyzer.

## Uninstallation

To remove the deployment:
```sh
helm uninstall presidio --namespace presidio
```

## Notes
- Make sure all referenced images are available in your registry and accessible from the cluster.
- The chart is designed for OpenShift but may be adapted for vanilla Kubernetes with minor changes.
