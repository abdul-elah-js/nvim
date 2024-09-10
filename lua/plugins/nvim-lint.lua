return {
  "mfussenegger/nvim-lint",
  lazy = true,
  opts = {
    linters_by_ft = {
      terraform = { "tflint" },
      hcl = { "tflint " },
      tf = { "tflint" },
      tfvars = { "tflint" },
    },
  },
  config = function(_, _)
    local lint = require("lint")
    local tflint = require("lint").linters.tflint
    tflint.args = {
      "--format",
      "json",
      "--disable-rule",
      "terraform_required_providers",
      "--disable-rule",
      "terraform_required_providers_version_constraint",
    }
    lint.linters_by_ft = {
      terraform = { "tflint" },
      hcl = { "tflint " },
      tf = { "tflint" },
      tfvars = { "tflint" },
    }
  end,
}
