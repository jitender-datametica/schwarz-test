CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_WOCHE_KJ_KL_2
--20.01.2016, srom0404, Feld kjwo_kl_vj lt. Mail von M.Sarbak (19.01.2016) ausgebaut
--20.01.2016, srom0404, Berechnung kj von substr auf geteilt 100 umgestellt
(
kjwo_kl
,kjwo_kl_dat_von
,kjwo_kl_dat_bis
,akt_kjwo_kl
,akt_kjwo_kl_komplett
,kj
,akt_kj
,akt_kj_komplett
)
AS
   SELECT
   kjwo_kl, kjwo_kl_dat_von, kjwo_kl_dat_bis, akt_kjwo_kl, akt_kjwo_kl_komplett, FLOOR(kjwo_kl / 100) AS kj, akt_kj, akt_kj_komplett
   FROM dbp_view.v_woche_kj_kl_2
   WHERE kjwo_kl > 200153;