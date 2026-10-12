CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_WOCHE_GJ_KL_2
--20.01.2016, srom0404, Feld gjwo_kl_vj lt. Mail von M.Sarbak (19.01.2016) ausgebaut
--20.01.2016, srom0404, Berechnung gj von substr auf geteilt 100 umgestellt
(
gjwo_kl
,gjwo_kl_dat_von
,gjwo_kl_dat_bis
,akt_gjwo_kl
,akt_gjwo_kl_komplett
,gj
,akt_gj
,akt_gj_komplett
)
AS
   SELECT
   gjwo_kl, gjwo_kl_dat_von, gjwo_kl_dat_bis, akt_gjwo_kl, akt_gjwo_kl_komplett, CAST(gjwo_kl / 100 AS INTEGER) AS gj, akt_gj, akt_gj_komplett
   FROM dbp_view.v_woche_gj_kl_2
   WHERE gjwo_kl > 200153;