CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_wbnk_gruppe_zu_1 (system_id, mandant_id, wbnkart_id,
row_grund_id, konditionsart_id, wbnk_gruppe_id, wbnk_gruppe_bez, wbnk_bez) AS SELECT 7 AS system_id,
 V01.mandant_id,
 V01.wbnk_id AS wbnkart_id,
  CASE
  WHEN SUBSTR(V01.wbnk_id, 1, 2) <> 'YN'
  THEN V01.wbnk_id
  ELSE '0'
  END AS konditionsart_id,
  CASE
  WHEN SUBSTR(V01.wbnk_id, 1, 2) = 'YN'
  THEN V01.wbnk_id
  ELSE '0'
  END AS row_grund_id,
 V01.wbnk_gruppe_id,
 V02.wbnk_gruppe_bez,
 V03.wbnk_bez
FROM kfl_production_dbp_view.v_wbnk_gruppe_zu_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wbnk_gruppe_spr_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wbnk_gruppe_id
     = V02.wbnk_gruppe_id AND V02.spr_id = 22
 INNER JOIN kfl_production_dbp_view.v_wbnk_spr_zu_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.wbnk_id = V03.wbnk_id
     AND V03.spr_id = 22
WHERE V01.mandant_id = 1;