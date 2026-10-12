CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_WOCHE_GJ_KL_1
(
gjwo_kl
, gjwo_kl_dat_von
, gjwo_kl_dat_bis
, akt_gjwo_kl
, akt_gjwo_kl_komplett
, akt_gj
, gj
, akt_gj_komplett
)
AS
   SELECT
   gjwo_kl, gjwo_kl_dat_von, gjwo_kl_dat_bis, akt_gjwo_kl, akt_gjwo_kl_komplett, akt_gj, CAST(SUBSTRING(CAST(CAST(gjwo_kl AS INTEGER) AS CHAR(6)), 1, 4) AS SMALLINT), akt_gj_komplett

   FROM dbp_view.v_woche_gj_kl_1
   WHERE gjwo_kl > 200153
;