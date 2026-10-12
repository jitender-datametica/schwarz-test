UPDATE dbp_data.art_per SET
    iwt_id = dt1.`_iwt_id` FROM (SELECT
    art_id AS `_art_id`,
    mandant_id AS `_mandant_id`,
    iwt_id AS `_iwt_id`
FROM ${TEMP_TABLE}) AS dt1
WHERE art_per.art_id = dt1.`_art_id` AND art_per.mandant_id = dt1.`_mandant_id`;
