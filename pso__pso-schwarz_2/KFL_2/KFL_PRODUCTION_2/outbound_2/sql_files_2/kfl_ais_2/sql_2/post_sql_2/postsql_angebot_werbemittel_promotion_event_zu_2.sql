DELETE FROM dbp_data.angebot_werbemittel_promotion_event_zu_2
WHERE (
    mandant_id, angebot_nr) IN (
    SELECT (mandant_id, angebot_nr)
    FROM ${TEMP_TABLE}
    GROUP BY mandant_id,
    angebot_nr
);


INSERT INTO dbp_data.angebot_werbemittel_promotion_event_zu_2
(
    SELECT ${TABLE_FIELDS}
    FROM ${TEMP_TABLE}
);
