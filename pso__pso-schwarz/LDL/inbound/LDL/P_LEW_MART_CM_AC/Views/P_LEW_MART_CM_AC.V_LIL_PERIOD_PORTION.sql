CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_PERIOD_PORTION
(
   period_portion_id
  ,period_portion_desc
  ,period_portion_short_desc
  ,period_portion_desc_EN
  ,period_portion_short_desc_EN
)
AS
SELECT
   period_portion_id
  ,period_portion_desc
  ,period_portion_short_desc
  ,period_portion_desc_EN
  ,period_portion_short_desc_EN
FROM P_LEW_MART_CM.V_LIL_PERIOD_PORTION;