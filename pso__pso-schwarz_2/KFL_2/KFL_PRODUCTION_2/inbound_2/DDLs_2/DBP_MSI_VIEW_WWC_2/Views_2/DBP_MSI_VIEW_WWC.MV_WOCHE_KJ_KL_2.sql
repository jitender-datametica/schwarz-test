CREATE OR REPLACE view DBP_MSI_VIEW_WWC.MV_WOCHE_KJ_KL_2 as
   SELECT
      v01.kjwo_kl, v01.kjwo_kl_dat_von, v01.kjwo_kl_dat_bis, v01.akt_kjwo_kl, v01.akt_kjwo_kl_komplett, v01.akt_kj, v01.akt_kj_komplett, v01.kjwo, CAST (TRUNC(v01.kjwo_kl / 100) AS SMALLINT) AS kj
   FROM dbp_view.v_woche_kj_kl_2  v01;