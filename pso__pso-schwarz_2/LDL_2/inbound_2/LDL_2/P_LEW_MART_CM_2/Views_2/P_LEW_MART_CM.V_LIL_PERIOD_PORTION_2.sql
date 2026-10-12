CREATE OR REPLACE VIEW P_LEW_MART_CM.V_LIL_PERIOD_PORTION_2
(
   period_portion_id
  ,period_portion_desc
  ,period_portion_short_desc
  ,period_portion_desc_EN
  ,period_portion_short_desc_EN
)
AS
SELECT
   period_portion_id AS period_portion_id
  ,period_portion_descr AS period_portion_desc
  ,period_portion_short_descr AS period_portion_short_desc
  ,period_portion_descr_EN AS period_portion_desc_EN
  ,period_portion_short_descr_EN AS period_portion_short_desc_EN
FROM P_LEW_CORE_AC.V_REF_LIL_PERIOD_PORTION_2;