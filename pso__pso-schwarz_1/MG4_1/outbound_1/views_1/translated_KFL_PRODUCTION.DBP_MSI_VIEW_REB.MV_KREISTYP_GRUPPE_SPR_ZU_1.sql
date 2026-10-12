CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_kreistyp_gruppe_spr_zu_1 (mandant_id, kreistyp_gruppe_id, spr_id
, kreistyp_gruppe_bez) AS SELECT mandant_id,
 kreistyp_gruppe_id,
 spr_id,
 kreistyp_gruppe_bez
FROM kfl_production_dbp_view.v_kreistyp_gruppe_spr_zu_1
WHERE spr_id = 22;