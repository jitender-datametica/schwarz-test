CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ts_wbs_vz_tag AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 non_adjustable_day_fg,
 kommentar
FROM kfl_production_dbp_view.v_ts_wbs_vz_tag;