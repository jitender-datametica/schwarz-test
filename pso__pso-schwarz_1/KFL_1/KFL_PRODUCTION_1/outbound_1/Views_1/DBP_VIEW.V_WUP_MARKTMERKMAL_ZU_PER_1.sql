CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_marktmerkmal_zu_per_1 AS SELECT mandant_id,
 wup_guid,
 wup_id,
 nb_id,
 dat_von,
 dat_bis,
 marktmerkmal_id,
 marktmerkmal_wert,
 td_update,
 td_insert
FROM kfl_production_dbp_data.wup_marktmerkmal_zu_per_1;