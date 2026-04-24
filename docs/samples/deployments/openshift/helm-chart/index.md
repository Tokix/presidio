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
2. **Update `values.yaml`** with your image registry, namespace, and any custom settings.
3. **Deploy the chart:**
   ```sh
   helm upgrade --install presidio ./helm-chart --namespace presidio
   ```

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
