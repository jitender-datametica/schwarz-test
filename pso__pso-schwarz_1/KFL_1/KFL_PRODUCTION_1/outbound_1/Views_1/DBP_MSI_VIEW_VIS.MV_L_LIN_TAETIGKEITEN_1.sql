CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_lin_taetigkeiten_1 (mandant_id, ausbildung_id, ausbildung_bez
, lin_kursgruppe_id, sonderabzug, pauschalabzug) AS (((SELECT 1 AS mandant_id,
    'v_maks_basic' AS ausbildung_id,
    'MAKS KiE (Kaufmann/ -frau im Einzelhandel)' AS ausbildung_bez,
    '93' AS lin_kursgruppe_id,
    0 AS sonderabzug,
    8 AS pauschalabzug
   UNION DISTINCT
   SELECT 1 AS mandant_id,
    'v_maks_sales' AS ausbildung_id,
    'MAKS Verkäufer Frische' AS ausbildung_bez,
    '94' AS lin_kursgruppe_id,
    0 AS sonderabzug,
    8 AS pauschalabzug)
  UNION DISTINCT
  SELECT 1 AS mandant_id,
   'v_maks_sales_f' AS ausbildung_id,
   'MAKS Verkäufer Food' AS ausbildung_bez,
   '95' AS lin_kursgruppe_id,
   0 AS sonderabzug,
   8 AS pauschalabzug)
 UNION DISTINCT
 SELECT 1 AS mandant_id,
  'v_maks_abi' AS ausbildung_id,
  'MAKS Abiturientenprogramm' AS ausbildung_bez,
  '96' AS lin_kursgruppe_id,
  10 AS sonderabzug,
  0 AS pauschalabzug)
UNION DISTINCT
SELECT 1 AS mandant_id,
 'v_maks_3lquereinstieg' AS ausbildung_id,
 'MAKS 3LJQuereinstieg' AS ausbildung_bez,
 '97' AS lin_kursgruppe_id,
 10 AS sonderabzug,
 0 AS pauschalabzug;