CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_WOCHE_GJ_KL_1
(
 gjwo_kl
,gjwo_kl_dat_von
,gjwo_kl_dat_bis
,akt_gjwo_kl
,akt_gjwo_kl_komplett
,akt_gj
,gj
,akt_gj_komplett
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   SELECT
  gjwo_kl,
   gjwo_kl_dat_von,
   gjwo_kl_dat_bis,
   akt_gjwo_kl,
   akt_gjwo_kl_komplett,
   akt_gj,
   CAST (SUBSTRING(CAST(CAST(gjwo_kl AS INTEGER) AS CHAR(6)), 1, 4) AS SMALLINT) gj,
   akt_gj_komplett

   FROM dbp_view.v_woche_gj_kl_1
   WHERE gjwo_kl > 200153;