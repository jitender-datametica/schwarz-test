CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ma_kontingent_zu_per_1 AS SELECT mandant_id,
 mitarbeiter_id,
 kjmo,
 kontingent_id,
 dat_von,
 dat_bis,
 anz_kontingent,
 td_insert,
 td_update
FROM kfl_production_dbp_data.ma_kontingent_zu_per_1;