CREATE OR REPLACE VIEW kfl_production_dbp_view.v_marktmerkmal_wert_spr_zu_2 AS SELECT marktmerkmal_id,
 marktmerkmal_wert,
 spr_id,
 marktmerkmal_wert_bez,
 marktmerkmal_wert_kbez
FROM kfl_production_dbp_data.marktmerkmal_wert_spr_zu_2;