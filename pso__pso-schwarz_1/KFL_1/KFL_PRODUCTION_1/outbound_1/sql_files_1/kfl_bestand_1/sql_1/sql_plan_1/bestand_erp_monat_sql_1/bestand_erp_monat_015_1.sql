INSERT INTO dbp_etl.vis_monat_bestand_wg_log_alt_1 (
    mandant_id, wup_id, nb_id, gjmo, art_id
)
(SELECT
    mandant_id,
    wup_id,
    nb_id,
    MIN(gjmo) AS `_gjmo`,
    art_id
FROM dbp_etl.bestand_erp_monat_tmp_1
WHERE
    nb_id = 0
    AND (
        mandant_id, wup_id, art_id, gjmo_bis) IN (
        SELECT (mandant_id, wup_id, art_id, gjmo_bis)
        FROM dbp_etl.bestand_mardh_tmp_1
        WHERE
            lade_kz = 0
            AND nb_id = 0
    )
GROUP BY
    art_id,
    mandant_id,
    wup_id,
    nb_id
HAVING (
    mandant_id, wup_id, nb_id, art_id, `_gjmo`) NOT IN (
    SELECT (mandant_id, wup_id, nb_id, art_id, gjmo)
    FROM dbp_etl.vis_monat_bestand_wg_log_alt_1
));
