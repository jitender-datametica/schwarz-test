DELETE FROM dbp_data.ma_hier_eb_fkt_wup_zu_per_1
WHERE ma_hierarchie_typ_id = 1;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


/* DBP_ETL.ma_hier_eb_fkt_wup_zu_per_temp */
INSERT INTO dbp_data.ma_hier_eb_fkt_wup_zu_per_1 (
    mandant_id,
    ma_hierarchie_typ_id, ma_hierarchie_id, dat_von, ma_funktion_id, ma_hierarchie_ebene_id, wup_id
)
(SELECT
    mandant_id,
    ma_hierarchie_typ_id,
    ma_hierarchie_id,
    dat_von,
    ma_funktion_id,
    ma_hierarchie_ebene_id,
    wup_id
FROM ${TEMP_TABLE});
