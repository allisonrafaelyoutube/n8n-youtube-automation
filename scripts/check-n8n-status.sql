SELECT name, active FROM workflow_entity ORDER BY "createdAt" DESC LIMIT 5;
SELECT name, type FROM credentials_entity ORDER BY "createdAt" DESC LIMIT 5;
SELECT COUNT(*) AS executions FROM execution_entity;
