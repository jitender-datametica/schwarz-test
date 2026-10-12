-- ,unternehmens_bereich_id
 CREATE OR REPLACE VIEW dbp_msi_view_lin.mv_linbew_nonmaks_1 (mandant_id, lin_kurs_id,
hr_objekt_id, kjmo, ki_fg, anzahl_kurse_gesamt, anzahl_kurse_abgeschlossen) AS SELECT v01.mandant_id,
 v01.lin_kurs_id,
 v01.hr_objekt_id,
 v02.kjmo,
 v01.ki_fg,
 v01.anzahl_kurse_gesamt,
 v01.anzahl_kurse_abgeschlossen
FROM kfl_production_dbp_view.v_linbew_nonmaks_1 AS v01
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS v02 ON v01.dat = v02.dat
WHERE v01.hr_objekt_id > 0
QUALIFY (ROW_NUMBER() OVER (PARTITION BY v01.mandant_id, v01.lin_kurs_id, v01.hr_objekt_id, v02.kjmo, v01.ki_fg ORDER BY
      v02.dat IS NULL DESC, v02.dat DESC)) = 1;