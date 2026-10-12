CREATE OR REPLACE VIEW kfl_production_dbp_view.v_marktmerkmal_spr_zu AS SELECT marktmerkmal_id,
 spr_id,
 marktmerkmal_bez,
 marktmerkmal_kbez
FROM kfl_production_dbp_data.marktmerkmal_spr_zu;