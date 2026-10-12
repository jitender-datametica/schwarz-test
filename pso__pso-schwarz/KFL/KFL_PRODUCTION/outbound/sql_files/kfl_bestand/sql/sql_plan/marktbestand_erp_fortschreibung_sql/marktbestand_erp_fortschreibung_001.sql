--translated statement


DELETE FROM dbp_data.marktbestand_erp
WHERE dat = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY) AND fortschreibung_fg = 1;


--translated statement


INSERT INTO dbp_data.marktbestand_erp (
    mandant_id, art_id, wup_id, nb_id, dat, bestand_id, bezugsweg_id,
    relevant_fg, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme, menge_lgbest_erp_gesp_bme, fortschreibung_fg,
    td_update, td_insert
)
(
    SELECT
        mandant_id,
        art_id,
        wup_id,
        nb_id,
        DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY) AS dat,
        bestand_id,
        bezugsweg_id,
        relevant_fg,
        menge_lgbest_erp_frei_bme,
        menge_lgbest_erp_qual_bme,
        menge_lgbest_erp_gesp_bme,
        1 AS fortschreibung_fg,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM dbp_data.marktbestand_erp
    WHERE
        dat = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY) - 1
        AND (
            mandant_id, art_id, wup_id) NOT IN (
            SELECT (mandant_id, art_id, wup_id)
            FROM dbp_data.marktbestand_erp
            WHERE dat = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY)
        )
);
