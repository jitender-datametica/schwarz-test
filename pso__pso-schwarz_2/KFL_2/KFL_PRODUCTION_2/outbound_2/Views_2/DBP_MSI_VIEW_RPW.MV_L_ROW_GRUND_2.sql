CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_row_grund_2 (mandant_id, row_grund_id, wbnk_planungs_kz,
system_id) AS SELECT mandant_id,
 row_grund_id,
  CASE
  WHEN row_grund_id IN ('117', '124', '125', '126', '129', '133', '135')
  THEN 'statistisch geplant'
  WHEN row_grund_id IN ('113', '127', '128', '131', '136', '143', '162')
  THEN 'ungeplant'
  WHEN row_grund_id IN ('146', '150', '152', '154', '163', '165', '174')
  THEN 'sonstige Erlöse'
  WHEN row_grund_id IN ('118', '130', '137', '141', '144', '145', '147', '151', '153', '164', '172', '173', '175')
  THEN 'Sachkosten'
  ELSE 'keine BNK'
  END AS wbnk_planungs_kz,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_row_grund_2
WHERE mandant_id = 1
UNION ALL
SELECT 1 AS mandant_id,
 '0' AS row_grund_id,
 ' ' AS wbnk_planungs_kz,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_row_grund_2
WHERE mandant_id = 1
GROUP BY mandant_id,
 row_grund_id,
 wbnk_planungs_kz,
 system_id;