UPDATE dbp_data.ek_infosatz SET
    loesch_fg = 1
WHERE mandant_id = 1 AND loesch_fg = 0 AND (
    mandant_id, ek_infosatz_id) NOT IN (
    SELECT (mandant_id, ek_infosatz_id)
    FROM ${TEMP_TABLE}
    WHERE mandant_id = 1
);


UPDATE dbp_data.ek_infosatz AS ek_infosatz0 SET
    dat_bis = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY) FROM (SELECT
    mandant_id,
    ek_infosatz_id
FROM dbp_data.ek_infosatz
WHERE 1 IN (
    SELECT 1
    FROM ${TEMP_TABLE}
    WHERE mandant_id = 1
)
AND mandant_id = 1
AND dat_bis = DATE '9999-12-31'
AND (
    mandant_id, ek_infosatz_id) NOT IN (
    SELECT (mandant_id, ek_infosatz_id)
    FROM ${TEMP_TABLE}
    WHERE mandant_id = 1
)) AS b
WHERE ek_infosatz0.mandant_id = b.mandant_id AND ek_infosatz0.ek_infosatz_id = b.ek_infosatz_id;


INSERT INTO dbp_data.ek_infosatz (
    mandant_id, ek_infosatz_id, art_id, gp_id, einkaufsorganisation_id,
    dat_erstellung, gp_art_id, dat_von, dat_bis, regel_gp_fg, loesch_fg, gp_teilsortiment_id, konditionsgruppe_id,
    menge_einh_id, apollo_ian, td_update, td_insert
)
(
    SELECT
        4 AS mandant_id,
        ek_infosatz_id,
        art_id,
        gp_id,
        1040 AS einkaufsorganisation_id,
        dat_erstellung,
        gp_art_id,
        dat_von,
        dat_bis,
        regel_gp_fg,
        loesch_fg,
        gp_teilsortiment_id,
        konditionsgruppe_id,
        menge_einh_id,
        apollo_ian,
        td_update,
        td_insert
    FROM dbp_data.ek_infosatz
    WHERE
        mandant_id = 7
        AND ek_infosatz_id IN (
            SELECT ek_infosatz_id
            FROM dbp_data.ek_infosatz
            WHERE mandant_id IN (4, 7)
            GROUP BY ek_infosatz_id
            HAVING COUNT(*) <> 2
        )
);
