--should only be valid for kmo countries (interface lfm1_kmo+wyt1t_kmo)
--for mandant_id=1 used lfm2_de+wyt1t_de


DELETE FROM dbp_data.gp_teilsortiment_spr_zu AS TGT
WHERE (mandant_id, gp_id, RTRIM(gp_teilsortiment_id), einkaufsorganisation_id, spr_id) IN (SELECT (
    mandant_id, gp_id,
    RTRIM(gp_teilsortiment_id), einkaufsorganisation_id, spr_id
)
FROM ${TEMP_TABLE} AS TMP) AND mandant_id <> 1;


INSERT INTO dbp_data.gp_teilsortiment_spr_zu (
    mandant_id, gp_id, gp_teilsortiment_id,
    einkaufsorganisation_id, spr_id, gp_teilsortiment_bez, td_update, td_insert
)
(
    SELECT
        mandant_id,
        gp_id,
        RTRIM(gp_teilsortiment_id) AS tmp_gp_teilsortiment_id,
        einkaufsorganisation_id,
        spr_id,
        RTRIM(gp_teilsortiment_bez) AS tmp_gp_teilsortiment_bez,
        td_update,
        td_insert
    FROM ${TEMP_TABLE} AS TMP
    WHERE
        mandant_id <> 1
        AND (
            mandant_id, gp_id) NOT IN (
            SELECT (mandant_id, gp_id)
            FROM dbp_data.gp_teilsortiment_spr_zu
        )
);
