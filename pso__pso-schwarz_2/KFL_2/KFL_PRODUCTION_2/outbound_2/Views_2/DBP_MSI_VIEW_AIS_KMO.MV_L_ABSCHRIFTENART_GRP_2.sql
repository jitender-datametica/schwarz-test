CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_abschriftenart_grp_2 (mandant_id, abschriftart_id,
abschriftart_gruppe_id) AS SELECT mandant_id,
 abschriftart_id,
  CASE
  WHEN MOD(CAST(abschriftart_id AS BIGNUMERIC), 2) = 0
  THEN abschriftart_id - 1
  ELSE abschriftart_id
  END AS abschriftart_gruppe_id
FROM kfl_production_dbp_view.v_l_abschriftart_2 AS V01
WHERE abschriftart_id BETWEEN 905 AND 994
 AND mandant_id <> 1
 AND (abschriftart_id <> 955 OR mandant_id <> 2)
UNION ALL
SELECT DISTINCT mandant_id,
  CASE
  WHEN lager_bewart_id IN ('Y01', 'Y02')
  THEN 210
  WHEN lager_bewart_id IN ('Y07', 'Y08')
  THEN 211
  WHEN lager_bewart_id IN ('Y11', 'Y12')
  THEN 240
  WHEN lager_bewart_id IN ('Y05', 'Y06')
  THEN 241
  WHEN lager_bewart_id IN ('Y35', 'Y36')
  THEN 242
  ELSE NULL
  END,
  CASE
  WHEN lager_bewart_id IN ('Y01', 'Y02')
  THEN 210
  WHEN lager_bewart_id IN ('Y07', 'Y08')
  THEN 211
  WHEN lager_bewart_id IN ('Y11', 'Y12')
  THEN 240
  WHEN lager_bewart_id IN ('Y05', 'Y06')
  THEN 241
  WHEN lager_bewart_id IN ('Y35', 'Y36')
  THEN 242
  ELSE NULL
  END
FROM kfl_production_dbp_view.v_l_lager_bewart_2
WHERE lager_bewart_id IN ('Y01', 'Y02', 'Y07', 'Y08', 'Y11', 'Y12', 'Y05', 'Y06', 'Y35', 'Y36')
 AND mandant_id <> 1;