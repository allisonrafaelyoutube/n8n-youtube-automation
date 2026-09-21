SELECT e.id, e.status, e."startedAt", e.mode,
       LEFT(ed.data::text, 500) AS data_preview
FROM execution_entity e
JOIN execution_data ed ON ed."executionId" = e.id
ORDER BY e."startedAt" DESC
LIMIT 5;
