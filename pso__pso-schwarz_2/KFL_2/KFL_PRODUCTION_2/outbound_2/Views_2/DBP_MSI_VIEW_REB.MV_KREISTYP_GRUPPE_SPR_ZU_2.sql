CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_kreistyp_gruppe_spr_zu_2 (mandant_id, kreistyp_gruppe_id, spr_id
, kreistyp_gruppe_bez) AS SELECT mandant_id,
 kreistyp_gruppe_id,
 spr_id,
 kreistyp_gruppe_bez
FROM kfl_production_dbp_view.v_kreistyp_gruppe_spr_zu_2
WHERE spr_id = 22;