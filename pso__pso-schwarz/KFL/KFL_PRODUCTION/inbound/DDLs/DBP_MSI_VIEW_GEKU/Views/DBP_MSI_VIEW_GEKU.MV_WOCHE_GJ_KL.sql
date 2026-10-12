CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_WOCHE_GJ_KL
(
gjwo_kl
,gjwo_kl_dat_von
,gjwo_kl_dat_bis
,akt_gjwo_kl
,akt_gjwo_kl_komplett
,akt_gj
,gj
,akt_gj_komplett
)
AS
-- 01.02.2016 twie: kjwo_kl_vj entfernt

   SELECT
   gjwo_kl
   , gjwo_kl_dat_von
   , gjwo_kl_dat_bis
   , akt_gjwo_kl
   , akt_gjwo_kl_komplett
   , akt_gj
   , SUBSTRING(CAST(CAST(gjwo_kl AS INTEGER) AS CHAR(6)), 1, 4)
   , akt_gj_komplett
   FROM dbp_view.v_woche_gj_kl
   WHERE gjwo_kl > 200153;