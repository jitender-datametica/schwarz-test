CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_WOCHE_KJ_KL
(
 kjwo_kl
,kjwo_kl_dat_von
,kjwo_kl_dat_bis
,akt_kjwo_kl
,akt_kjwo_kl_komplett
,akt_kj
,akt_kj_komplett
,kjwo
,kj
,akt_wo
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   SELECT
   v01.kjwo_kl,
   v01.kjwo_kl_dat_von,
   v01.kjwo_kl_dat_bis,
   v01.akt_kjwo_kl,
   v01.akt_kjwo_kl_komplett,
   v01.akt_kj,
   v01.akt_kj_komplett,
   v01.kjwo,
   CAST(FLOOR(v01.kjwo_kl /100) AS SMALLINT) AS kj,
   v01.akt_wo

   FROM dbp_view.v_woche_kj_kl  v01;