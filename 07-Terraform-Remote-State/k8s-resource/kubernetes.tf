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