CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_gp_teilsortiment_1 AS SELECT mandant_id,
 gp_id,
 gp_teilsortiment_id,
 einkaufsorganisation_id,
 zahlungsziel_id,
 zek_id
FROM kfl_production_dbp_data.l_gp_teilsortiment_1;