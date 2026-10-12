CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_linbew_nonmaks (mandant_id, lin_kurs_id, hr_objekt_id, kjmo,
ki_fg, anzahl_kurse_gesamt, anzahl_kurse_abgeschlossen) AS SELECT V01.mandant_id,
 V01.lin_kurs_id,
 V01.hr_objekt_id,
 V02.kjmo,
 V01.ki_fg,
 V01.anzahl_kurse_gesamt,
 V01.anzahl_kurse_abgeschlossen
FROM kfl_production_dbp_view.v_linbew_nonmaks AS V01
 INNER JOIN kfl_production_dbp_view.v_tag AS V02 ON V01.dat = V02.dat
WHERE V01.hr_objekt_id > 0
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(V01.mandant_id AS STRING), V01.lin_kurs_id, V01.hr_objekt_id, CAST(V02.kjmo AS STRING)
      , CAST(V01.ki_fg AS STRING) ORDER BY V02.dat IS NULL DESC, V02.dat DESC)) = 1;