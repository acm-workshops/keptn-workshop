## Welcome to the Autonomous Cloud Workshop (Cheatsheet 😎)

Let's release better software faster and put our IT on autopilot. Let's build a Pipeline from scratch with Keptn and Kubernetes.
This sheet is a copy of the Notepad shared during the session during the hands-on.


The scripts used during the workshop can be found under the resources folder. With a git clone you can get a copy of those files.  
```bash
git clone --single-branch --branch 0.5.2 https://github.com/acm-workshops/keptn-workshop 
```
The home directory (~) from the shell commands equals the ``keptn-workshop/resources`` directory.

----

#### Login to the Dynatrace Tenant

```bash
https://xxxxx.dynatrace-managed.com/
User: acmguru[1-8]
Password: secret
```



##### Sample to copy for your Notepad

```bash
Tenant: xxxxxx.dynatrace-managed.com/e/tenant-id
API-Token: YYYYYYY
PaaS-Token: XXXXXXXX
```

##### **Login to the Bastion Host:** 
> User: acmguru[1-8]
> Password: secret
> Native shell: ssh  acmguru[n]@bastion.ip
> Webshell: https://bastion.ip/shell/

More Info about Keptn: https://keptn.sh/

##### 📰 News about Keptn:

[Dynatrace gets Hands on with NoOps Autonomous Cloud [Forbes]](https://www.forbes.com/sites/adrianbridgwater/2019/12/11/dynatrace-gets-hands-on-with-hands-off-noops-autonomous-cloud/#71f2f2d64a4d) 

[Autonomous Cloud with Dynatrace and Keptn [Information Age]](https://www.information-age.com/autonomous-cloud-dynatrace-keptn-123486469/)

**Steps**
1.- Login to your Dynatrace Tenant
2.- Get and API Token and a PaaS Token 

1. - SSH to bastion host 
    **Bash Commands**

    ```bash
    cd ~/scripts/dynatrace-service/deploy/scripts
    ./defineDynatraceCredentials.sh
    ./deployDynatraceOnGKE.sh
    ```

----
*What happened?*
We deployed the OneAgent [via OneAgent Operator](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/installation-and-operation/full-stack/deploy-oneagent-on-kubernetes/)

We also created the following integrations/resources with the shell script:
- Automated Tagging in Dynatrace
- Set Problem notification in Dynatrace
- Create Dynatrace Secret for Keptn Services
- Deploy Dynatrace service for Keptn
- Import a custom Dashboard in Dynatrace
- Create Request Attributes in Dynatrace
- Expose Keptn Bridge via an Istio Virtual Service

[***More info on LoadTest Integration***](https://www.dynatrace.com/support/help/setup-and-configuration/integrations/third-party-integrations/test-automation-frameworks/dynatrace-and-load-testing-tools-integration/)


Now we generate a bit of traffic just to expose the cart services in all stages and see the importance on FeedBack achieved via RequestAttributes
**Generate Traffic** 

```bash
cd ~/load-generation
./generate_traffic.sh > /dev/null 2>&1 &
```
> The following steps are done interactively where each one is explained graphically with a presentation on parallel.


**Deployment of the Carts**
```bash
cd ~/keptn-onboarding
```

**Create the Project in Keptn**
```bash
./1_create-project.sh
```

**Onboard the Carts Service**
```bash
./2_onboarding-carts.sh
```

**Add Tests to the Cart Service**
```bash
./3_add_tests_to_cart.sh
```

**Onboard the Carts Database service**
```bash
./4_onboard_database.sh
```

**Deploy the Carts database service**
```bash
./5_deploy_carts_database.sh
```

**Deploy the carts service**
```bash
./6_deploy_carts_service.sh
```

We see the Pipeline Overview from our Dashboard and analyze the events in the Keptn Bridge
**Add Service Level Indicators and Service Level objectives**
```bash
./7_quality_gates_addSLIandSLO.sh
```

**Deployment of the slow carts service and see how its rolledback in staging.**
```bash
./8_deploy_carts_v2_slow.sh
```
**Deployment of the carts service fixed so it will go all the way to production.**
```bash
./9_deploy_carts_v3_ok.sh
```

Now we do the [Runbook automation UseCase](../04_Runbook_automation)

We also integrated Dynatrace Assistant and did some Chat-Ops.
### 👱‍♀️ Assistant Interactions
https://assistant.dynatrace.com/


### Keptn Integrations (Services)
> Some keptn integrations we discussed during the workshop.

https://github.com/keptn-contrib/

https://github.com/keptn-contrib/neoload-service

https://github.com/keptn-contrib/ufo-service