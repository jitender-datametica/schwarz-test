CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ims_mamo_wup_schliessung_per_1 AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat_schliessung_von,
 dat_schliessung_bis
FROM kfl_production_dbp_data.ims_mamo_wup_schliessung_per_1;