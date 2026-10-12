DELETE FROM dbp_data.angebot_art_wup_zu_2
WHERE (
    mandant_id, wup_id, angebot_nr) IN (
    SELECT (mandant_id, wup_id, angebot_nr)
    FROM ${TEMP_TABLE}
);


INSERT INTO dbp_data.angebot_art_wup_zu_2
(
    SELECT ${TABLE_FIELDS}
    FROM ${TEMP_TABLE}
);
