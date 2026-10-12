BEGIN TRANSACTION;

DELETE FROM dbp_data.wup
WHERE (
    mandant_id, wup_id) IN (
    SELECT (mandant_id, wup_id)
    FROM dbp_data.wup
    GROUP BY
        wup_id,
        mandant_id
    HAVING COUNT(*) > 1
);


COMMIT TRANSACTION;
