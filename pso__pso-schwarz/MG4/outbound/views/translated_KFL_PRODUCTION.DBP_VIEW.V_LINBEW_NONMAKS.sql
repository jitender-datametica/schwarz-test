CREATE OR REPLACE VIEW kfl_production_dbp_view.v_linbew_nonmaks (mandant_id, lin_kurs_id, hr_objekt_id, dat, wup_id,
unternehmens_bereich_id, anzahl_kurse_gesamt, anzahl_kurse_abgeschlossen, ki_fg, td_update, td_insert) AS SELECT
 mandant_id,
 lin_kurs_id,
 hr_objekt_id,
 dat,
 wup_id,
 unternehmens_bereich_id,
 anzahl_kurse_gesamt,
 anzahl_kurse_abgeschlossen,
 ki_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.linbew_nonmaks;