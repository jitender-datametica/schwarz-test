TRUNCATE TABLE dbp_data.marktbestand_erp_delta_2;


INSERT INTO dbp_data.marktbestand_erp_delta_2 (
    art_id, mandant_id, wup_id, nb_id, dat,
    menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme
)
(SELECT
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY) AS dat,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_qual_bme
FROM dbp_data.marktbestand_erp_2
WHERE (
    mandant_id, wup_id, art_id, dat) IN (
    SELECT (mandant_id, wup_id, art_id, MAX(dat))
    FROM dbp_data.marktbestand_erp_2
    WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 10 DAY) AND (CURRENT_DATE("Europe/Berlin"))
    GROUP BY mandant_id,
    wup_id,
    art_id
));


DELETE FROM dbp_data.marktbestand_erp_delta_2
WHERE (
    mandant_id, art_id, wup_id) IN (
    SELECT (mandant_id, art_id, wup_id)
    FROM ${TEMP_TABLE}
);


INSERT INTO dbp_data.marktbestand_erp_delta_2 (
    art_id, mandant_id, wup_id, nb_id, dat,
    menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme
)
(SELECT
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY) AS dat,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_qual_bme
FROM ${TEMP_TABLE});
