SELECT e.id, e.status, e.mode, w.name,
       ed.data::text LIKE '%Postar comentario%' AS reached_post,
       ed.data::text LIKE '%RSS do canal%' AS reached_rss,
       ed.data::text LIKE '%Video publicado%' AS reached_filter,
       ed.data::text LIKE '%error%' AS has_error,
       ed.data::text LIKE '%5i7gyy66B_A%' AS has_video_id
FROM execution_entity e
JOIN execution_data ed ON ed."executionId" = e.id
JOIN workflow_entity w ON w.id = e."workflowId"
WHERE e.id >= 8
ORDER BY e.id DESC;
