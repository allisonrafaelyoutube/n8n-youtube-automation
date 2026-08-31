# Facebook Page — comentario automatico

Pagina: https://www.facebook.com/allisonrafaell/

Webhook n8n: `https://n8n-youtube-xs7s.onrender.com/webhook/facebook-page`

---

## 1. Criar app na Meta

1. Acesse [developers.facebook.com](https://developers.facebook.com) (conta que administra a Pagina)
2. **My Apps → Create App** → tipo **Business**
3. Nome sugerido: `n8n-allisonrafaell-automation`
4. Adicione produto **Webhooks**

---

## 2. Pegar Page ID e Page Access Token

### Page ID
1. Abra [Meta Business Suite](https://business.facebook.com/) → Pagina **allisonrafaell**
2. **Configuracoes da Pagina → Sobre** (ou use [Graph API Explorer](https://developers.facebook.com/tools/explorer/))
3. Copie o **ID numerico** da Pagina (ex.: `123456789012345`)

### Page Access Token (long-lived)
1. Graph API Explorer → app criado → **Get Page Access Token**
2. Permissoes necessarias:
   - `pages_manage_engagement` (comentar)
   - `pages_read_engagement` (ler posts)
   - `pages_show_list`
3. Gere token da **Pagina** (nao perfil pessoal)
4. Troque por token long-lived se necessario (Meta docs: long-lived page token)

> **App Review:** em producao a Meta pode exigir aprovacao das permissoes acima.

---

## 3. Configurar Webhooks no app Meta

Em **Webhooks → Page**:

| Campo | Valor |
|-------|-------|
| **Callback URL** | `https://n8n-youtube-xs7s.onrender.com/webhook/facebook-page` |
| **Verify Token** | invente uma senha (ex.: `n8n-fb-allison-2026`) — mesma no Render |
| **Subscription fields** | marque **`feed`** |

Clique **Verify and Save** (o workflow Facebook precisa estar **ATIVO** no n8n antes).

Depois, **Subscribe** a Pagina `allisonrafaell` ao app.

---

## 4. Variaveis no Render

Render → servico `n8n-youtube` → **Environment**:

| Variavel | Exemplo |
|----------|---------|
| `FACEBOOK_VERIFY_TOKEN` | `n8n-fb-allison-2026` |
| `FACEBOOK_PAGE_ID` | ID numerico da Pagina |
| `FACEBOOK_PAGE_ACCESS_TOKEN` | token long-lived da Pagina |
| `FACEBOOK_COMMENT_TEXT` | (opcional) mesmo texto do YouTube |

Se `FACEBOOK_COMMENT_TEXT` vazio, usa `YOUTUBE_COMMENT_TEXT`.

---

## 5. Importar workflow no n8n

1. **Import from File** → `workflows/facebook-page-comment.json`
2. **Ative** o workflow
3. Volte na Meta e clique **Verify and Save** no webhook
4. Publique um post teste na Pagina
5. Veja **Executions** no n8n

---

## Limitacoes

- Funciona em **Pagina**, nao em perfil pessoal
- **Fixar comentario** no Facebook: manual (API limitada)
- **Like** no comentario: nao confiavel via API
- Texto identico em todo post pode ser flag de spam — varie se necessario
- Instagram/Reels = workflow separado (Instagram Graph API)

---

## Troubleshooting

| Erro | Solucao |
|------|---------|
| Verify falhou | Workflow ativo + `FACEBOOK_VERIFY_TOKEN` igual na Meta e Render |
| 403 no comentario | Token sem `pages_manage_engagement` ou App Review pendente |
| Webhook nao dispara | Pagina inscrita no app + campo `feed` marcado |
| Comentario duplicado | Nao rode dois workflows Facebook iguais ativos |
