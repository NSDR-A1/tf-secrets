# Managing Secrets in Terraform

Compares three levels of secret handling, using AWS SSM Parameter Store.

| Level | Technique | In CLI output? | In state file? |
|---|---|---|---|
| 0 | Plain variable | Visible | Plain text |
| 1 | `sensitive = true` | Hidden | **Still plain text** |
| 2 | `ephemeral` resource + write-only argument (`value_wo`) | Never shown | **Not stored** |

## Key points

- `sensitive` only hides values from the terminal. The state file still contains them.
- Ephemeral values exist only during a run and are never written to state or plan files.
- Write-only arguments send a value to the provider without storing it. Bumping `value_wo_version` rotates the secret.
- Secrets are supplied through `TF_VAR_` environment variables or generated, never hardcoded.

## What I learned

- creating secrets
