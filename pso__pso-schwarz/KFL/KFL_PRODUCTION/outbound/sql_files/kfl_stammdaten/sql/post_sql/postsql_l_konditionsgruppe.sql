UPDATE dbp_data.l_konditionsgruppe SET
    td_insert = CURRENT_TIMESTAMP(),
    td_update = CURRENT_TIMESTAMP()
WHERE td_insert IS NULL AND (
    mandant_id, konditionsgruppe_id) IN (
    SELECT (mandant_id, konditionsgruppe_id)
    FROM ${TEMP_TABLE}
);
