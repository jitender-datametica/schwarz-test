CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_VTG_QUOTE_CROSS_1 as
   -- LOOKUP/TRANSACTION Tabelle fuer Pflege der Verteilquoten
   -- 20160118 ssch0611 : Anpassung Cross Join (akt_kj=0 >> akt_wo between -10 and 0)

   SELECT    -- Dummy_1 Eintraege für einzupflegende Quoten pro Verteilgebiet und Woche_1 (11 Wochen)
   v01.verteilgebiet_uid, v02.kjwo, CAST(NULL AS DECIMAL(18,2)) AS verteil_quote
   FROM dbp_view.v_geku_verteilgebiet_1 v01
   CROSS JOIN (
   SELECT DISTINCT kjwo
   FROM dbp_view.v_tag_1
   WHERE akt_wo BETWEEN -10 AND 0
   ) v02
   WHERE CONTAINS( v01.verteilgebiet_bez, 'TIP')
   AND (v01.verteilgebiet_uid, v02.kjwo) NOT IN (
   SELECT verteilgebiet_uid, kjwo
   FROM dbp_msi_view_vis.ts_geku_verteilgebiet_quote_1
   )

   UNION ALL   -- Alle schon eingepflegten Quoten
   SELECT
   verteilgebiet_uid, kjwo, verteil_quote
   FROM dbp_msi_view_vis.ts_geku_verteilgebiet_quote_1
   ;