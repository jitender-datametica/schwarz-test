DELETE FROM dbp_data.wup_1
WHERE (
    mandant_id, wup_id) IN (
    SELECT (mandant_id, wup_id)
    FROM dbp_data.wup_1
    GROUP BY
        wup_id,
        mandant_id
    HAVING COUNT(*) > 1
);
