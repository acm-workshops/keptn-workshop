## **Welcome to the Autonomous Cloud  Workshop**

Let's release better software faster and put our IT on autopilot. Let's build a Pipeline from scratch with Keptn and Kubernetes.

#### Login to the Dynatrace Tenant

https://xxxxx.dynatrace-managed.com/
User: acmguru[1-8]
Password: secret

##### Sample to copy for your Notepad (Sergio)

```
Tenant: xxxxxx.dynatrace-managed.com/e/tenant-id
API-Token: YYYYYYY
PaaS-Token: XXXXXXXX
```



##### **Login to the Bastion Host:** 

User: acmguru[1-8]
Password: secret
Native shell: ssh  acmguru[n]@bastion.ip
Webshell: https://bastion.ip/shell/



More Info about Keptn: https://keptn.sh/

##### Cool News about Keptn:

https://www.forbes.com/sites/adrianbridgwater/2019/12/11/dynatrace-gets-hands-on-with-hands-off-noops-autonomous-cloud/#71f2f2d64a4d
https://www.information-age.com/autonomous-cloud-dynatrace-keptn-123486469/

**Another Keptn Workshop delivered on SpringOne**
https://github.com/keptn-workshops/workshop-instructions

**Steps**
1.- Login to your Dynatrace Tenant
2.- Get and API Token and a PaaS Token 

3. - SSH to bastion host 
    **Bash Commands**

    ```
    cd ~/scripts/dynatrace-service/deploy/scripts
    ./defineDynatraceCredentials.sh
    ./deployDynatraceOnGKE.sh
    ```

    

----
*What happened?*
We deployed the oneagent operator
https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/installation-and-operation/full-stack/deploy-oneagent-on-kubernetes/

We also created the following integrations/resources

- Automated Tagging in Dynatrace

- Set Problem notification in Dynatrace

- Create Dynatrace Secret for Keptn Services

- Deploy Dynatrace service for Keptn

- Import a custom Dashboard in Dynatrace

- Create Request Attributes in Dynatrace

- Expose Keptn Bridge via an Istio Virtual Service

  ***More info on LoadTest Integration***
  https://www.dynatrace.com/support/help/setup-and-configuration/integrations/third-party-integrations/test-automation-frameworks/dynatrace-and-load-testing-tools-integration/

  

  Now we generate a bit of traffic just to expose the cart services in all stages and see the importance on FeedBack achieved via RequestAttributes

  **Generate Traffic** 

  ```
  cd ~/load-generation
  ./generate_traffic.sh > /dev/null 2>&1 &
  ```



**Deployment of the Carts**

```
cd ~/keptn-onboarding
```

```
1_create-project.sh
2_onboarding-carts.sh
3_add_tests_to_cart.sh
4_onboard_database.sh
5_deploy_carts_database.sh
6_deploy_carts_service.sh
```



**Show Pipeline Overview**

```
7_quality_gates_addSLIandSLO.sh
```

**Deploy Slow Service**

```
8_deploy_carts_v2_slow.sh
```

```
9_deploy_carts_v3_ok.sh
```



**Davis Interactions**
https://assistant.dynatrace.com/

**Keptn Integrations (Services)**

https://github.com/keptn-contrib/neoload-service
https://github.com/keptn-contrib/ufo-service