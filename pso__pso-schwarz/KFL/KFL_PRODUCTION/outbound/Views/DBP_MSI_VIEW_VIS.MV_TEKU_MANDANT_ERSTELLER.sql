CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_teku_mandant_ersteller AS SELECT mandant_id,
 CAST(CASE
   WHEN mandant_id = 1
   THEN 'Hardy Schwab'
   WHEN mandant_id = 2
   THEN 'Jan Roubicek'
   WHEN mandant_id = 3
   THEN 'Beata Kisowska'
   WHEN mandant_id = 5
   THEN 'Zuzana Kucerova'
   WHEN mandant_id = 6
   THEN 'Ivan Blazevic'
   WHEN mandant_id = 7
   THEN 'Oana Lazaroiu'
   WHEN mandant_id = 8
   THEN 'Mariela Vasileva'
   ELSE 'Unbekannt'
   END AS STRING) AS ersteller_bez
FROM kfl_production_dbp_view.v_mandant;