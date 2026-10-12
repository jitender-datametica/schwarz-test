CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_BASELINE_SPR_ZU
(
baseline
, baseline_bez
)
AS
   SELECT
   baseline,
   CASE WHEN baseline = 4 THEN '4 Wochen'
   WHEN baseline = 3 THEN '12 Wochen'
   WHEN baseline = 2 THEN '26 Wochen'
   WHEN baseline = 1 THEN '52 Wochen'
   END  AS baseline_bez

   FROM dbp_view.v_shopper
   WHERE mandant_id = 1
   AND baseline IN (1,2,3,4)
   GROUP BY 1;