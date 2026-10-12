-- AP0062304 | mayko | initial creation |

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_ts_wbs_vz_tag (mandant_id, wup_id, nb_id, dat,
non_adjustable_day_fg, kommentar) AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 non_adjustable_day_fg,
 kommentar
FROM kfl_production_dbp_view.v_ts_wbs_vz_tag;