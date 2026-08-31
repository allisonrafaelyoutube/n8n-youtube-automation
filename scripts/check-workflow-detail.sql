SELECT name, active, nodes::text LIKE '%youtube%' AS has_youtube, nodes::text LIKE '%scheduleTrigger%' AS has_schedule FROM workflow_entity;
