return {
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/kustomization.json"] = "**/kustomization.yml",
        ["https://raw.githubusercontent.com/KevinNitroG/argocd-json-schema/refs/heads/main/schemas/v3.0.12/standalone/all.json"] = { "**/argocd/**/*.yml", "**/application.yml", "**/application-staging.yml", "**/application-production.yml" },
        kubernetes = { "**/kubernetes/*.yml", "**/production/*.yml", "**/staging/*.yml", "**/base/*.yml" },
      }
    }
  }
}
