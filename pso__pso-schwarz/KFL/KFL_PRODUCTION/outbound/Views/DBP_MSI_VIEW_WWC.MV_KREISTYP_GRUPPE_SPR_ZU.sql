CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_kreistyp_gruppe_spr_zu (mandant_id, kreistyp_gruppe_id, spr_id
, kreistyp_gruppe_bez) AS SELECT mandant_id,
 kreistyp_gruppe_id,
 spr_id,
 kreistyp_gruppe_bez
FROM kfl_production_dbp_view.v_kreistyp_gruppe_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22;