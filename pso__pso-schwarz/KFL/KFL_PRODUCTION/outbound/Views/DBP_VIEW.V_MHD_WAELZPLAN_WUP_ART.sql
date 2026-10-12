CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mhd_waelzplan_wup_art AS SELECT mandant_id,
 wup_id,
 kjwo,
 art_id,
 waelzplan_pruef_id,
 wiederholungsrhythmus_wochen,
 kjwo_wiederholung,
 dat_aenderung
FROM kfl_production_dbp_data.mhd_waelzplan_wup_art;