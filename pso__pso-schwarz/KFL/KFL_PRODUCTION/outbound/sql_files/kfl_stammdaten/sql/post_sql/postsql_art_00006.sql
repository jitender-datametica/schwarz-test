--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE dbp_data.art AS art0 SET
    mutter_wb_id = NULL FROM (
    SELECT
        art_id AS `_art_id`,
        mandant_id AS `_mandant_id`
    FROM dbp_data.art
    WHERE
        mandant_id = 1
        AND (
            mandant_id, art_id) NOT IN (
            SELECT (mandant_id, art_id)
            FROM ${TEMP_TABLE}
        )
) AS t1
WHERE art0.art_id = t1.`_art_id` AND art0.mandant_id = t1.`_mandant_id`;
