# Presidio Helm Chart for OpenShift

This Helm chart deploys all core Presidio services (analyzer, anonymizer, image-redactor) and now also includes an `e2e-tests` deployment for automated end-to-end testing of your Presidio deployment.

## Components
- **Analyzer**: Detects PII in text
- **Anonymizer**: Anonymizes detected PII
- **Image Redactor**: Redacts PII in images
- **E2E Tests**: Runs the official Presidio end-to-end test suite as a container

## How to Install

1. **Clone the repository and navigate to the chart directory:**
   ```sh
   git clone https://github.com/microsoft/presidio.git
   cd presidio/docs/samples/deployments/openshift/helm-chart
   ```
2. **Update `values.yaml`** with your infrastructure-specific settings. See below for details on which values to adapt.
3. **Deploy the chart:**
   ```sh
   helm upgrade --install presidio ./helm-chart --namespace presidio
   ```

## Configuring values.yaml

The `values.yaml` file controls how Presidio is deployed. You should review and adapt the following keys to match your infrastructure:

- **imageRegistry**: The OpenShift image registry host where your container images are stored.
- **namespace**: The OpenShift namespace to deploy Presidio into.
- **analyzer.image.name / anonymizer.image.name / imageRedactor.image.name / e2eTests.image.repository**: The image names and repositories for each component. Change if you use custom images or a different registry.
- **analyzer.ollamaHost**: Host and port for the Ollama service used by the analyzer. Change if your Ollama service runs elsewhere.
- **e2eTests.ollamaBaseUrl**: Host and port for the Ollama service used by the e2e tests. Set to the correct service URL for your cluster.
- **e2eTests.endpoints.analyzer / anonymizer / imageRedactor**: Internal service URLs for each Presidio component. Change if you use custom service names or ports.
- **replicaCount**: Number of pods to run for each service (default: 1).
- **resources**: Resource requests/limits for each component. Set according to your cluster's capacity.
- **nodeSelector, tolerations, affinity**: Advanced scheduling options for OpenShift/Kubernetes clusters.

**Example: Setting the Ollama endpoint for e2e tests**

```yaml
e2eTests:
  ollamaBaseUrl: "ollama.flowise.svc.cluster.local:11434"
```

**Tip:** After changing values.yaml, redeploy the chart with the Helm command above.

## Running E2E Tests

The `e2e-tests` deployment will automatically run the Presidio end-to-end test suite against the deployed services. You can check the logs of the test pod to see the results:

```sh
kubectl logs deployment/presidio-e2e-tests -n presidio
```

## Uninstall

To remove everything:
```sh
helm uninstall presidio --namespace presidio
```

## Notes
- Ensure all referenced images are available in your registry and accessible from the cluster.
- The e2e-tests pod will exit after running the tests. You can redeploy it by restarting the deployment if needed.
- This chart is designed for OpenShift but may be adapted for vanilla Kubernetes with minor changes.
