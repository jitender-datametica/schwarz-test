CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_verrechfall_kosten_2 (mandant_id, verrechfall_kosten_id,
mwst_id, storno_fg, soll_ist_fg, manuelle_erfassung_fg, wrg_id, wrg_typ_id, verrechfall_id, dat_verrechnung_intern,
dat_verrechnung_extern, verrechfall_kostenart_id, verrechfall_status_id, betrag_kosten, bemerkung,
zeit_verrechnung_intern, dt_verechnung_intern, belosart_fg) AS SELECT V01.mandant_id,
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
 DATETIME(V01.dat_verrechnung_intern, V01.zeit_verrechnung_intern) AS dt_verechnung_intern,
 V01.belosart_fg
FROM kfl_production_dbp_view.v_verrechfall_kosten_2 AS V01
 INNER JOIN kfl_production_dbp_msi_view3.mv_kurs_2 AS V02 ON V01.wrg_id = V02.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V03 ON V01.mandant_id = V03.mandant_id
WHERE V01.soll_ist_fg = 1
 AND V01.belosart_fg = 0
 AND V01.verrechfall_status_id NOT IN ('BCC080', 'BCC085', 'BCC090');