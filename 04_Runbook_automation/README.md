# Runbook automation

## About this use case

Configuration changes during runtime are sometimes necessary to increase flexibility. A prominent example are feature flags that can be toggled also in a production environment. In this tutorial, we will change the promotion rate of a shopping cart service, which means that a defined percentage of interactions with the shopping cart will add promotional items (e.g., small gifts) to the shopping carts of our customers. However, we will experience troubles with this configuration change. Therefore, we will set means in place that are capable of auto-remediating issues at runtime. In fact, we will leverage workflows in ServiceNow.

## Prerequisites

Have completed the usecases.

- ServiceNow instance or [free ServiceNow developer instance](https://developer.servicenow.com/)
  - **Note:** Tutorial tested on [London](https://docs.servicenow.com/category/london) and [Madrid](https://docs.servicenow.com/category/london) releases
- [Setup of Dynatrace](https://keptn.sh/docs/0.5.0/reference/monitoring/dynatrace/) for monitoring is mandatory

## Configure Keptn

In order for Keptn to use both ServiceNow and Dynatrace, the corresponding credentials have to be stored as Kubernetes secrets in the cluster.

### Dynatrace secret

The Dynatrace secret should already have been created while setting up [Dynatrace monitoring](https://keptn.sh/docs/0.5.0/reference/monitoring/dynatrace/). Please verify your Dynatrace secret by executing the following commands:

```bash
kubectl get secret dynatrace -n keptn -o yaml
```

The output should include the `DT_API_TOKEN` and the `DT_TENANT` (both will be shown in base64 encoding):

```yaml
apiVersion: v1
data:
  DT_API_TOKEN: xxxxxx
  DT_TENANT: xxxxxx
kind: Secret
metadata:
  creationTimestamp:
  ...
```

The `DT_API_TOKEN` and the `DT_TENANT` need to be stored in an environment variable. Therefore, copy and paste the following command to make sure that `DT_TENANT` stores a url that follows the pattern `{your-domain}/e/{your-environment-id}` for a managed Dynatrace tenant or `{your-environment-id}.live.dynatrace.com` for a SaaS tenant.

### ServiceNow secret

Create the ServiceNow secret to allow Keptn to create/update incidents in ServiceNow and run workflows. For the command below, use your ServiceNow tenant id (8-digits), your ServiceNow user (e.g., *admin*) as user, and your ServiceNow password as token:

```bash
kubectl -n keptn create secret generic servicenow --from-literal="tenant=xxx" --from-literal="user=xxx" --from-literal="token=xxx"
```

**Note:** If your ServiceNow password has some special characters in it, you need to [escape them](https://kubernetes.io/docs/concepts/configuration/secret/).

## Setup the workflow in ServiceNow

A ServiceNow *Update Set* is provided to run this tutorial. To install the *Update Set* follow these steps:

1. Login to your ServiceNow instance.

2. Look for *update set* in the left search box and navigate to **Update Sets to Commit**

   [![ServiceNow Update Set](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/service-now-update-set-overview.png)](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/service-now-update-set-overview.png)

   ServiceNow Update Set

   

3. Click on **Import Update Set from XML**

4. *[Import](https://raw.githubusercontent.com/keptn-contrib/servicenow-service/release-0.1.4/usecase/keptn_demo_remediation_updateset.xml)* and *Upload* the file from your file system that you find in your `servicenow-service/usecase` folder: `keptn_demo_remediation_updateset.xml`

5. Open the *Update Set*

   [![ServiceNow Update Sets List](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/service-now-update-set-list.png)](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/service-now-update-set-list.png)
   ServiceNow Update Sets List

   

6. In the right upper corner, click on **Preview Update Set** and once previewed, click on **Commit Update Set** to apply it to your instance

   [![ServiceNow Update Set Commit](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/service-now-update-set-commit.png)](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/service-now-update-set-commit.png)
   ServiceNow Update Set Commit

   

7. After importing, enter **keptn** as the search term into the upper left search box.

   [![ServiceNow keptn credentials](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/service-now-keptn-creds.png)](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/service-now-keptn-creds.png)
   ServiceNow keptn credentials
   
8. Click on **New** and enter your Dynatrace API token as well as your Dynatrace tenant.

9. *(optional)* You can also take a look at the predefined workflow that is able to handle Dynatrace problem notifications and remediate issues.

   - Navigate to the workflow editor by typing **Workflow Editor** and clicking on the item **Workflow** > **Workflow Editor**

   - The workflow editor is opened in a new window/tab

   - Look for the workflow keptn_demo_remediation

     (it might as well be on the second or third page)

     [![ServiceNow Keptn workflow](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/service-now-workflow-list.png)](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/service-now-workflow-list.png)

     ServiceNow Keptn workflow

   - Open the workflow by clicking on it. It will look similar to the following image. By clicking on the workflow notes you can further investigate each step of the workflow.

     [![ServiceNow Keptn workflow](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/service-now-keptn-workflow.png)](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/service-now-keptn-workflow.png)

     ServiceNow Keptn workflow



## (optional): Verify Dynatrace problem notification

During the [setup of Dynatrace](https://keptn.sh/docs/0.5.0/reference/monitoring/dynatrace) a problem notification has already been set up for you. You can verify the correct setup by following the instructions:

1. Login to your Dynatrace tenant.

2. Navigate to **Settings** > **Integration** > **Problem notifications**

3. Click on **Set up notifications** and select **Custom integration**

4. Click on **Keptn remediation**

5. The problem notification should look similar to the one in this screen shot:

   [![Dynatrace Problem Notification Integration](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/dynatrace-problem-notification-integration.png)](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/dynatrace-problem-notification-integration.png)

   Dynatrace Problem Notification Integration

## Adjust anomaly detection in Dynatrace

The Dynatrace platform is built on top of AI, which is great for production use cases, but for this demo we have to override some default settings in order for Dynatrace to trigger the problem.

Before you adjust this setting, make sure to have some traffic on the service in order for Dynatrace to detect and list the service. The easiest way to generate traffic is to use the provided file `add-to-carts.sh` in the `./usecase` folder. This script will add items to the shopping cart and can be stopped after a couple of added items by hitting CTRL+C.

1. Navigate to the *servicenow-service/usecase* folder:

   ```bash
   cd ~/servicenow-usecase
   ```

2. Run the script:

   ```bash
   ./add-to-cart.sh "carts.sockshop-production.$(kubectl get cm keptn-domain -n keptn -o=jsonpath='{.data.app_domain}')"
   ```

   

3. Once you generated some load, navigate to **Transaction & services** and find the service **ItemsController** in the *sockshop-production* environment.

4. Open the service and click on the three dots button to **Edit** the service.

   [![Edit Service](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/dynatrace-service-edit.png)](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/dynatrace-service-edit.png)

   Edit Service

   

5. In the section **Anomaly detection** override the global anomaly detection and set the value for the **failure rate** to use **fixed thresholds** and to alert if **10%** custom failure rate are exceeded. Finally, set the **Sensitiviy** to **High**.

   [![Edit Anomaly Detection](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/dynatrace-service-anomaly-detection.png)](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/dynatrace-service-anomaly-detection.png)

   Edit Anomaly Detection

   

## Run the tutorial

Now, all pieces are in place to run the use case of a production incident. Therefore, we will start by generating some load on the *carts* service in our production environment. Afterwards, we will change configuration of this service at runtime. This will cause some troubles in our production environment, Dynatrace will detect the issue, and will create a problem ticket. Due to the problem notification we just set up, Keptn will be informed about the problem and will forward it to the ServiceNow service that in turn creates an incident in ServiceNow. This incident will trigger a workflow that is able to remediate the issue at runtime. Along the remediation, comments, and details on configuration changes are posted to Dynatrace.

### Load generation

1. Run the script:

   ```bash
   ./add-to-cart.sh "carts.sockshop-production.$(kubectl get cm keptn-domain -n keptn -o=jsonpath='{.data.app_domain}')"
   ```

2. You should see some logging output each time an item is added to your shopping cart:

   ```bash
   ...
   Adding item to cart...
   {"id":"3395a43e-2d88-40de-b95f-e00e1502085b","itemId":"03fef6ac-1896-4ce8-bd69-b798f85c6e0b","quantity":73,"unitPrice":0.0}
   Adding item to cart...
   {"id":"3395a43e-2d88-40de-b95f-e00e1502085b","itemId":"03fef6ac-1896-4ce8-bd69-b798f85c6e0b","quantity":74,"unitPrice":0.0}
   Adding item to cart...
   {"id":"3395a43e-2d88-40de-b95f-e00e1502085b","itemId":"03fef6ac-1896-4ce8-bd69-b798f85c6e0b","quantity":75,"unitPrice":0.0}
   ...
   ```

### Configuration change at runtime

1. Open another terminal to make sure the load generation is still running and again, navigate to the *servicenow-service/usecase* folder.

2. *(optional:)* Verify that the environment variables you set earlier are still available:

   ```undefined
   echo $DT_TENANT $DT_API_TOKEN
   ```

   If the environment variables are not set, you can easily set them by [following the instructions on how to extract information from the Dynatrace secret](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/#dynatrace-secret).

3. Run the script:

   ```bash
   ./enable-promotion.sh "carts.sockshop-production.$(kubectl get cm keptn-domain -n keptn -o=jsonpath='{.data.app_domain}')" 30
   ```

   

   **Note:** The parameter `30` at the end, which is the value for the configuration change and can be interpreted as for 30 % of the shopping cart interactions a special item is added to the shopping cart. This value can be set from `0` to `100`. For this use case the value `30` is just fine.

4. You will notice that your load generation script output will include some error messages after applying the script:

   ```bash
   ...
   Adding item to cart...
   {"id":"3395a43e-2d88-40de-b95f-e00e1502085b","itemId":"03fef6ac-1896-4ce8-bd69-b798f85c6e0b","quantity":80,"unitPrice":0.0}
   Adding item to cart...
   {"timestamp":1553686899190,"status":500,"error":"Internal Server Error","exception":"java.lang.Exception","message":"promotion campaign not yet implemented","path":"/carts/1/items"}
   Adding item to cart...
   {"id":"3395a43e-2d88-40de-b95f-e00e1502085b","itemId":"03fef6ac-1896-4ce8-bd69-b798f85c6e0b","quantity":81,"unitPrice":0.0}
   ...
   ```

   

### Problem detection by Dynatrace

Navigate to the ItemsController service by clicking on **Transactions & services** and look for your ItemsController. Since our service is running in three different environment (dev, staging, and production) it is recommended to filter by the `environment:sockshop-production` to make sure to find the correct service.

[![Dynatrace Transactions & Services](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/dynatrace-services.png)](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/dynatrace-services.png)

Dynatrace Transactions & Services



When clicking on the service, in the right bottom corner you can validate in Dynatrace that the configuration change has been applied.

[![Dynatrace Custom Configuration Event](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/dynatrace-config-event.png)](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/dynatrace-config-event.png)

Dynatrace Custom Configuration Event



After a couple of minutes, Dynatrace will open a problem ticket based on the increase of the failure rate.

[![Dynatrace Open Problem](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/dynatrace-problem-open.png)](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/dynatrace-problem-open.png)

Dynatrace Open Problem



### Incident creation & workflow execution by ServiceNow

The Dynatrace problem ticket notification is sent out to Keptn which puts it into the problem channel where the ServiceNow service is subscribed. Thus, the ServiceNow service takes the event and creates a new incident in ServiceNow. In your ServiceNow instance, you can take a look at all incidents by typing in **incidents** in the top-left search box and click on **Service Desk** > **Incidents**. You should be able to see the newly created incident, click on it to view some details.

[![ServiceNow incident](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/service-now-incident.png)](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/service-now-incident.png)

ServiceNow incident



After creation of the incident, a workflow is triggered in ServiceNow that has been setup during the import of the *Update Set* earlier. The workflow takes a look at the incident, resolves the URL that is stored in the *Remediation* tab in the incident detail screen. Along with that, a new custom configuration change is sent to Dynatrace. Besides, the ServiceNow service running in Keptn sends comments to the Dynatrace problem to be able to keep track of executed steps.

You can check both the new *custom configuration change* on the service overview page in Dynatrace as well as the added comment on the problem ticket in Dynatrace.

Once the problem is resolved, Dynatrace sends out another notification which again is handled by the ServiceNow service. Now the incidents gets resolved and another comment is sent to Dynatrace. The image shows the updated incident in ServiceNow. The comment can be found if you navigate to the closed problem ticket in Dynatrace.

[![Resolved ServiceNow incident](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/service-now-incident-resolved.png)](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/service-now-incident-resolved.png)

Resolved ServiceNow incident



## Troubleshooting

- Please note that Dynatrace has its feature called **Frequent Issue Detection** enabled by default. This means, that if Dynatrace detects the same problem multiple times, it will be classified as a frequent issue and problem notifications won’t be sent out to third party tools. Therefore, the tutorial might not be able to be run a couple of times in a row. To disable this feature:

  1. Login to your Dynatrace tenant.
  2. Navigate to **Settings** > **Anomaly detection** > **Frequent issue detection**
  3. Toggle the switch at **Detect frequent issues within transaction and services**

- In ServiceNow you can take a look at the **System Log** > **All** to verify which actions have been executed. You should be able to see some logs on the execution of the Keptn demo workflow as shown in the screenshot:

  [![ServiceNow System Log](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/service-now-systemlog.png)](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/assets/service-now-systemlog.png)

  ServiceNow System Log

  

- In case Dynatrace detected a problem before the [ServiceNow secret was created](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/#servicenow-secret) in your Kubernetes cluster, the remediation will not work. Resolution:

  1. [Create the secret](https://keptn.sh/docs/0.5.0/usecases/runbook-automation-and-self-healing/#servicenow-secret).
  2. Restart the pod.

  ```bash
  kubectl delete pod servicenow-service-XXXXX -n keptn
  ```

---

[Previous Step: Introducing quality gates](../03_Introducing_quality_gates) :arrow_backward: :arrow_forward:

