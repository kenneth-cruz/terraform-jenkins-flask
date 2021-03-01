terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}
provider "kubernetes" {
  config_path = "~/../../.kube/config"
}

resource "kubernetes_namespace" "jenkins" {
  metadata {
    annotations = {
      name = "jenkins"
    }

    labels = {
      App = "ScalableNginxExample"
    }

    name = "flaskapp"
  }
}
  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "ScalableNginxExample"
      }
    }
    template {
      metadata {
        labels = {
          App = "ScalableNginxExample"
        }
      }
      spec {
        container {
          image = "jenkinsci/blueocean"
          name  = "example"
          port {
            container_port = 8080
          }
        
        }
      }
    }
  }
resource "kubernetes_service" "jenkins_service" {
  metadata {
    name      = "jenkins-service"
  }
  spec {
    selector = {
      App = kubernetes_deployment.jenkins.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30201
      port        = 8080
      target_port = 8080
    }
    type = "NodePort"
  }
}