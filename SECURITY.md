# 🔐 Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| 1.0.x   | ✅        |

## Reporting a Vulnerability

If you discover a security vulnerability, please report it privately by opening an issue on GitHub.

## Security Best Practices

### API Keys

- **Never** commit API keys to the repository
- Use environment variables or secure secret management
- Rotate keys regularly

### Scripts

- Review all scripts before execution
- The `quick-start.sh` script requires user confirmation at each step
- No destructive operations without explicit consent

### Configuration

- Store sensitive configuration in `.env` files (gitignored)
- Use `openclaw.json` only for non-sensitive settings
- Enable `security.actionApproval` for sensitive operations

## Audit Trail

This project has been audited for:
- ✅ No hardcoded secrets
- ✅ No external network calls without user consent
- ✅ No destructive file operations
- ✅ Shell syntax validation passed
- ✅ Proper error handling

## Dependencies

| Dependency | Purpose | Security Status |
|------------|---------|-----------------|
| OpenClaw | Core platform | ✅ Official |
| openclaw-ops | Operations/Monitoring | ✅ Audited |
| Node.js | Runtime | ✅ System |
| Python 3 | Script execution | ✅ System |

## Compliance

- Follows OpenClaw security guidelines v2026.2.12+
- CVE-2026-25253 mitigated (minimum version requirement)
- No known vulnerabilities as of 2026-04-02

---

**Last audit:** 2026-04-02 by @Fridayassis_bot
