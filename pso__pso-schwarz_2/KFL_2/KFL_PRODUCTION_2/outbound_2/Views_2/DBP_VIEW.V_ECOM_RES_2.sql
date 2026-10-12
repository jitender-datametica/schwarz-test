CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ecom_res_2 AS SELECT art_id,
 mandant_id,
 wup_id,
 nb_id,
 dat_von,
 dat_bis,
 aktion_id,
 bewart_id
FROM kfl_production_dbp_data.ecom_res_2;