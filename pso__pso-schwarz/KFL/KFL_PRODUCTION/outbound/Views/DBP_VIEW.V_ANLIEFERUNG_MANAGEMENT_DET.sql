CREATE OR REPLACE VIEW kfl_production_dbp_view.v_anlieferung_management_det AS SELECT mandant_id,
 anlieferung_id,
 best_beleg_id,
 lagernummer_id,
 wup_id,
 nb_id,
 retoure_fg,
 palettiert_fg,
 werbung_fg,
 menge_palette_ist,
 menge_palette_soll,
 gp_id
FROM kfl_production_dbp_data.anlieferung_management_det;