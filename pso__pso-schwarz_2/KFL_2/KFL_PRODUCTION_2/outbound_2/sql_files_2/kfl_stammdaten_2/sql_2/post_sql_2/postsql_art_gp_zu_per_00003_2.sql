--AW 2021-04-22 check OK


UPDATE dbp_data.art_gp_zu_per_2 SET
    mutter_ek_id = t1.`_mutter_ek_id`,
    td_update = CURRENT_TIMESTAMP() FROM (SELECT
    dat_von AS `_dat_von`,
    mandant_id AS `_mandant_id`,
    art_id AS `_art_id`,
    mutter_ek_id AS `_mutter_ek_id`
FROM ${TEMP_TABLE}) AS t1_2
WHERE
    art_gp_zu_per.dat_bis = PARSE_DATE('%F', '9999-12-31') AND art_gp_zu_per.mandant_id = t1.`_mandant_id` AND
    art_gp_zu_per.art_id = t1.`_art_id`;


UPDATE dbp_data.art_gp_zu_per_2 SET
    mutter_ek_id = NULL
WHERE mandant_id = 1 AND (
    mandant_id, art_id) NOT IN (
    SELECT (mandant_id, art_id)
    FROM ${TEMP_TABLE}
    GROUP BY mandant_id,
    art_id
);


UPDATE dbp_data.art_gp_zu_per_2 SET
    dat_von = PARSE_DATE('%Y%m%d', '20170101')
WHERE mandant_id = 1 AND art_id IN (
    1280100, 1280200, 1280300, 1280400, 1280500, 1280600) AND dat_von = PARSE_DATE(
    '%Y%m%d',
    '20180101'
);
