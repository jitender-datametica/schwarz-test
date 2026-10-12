CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_WOCHE_GJ_KL_2
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
   SELECT
   v01.gjwo_kl,
   v01.gjwo_kl_dat_von,
   v01.gjwo_kl_dat_bis,
   v01.akt_gjwo_kl,
   v01.akt_gjwo_kl_komplett,
   v01.akt_gj,
   CAST (SUBSTRING(CAST(CAST(v01.gjwo_kl AS INTEGER) AS CHAR(6)), 1, 4) AS SMALLINT) gj,
   v01.akt_gj_komplett
   FROM dbp_view.v_woche_gj_kl_2 v01

   WHERE v01.gjwo_kl > 200153;