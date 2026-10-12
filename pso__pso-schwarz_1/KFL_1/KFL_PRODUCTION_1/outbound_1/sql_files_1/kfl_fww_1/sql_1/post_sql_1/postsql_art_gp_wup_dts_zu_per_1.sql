UPDATE dbp_data.art_gp_wup_dts_zu_per_1 SET
    dat_bis = b.dat_bis_ FROM (
    SELECT
        mandant_id AS mandant_id_,
        wup_id AS wup_id_,
        art_id AS art_id_,
        MAX(dat_von) AS dat_bis_
    FROM ${TEMP_TABLE}
    GROUP BY
        mandant_id_,
        wup_id_,
        art_id_
) AS b
WHERE
    art_gp_wup_dts_zu_per.mandant_id = b.mandant_id_ AND art_gp_wup_dts_zu_per.wup_id = b.wup_id_ AND
    art_gp_wup_dts_zu_per.art_id = b.art_id_ AND art_gp_wup_dts_zu_per.dat_bis = DATE '9999-12-31' AND (
        art_gp_wup_dts_zu_per.mandant_id, art_gp_wup_dts_zu_per.wup_id, art_gp_wup_dts_zu_per.art_id, art_gp_wup_dts_zu_per.gp_id) NOT IN (
        SELECT (mandant_id, wup_id, art_id, gp_id)
        FROM ${TEMP_TABLE}
    );
