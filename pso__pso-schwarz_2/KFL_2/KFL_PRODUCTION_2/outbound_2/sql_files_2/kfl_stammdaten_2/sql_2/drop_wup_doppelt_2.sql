BEGIN TRANSACTION;

DELETE FROM dbp_data.wup_2
WHERE (
    mandant_id, wup_id) IN (
    SELECT (mandant_id, wup_id)
    FROM dbp_data.wup_2
    GROUP BY
        wup_id,
        mandant_id
    HAVING COUNT(*) > 1
);


COMMIT TRANSACTION;
