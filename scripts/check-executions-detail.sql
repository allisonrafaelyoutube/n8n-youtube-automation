SELECT e.id, e.mode, e.status, e.finished, e."startedAt", w.name AS workflow_name
FROM execution_entity e
LEFT JOIN workflow_entity w ON w.id = e."workflowId"
ORDER BY e."startedAt" DESC
LIMIT 10;
