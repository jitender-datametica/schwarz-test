CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_verrechfall_kosten_dl_agg (mandant_id, wrg_id, wrg_typ_id,
verrechfall_id, verrechfall_kostenart_id, betrag_kosten_erster, betrag_kosten_letzter) AS SELECT v01.mandant_id,
 v01.wrg_id,
 V04.wrg_typ_id,
 v01.verrechfall_id,
 v01.verrechfall_kostenart_id,
 MAX(v01.betrag_kosten_erster) AS betrag_kosten_erster,
 MAX(v02.betrag_kosten_letzter) AS betrag_kosten_letzter
FROM (SELECT mandant_id,
   wrg_id,
   verrechfall_id,
   verrechfall_kostenart_id,
   SUM(betrag_kosten) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(verrechfall_id AS STRING),
      verrechfall_kostenart_id, dat_verrechnung_intern RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   betrag_kosten_erster
  FROM kfl_production_dbp_view.v_verrechfall_kosten AS T1
  WHERE soll_ist_fg = 1
   AND belosart_fg = 1
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(verrechfall_id AS STRING),
        verrechfall_kostenart_id ORDER BY dat_verrechnung_intern IS NULL, dat_verrechnung_intern,
        zeit_verrechnung_intern IS NULL, zeit_verrechnung_intern)) = 1) AS v01
 INNER JOIN (SELECT mandant_id,
   verrechfall_id,
   verrechfall_kostenart_id,
   SUM(betrag_kosten) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(verrechfall_id AS STRING),
      verrechfall_kostenart_id, dat_verrechnung_intern RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   betrag_kosten_letzter
  FROM kfl_production_dbp_view.v_verrechfall_kosten AS T1
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(verrechfall_id AS STRING),
        verrechfall_kostenart_id ORDER BY dat_verrechnung_intern IS NULL, dat_verrechnung_intern,
        zeit_verrechnung_intern IS NULL, zeit_verrechnung_intern)) = 1) AS v02 ON v01.mandant_id = v02.mandant_id AND
    v01.verrechfall_id = v02.verrechfall_id AND v01.verrechfall_kostenart_id = v02.verrechfall_kostenart_id
 INNER JOIN kfl_production_dbp_msi_view3.mv_kurs AS V03 ON v01.wrg_id = V03.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V04 ON v01.mandant_id = V04.mandant_id
GROUP BY v01.mandant_id,
 v01.wrg_id,
 V04.wrg_typ_id,
 v01.verrechfall_id,
 v01.verrechfall_kostenart_id;