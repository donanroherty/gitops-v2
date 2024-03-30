terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

resources "kubernetes_manifest" "argocd" {
  manifest = {
    apiVersion = "kustomize.toolkit.fluxcd.io/v1beta2"
    kind       = "Kustomization"
    metadata = {
      name      = "argocd"
      namespace = "argocd"
    }
    spec = {
      interval = "1m"
      path     = "./argocd"
      prune    = true
      sourceRef = {
        kind = "GitRepository"
        name = "argocd-kustomize-repo"
      }
    }
  }
}
