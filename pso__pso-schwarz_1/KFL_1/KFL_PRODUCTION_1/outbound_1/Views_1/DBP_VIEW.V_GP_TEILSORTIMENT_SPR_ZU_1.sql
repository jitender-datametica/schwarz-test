CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gp_teilsortiment_spr_zu_1 AS SELECT mandant_id,
 gp_id,
 gp_teilsortiment_id,
 einkaufsorganisation_id,
 spr_id,
 gp_teilsortiment_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.gp_teilsortiment_spr_zu_1;