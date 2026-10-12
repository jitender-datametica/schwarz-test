CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_PERIOD_TYPE_1
(
  per_tp_id
 ,per_tp_desc
 ,per_tp_desc_EN
) AS
SELECT
  per_tp_id
 ,per_tp_desc
 ,per_tp_desc_EN
FROM P_LEW_MART_CM.V_LIL_PERIOD_TYPE_1 ;
