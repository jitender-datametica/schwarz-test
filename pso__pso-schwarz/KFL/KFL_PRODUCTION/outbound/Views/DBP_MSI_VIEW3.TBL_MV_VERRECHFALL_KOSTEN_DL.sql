CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_verrechfall_kosten_dl AS SELECT V01.mandant_id,
 V01.verrechfall_kosten_id,
 V01.mwst_id,
 V01.storno_fg,
 V01.soll_ist_fg,
 V01.manuelle_erfassung_fg,
 V03.wrg_id,
 V03.wrg_typ_id,
 V01.verrechfall_id,
 V01.dat_verrechnung_intern,
 V01.dat_verrechnung_extern,
 V01.verrechfall_kostenart_id,
 V01.verrechfall_status_id,
 ROUND(CAST(CASE
    WHEN V03.wrg_typ_id = 0
    THEN V01.betrag_kosten * V02.umrechnungskurs
    ELSE V01.betrag_kosten
    END AS NUMERIC), 2) AS betrag_kosten,
 V01.bemerkung,
 V01.zeit_verrechnung_intern,
 DATETIME(V01.dat_verrechnung_intern, COALESCE(V01.zeit_verrechnung_intern, TIME '00:00:00')) AS dt_verechnung_intern,
  CASE
  WHEN V01.betrag_kosten < 0
  THEN 1
  ELSE 0
  END AS vorzeichen_fg,
 V01.belosart_fg
FROM kfl_production_dbp_view.v_verrechfall_kosten AS V01
 INNER JOIN kfl_production_dbp_msi_view3.mv_kurs AS V02 ON V01.wrg_id = V02.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V03 ON V01.mandant_id = V03.mandant_id
WHERE V01.soll_ist_fg = 1
 AND V01.belosart_fg = 1
 AND V01.verrechfall_status_id NOT IN ('BCC080', 'BCC085', 'BCC090');