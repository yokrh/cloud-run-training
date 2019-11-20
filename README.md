# Cloud run training

GCP Cloud run
https://cloud.google.com/run/?hl=ja

Qiita article Ref
https://qiita.com/ryo2132/items/fe3e8e7dc410a316a0be


## Prerequisite

* GCP account

* gcloud (Google Cloud SDK)
https://cloud.google.com/sdk/docs/quickstart-mac-os-x?hl=ja
```sh
# install
sh install.sh

# add PATH
export PATH="/Users/yoshi/Desktop/app/gcloud/google-cloud-sdk/bin:$PATH"

# check
gcloud -v

# update
gcloud components update

# setup with selecting GCP project
gcloud init
gcloud config list

# re-login if needed
gcloud auth login
```


## Deploy

`Dockerfile`
```sh
FROM node:10

WORKDIR /src

ENV PORT 8080
ENV HOST 0.0.0.0

COPY . .

RUN npm install

CMD ["npm", "run", "start"]
```

`cloud-build.yml`
```yml
steps:
- name: gcr.io/cloud-builders/docker
  args:
    ['build','-f','Dockerfile','-t','gcr.io/your-project-name/hello-cloud-run','.']
images: ['gcr.io/your-project-name/hello-cloud-run']
```

```sh
# build
gcloud builds submit --config=./cloud-build.yml
```

See the build succeeded and the created container image from the build detail.
https://console.cloud.google.com/cloud-build/builds?hl=ja

```sh
# deploy
gcloud beta run deploy hcr --region asia-northeast1 --allow-unauthenticated --image gcr.io/your-project-name/hello-cloud-run

# Region name list is here https://cloud.google.com/compute/docs/regions-zones/?hl=ja
```

Result must be like:
```sh
[1] Cloud Run (fully managed)
# choose > 1

...
Service [hcr] revision [hcr-00002-beq] has been deployed and is serving 100 percent of traffic at https://hcr-xxxxxx-xxx.a.run.app
```

Access to https://hcr-xxxxxx-xxx.a.run.app

Clean from GCP web console
https://console.cloud.google.com/run/detail/asia-northeast1/hcr/logs?project=xxxxxx.


<!-- 
# hello-cloud-run

> My best Nuxt.js project

## Build Setup

``` bash
# install dependencies
$ npm run install

# serve with hot reload at localhost:3000
$ npm run dev

# build for production and launch server
$ npm run build
$ npm run start

# generate static project
$ npm run generate
```

For detailed explanation on how things work, check out [Nuxt.js docs](https://nuxtjs.org). -->

