CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_disposition_rhythmus (disposition_rhythmus_id, mandant_id,
nb_id, system_id, wup_id) AS SELECT disposition_rhythmus_id,
 mandant_id,
 nb_id,
 system_id,
 wup_id
FROM kfl_production_dbp_view.v_l_disposition_rhythmus;