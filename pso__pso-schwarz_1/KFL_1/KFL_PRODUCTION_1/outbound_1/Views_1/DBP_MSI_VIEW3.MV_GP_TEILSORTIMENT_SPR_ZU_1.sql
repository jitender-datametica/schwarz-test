CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_gp_teilsortiment_spr_zu_1 (mandant_id, gp_id, gp_teilsortiment_id,
einkaufsorganisation_id, spr_id, gp_teilsortiment_bez) AS SELECT mandant_id,
 gp_id,
 gp_teilsortiment_id,
 einkaufsorganisation_id,
 spr_id,
 gp_teilsortiment_bez
FROM kfl_production_dbp_view.v_gp_teilsortiment_spr_zu_1;