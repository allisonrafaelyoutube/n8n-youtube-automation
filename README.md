# n8n YouTube Automation

Automacao para postar comentario automatico em videos novos do seu canal YouTube.

**Importante:** a API do YouTube **nao permite fixar (pin) comentarios**. O workflow posta o comentario e voce fixa manualmente no YouTube Studio.

## Stack

| Servico | Funcao |
|---------|--------|
| **Render** | Hospeda o n8n 24/7 (plano free + keep-alive) |
| **Supabase** | Banco Postgres persistente (nao expira em 30 dias) |
| **Google Cloud** | OAuth + YouTube Data API v3 |
| **GitHub** | Repo com `render.yaml` para deploy |

## Status atual

- [x] Render MCP conectado (`allisonrafaelaraujo@gmail.com`)
- [x] Supabase CLI logada e linkada (`enxnxtrymptxmwydqrus` — projeto **Youtube**)
- [x] GitHub: [allisonrafaelyoutube/n8n-youtube-automation](https://github.com/allisonrafaelyoutube/n8n-youtube-automation)
- [x] Render deploy: [n8n-youtube-xs7s.onrender.com](https://n8n-youtube-xs7s.onrender.com)
- [ ] Senha do Postgres configurada no Render (`DB_POSTGRESDB_PASSWORD`)
- [ ] Keep-alive no [cron-job.org](https://cron-job.org) (ping `/healthz` a cada 10 min)
- [ ] Workflow importado no n8n

---

## Passo 1 — Supabase (banco do n8n)

1. Abra [supabase.com/dashboard](https://supabase.com/dashboard) (conta `allisonrafaelaraujo@gmail.com`)
2. Crie um projeto (ex.: `n8n-youtube`)
3. Va em **Project Settings > Database**
4. Copie:
   - **Host:** `db.xxxxx.supabase.co`
   - **Database:** `postgres`
   - **User:** `postgres`
   - **Password:** (a senha que voce definiu)

---

## Passo 2 — GitHub (conta nova)

No PowerShell, troque para a conta GitHub nova:

```powershell
gh auth logout
gh auth login
```

Depois crie e envie o repo:

```powershell
cd C:\Users\Admin\n8n-youtube-automation
git init
git add .
git commit -m "Setup n8n YouTube automation for Render + Supabase"
gh repo create n8n-youtube-automation --private --source=. --remote=origin --push
```

---

## Passo 3 — Deploy no Render (Blueprint)

1. [dashboard.render.com](https://dashboard.render.com) > **New > Blueprint**
2. Conecte o repo `n8n-youtube-automation`
3. Preencha as variaveis `sync: false`:

| Variavel | Valor |
|----------|-------|
| `DB_POSTGRESDB_HOST` | `db.xxxxx.supabase.co` |
| `DB_POSTGRESDB_DATABASE` | `postgres` |
| `DB_POSTGRESDB_USER` | `postgres` |
| `DB_POSTGRESDB_PASSWORD` | senha do Supabase |
| `N8N_HOST` | URL do servico (ex.: `n8n-youtube-xxxx.onrender.com`) |
| `WEBHOOK_URL` | `https://n8n-youtube-xxxx.onrender.com/` |

4. Clique **Deploy Blueprint**

---

## Passo 4 — Keep-alive (plano free)

O Render free dorme apos 15 min. Configure um ping gratuito:

1. Crie conta em [cron-job.org](https://cron-job.org)
2. Novo cron job:
   - **URL:** `https://SEU-N8N.onrender.com/healthz`
   - **Intervalo:** a cada 10 minutos

---

## Passo 5 — Google Cloud (YouTube API)

1. [console.cloud.google.com](https://console.cloud.google.com) — login com a conta Google **do canal**
2. Crie projeto > ative **YouTube Data API v3**
3. **APIs & Services > Credentials > Create OAuth 2.0 Client ID**
   - Tipo: Web application
   - Redirect URI: `https://SEU-N8N.onrender.com/rest/oauth2-credential/callback`
4. No n8n: **Credentials > YouTube OAuth2 API** — cole Client ID/Secret e conecte

Scope necessario:

```
https://www.googleapis.com/auth/youtube.force-ssl
```

---

## Passo 6 — Importar workflow

1. Abra seu n8n no Render
2. **Workflows > Import from File**
3. Selecione `workflows/youtube-auto-comment.json`
4. Configure:
   - Credencial YouTube OAuth
   - Variavel de ambiente `YOUTUBE_CHANNEL_ID` no Render (Settings > Environment)
   - Variavel `YOUTUBE_COMMENT_TEXT` com o texto do comentario
5. Ative o workflow

---

## Pin do comentario

A API **nao suporta pin**. Apos cada video novo:

1. Abra o link que o workflow gera (`studioUrl`)
2. Encontre seu comentario
3. Clique em **Fixar**

Opcional: adicione um no de **Email/Telegram** no n8n para receber aviso com o link direto.

---

## MCPs no Cursor

Para eu gerenciar Render/Supabase daqui:

```powershell
cd C:\Users\Admin\n8n-youtube-automation\scripts
.\configurar-mcp.ps1
```

Ou conecte em **Settings > Tools & MCP > Render / Supabase > Connect**.

Render ja esta OK. Supabase ainda precisa de Connect no Cursor.

---

## Arquivos

```
n8n-youtube-automation/
├── render.yaml              # Deploy Blueprint (Render)
├── workflows/
│   └── youtube-auto-comment.json
├── scripts/
│   └── configurar-mcp.ps1
├── .env.example
└── README.md
```
