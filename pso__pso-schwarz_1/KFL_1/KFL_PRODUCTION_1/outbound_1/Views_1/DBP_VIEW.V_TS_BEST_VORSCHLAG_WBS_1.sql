CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ts_best_vorschlag_wbs_1 AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 dat_ausfuehrung,
 menge_wbs_final,
 check_vz_fg,
 check_wup_fg,
 status_verarbeitung
FROM kfl_production_dbp_data.ts_best_vorschlag_wbs_1;