CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_WOCHE_KJ_KL_1
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
-- 01.02.2016 twie: kjwo_kl_vj entfernt

   SELECT
   kjwo_kl
   , kjwo_kl_dat_von
   , kjwo_kl_dat_bis
   , akt_kjwo_kl
   , akt_kjwo_kl_komplett
   , SUBSTRING(CAST(CAST(kjwo_kl AS INTEGER) AS CHAR(6)), 1, 4)
   , akt_kj
   , akt_kj_komplett
   FROM dbp_view.v_woche_kj_kl_1
   WHERE kjwo_kl > 200153;