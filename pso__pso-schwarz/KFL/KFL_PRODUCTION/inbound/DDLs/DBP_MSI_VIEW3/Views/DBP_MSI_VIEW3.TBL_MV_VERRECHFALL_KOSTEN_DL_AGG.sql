CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_VERRECHFALL_KOSTEN_DL_AGG
(
mandant_id
,wrg_id
,wrg_typ_id
,verrechfall_id
,verrechfall_kostenart_id
,betrag_kosten_erster
,betrag_kosten_letzter
)
AS
   SELECT v01.mandant_id, v01.wrg_id, v04.wrg_typ_id, v01.verrechfall_id, v01.verrechfall_kostenart_id, MAX(v01.betrag_kosten_erster) AS betrag_kosten_erster, MAX(v02.betrag_kosten_letzter) AS betrag_kosten_letzter
   FROM (SELECT mandant_id, wrg_id, verrechfall_id, verrechfall_kostenart_id, SUM(betrag_kosten) OVER (PARTITION BY mandant_id, verrechfall_id, verrechfall_kostenart_id, dat_verrechnung_intern) AS betrag_kosten_erster
   FROM dbp_view.v_verrechfall_kosten t1
   WHERE --costqualifier <> Actual  (nur Target und Delta sollen berücksichtigt werden)
   soll_ist_fg = 1
   AND -- Eingeschränkt auf die Daten der Distributionslogistik
   belosart_fg =1
   --AND verrechfall_id = 23387922
   QUALIFY ROW_NUMBER() OVER (PARTITION BY mandant_id, verrechfall_id, verrechfall_kostenart_id ORDER BY dat_verrechnung_intern ,zeit_verrechnung_intern ) = 1
   ) v01
   INNER JOIN
   (SELECT mandant_id, verrechfall_id, verrechfall_kostenart_id, SUM(betrag_kosten) OVER (PARTITION BY mandant_id, verrechfall_id, verrechfall_kostenart_id, dat_verrechnung_intern) AS betrag_kosten_letzter
   FROM dbp_view.v_verrechfall_kosten t1
   --WHERE verrechfall_id = 23387922
   QUALIFY ROW_NUMBER() OVER (PARTITION BY mandant_id, verrechfall_id, verrechfall_kostenart_id ORDER BY dat_verrechnung_intern DESC NULLS LAST,zeit_verrechnung_intern DESC NULLS LAST) = 1
   ) v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.verrechfall_id = v02.verrechfall_id
   AND v01.verrechfall_kostenart_id = v02.verrechfall_kostenart_id
   INNER JOIN dbp_msi_view3.mv_kurs v03
   ON v01.wrg_id=v03.von_wrg_id
   INNER JOIN dbp_view.v_mandant_wrg_typ_zu v04
   ON v01.mandant_id = v04.mandant_id
   GROUP BY v01.mandant_id
   ,v01.wrg_id
   ,v04.wrg_typ_id
   ,v01.verrechfall_id
   ,v01.verrechfall_kostenart_id
   ;