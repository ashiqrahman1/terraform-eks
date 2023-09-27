resource "kubernetes_namespace" "example" {
  metadata {
    name = "terraform"
  }
}

# create deployments
resource "kubernetes_deployment" "nginx_deployment" {
  metadata {
    name = "nginx-terraform"
    labels = {
        app = "nginx"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "nginx"
      }
    }
    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }
      spec {
        container {
          image = "nginx"
          name = "nginx"
          port {
            container_port = "80"
          }
        }
      }
    }
  }
}

# create service
resource "kubernetes_service" "websvc" {
  metadata {
    name = "websvc"
    labels = {
      app = "terraform-svc"
    }
  }
  spec {
    selector = {
      app = "nginx"
    }
    port {
      port = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}


# create service account
resource "kubernetes_service_account_v1" "s3read" {
  metadata {
    name = var.serviceaccount
    annotations = {
      "eks.amazonaws.com/role-arn": "${aws_iam_role.eksaccessrole.arn}"
    }
  }
}

resource "kubernetes_pod_v1" "mypod" {
  metadata {
    name = "testing"
  }
  spec {
    service_account_name = "${var.serviceaccount}"
    container {
      name = "testing"
      image = "amazon/aws-cli:latest"
      command = ["sleep","3000"]
    }
  }
  depends_on = [ kubernetes_service_account_v1.s3read ]
}
