# Cloud Run Reverse Proxy for Service to Service calls

This is a proof of concept to show how you can use a cloud run service with NGINX to reverse proxy traffic to a protected Cloud Run service,
with tokens that refresh periodically.

## Setup

To get this to work, you'll need two services.

1. A protected Cloud Run service which has public invocations turned off. Eg, in the security tab of the service, select "Require Authentication".
   This will limit who can invoke the service to begin with.
1. A public Cloud Run service which has the Nginx proxy running (i.e. the code in this repository)
1. A service account to assign to the above service that has the
   [Cloud Run Invoker role](https://cloud.google.com/run/docs/reference/iam/roles#run.invoker)

> [!IMPORTANT]
> You'll need to update the script and config file in this code repo with your own URL of that protected backend.
>
> - Mine looks like this: `https://hello-3qqsqbdsuq-uc.a.run.app`
> - You need to replace the value in the curl call in the script `run.sh`
> - You need to replace the value in the `nginx.conf` at `proxy_pass`

## Deployment

1. Authenticate with gcloud cli and set the project you want to use.
1. Then, once ready to deploy, run the following command:

```
gcloud run deploy nginx-frontend \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --source .
```

You can swap out the region if you want.
