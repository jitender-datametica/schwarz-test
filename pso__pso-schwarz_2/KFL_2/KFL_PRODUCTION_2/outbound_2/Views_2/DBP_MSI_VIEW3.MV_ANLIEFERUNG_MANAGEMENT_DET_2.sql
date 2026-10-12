CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_anlieferung_management_det_2 (mandant_id, anlieferung_id,
best_beleg_id, lagernummer_id, wup_id, nb_id, retoure_fg, palettiert_fg, werbung_fg, gp_id) AS SELECT mandant_id,
 anlieferung_id,
 best_beleg_id,
 lagernummer_id,
 wup_id,
 nb_id,
 retoure_fg,
 palettiert_fg,
 werbung_fg,
 gp_id
FROM kfl_production_dbp_view.v_anlieferung_management_det_2 AS V01;