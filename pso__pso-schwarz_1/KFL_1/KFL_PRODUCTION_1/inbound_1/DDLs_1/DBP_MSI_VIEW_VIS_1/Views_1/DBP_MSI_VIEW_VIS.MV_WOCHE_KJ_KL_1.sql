CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WOCHE_KJ_KL_1 AS
    -- zeit_1 : kl woche_1 (wochenwechsel zu kalenderjahrwechsel)
    -- 2014kw47 anpassung kjwo und akt_wo (performanceoptimierung, erweiterung quelltabelle)
    --18.04.2016, srom0404, feld kjwo_kl_vj lt. mail von m.sarbak (19.01.2016) ausgebaut
    -- 15.11.2021, snik1809 - updated kj, CAST-> FLOOR

   SELECT
      v01.kjwo_kl
     ,v01.kjwo_kl_dat_von
     ,v01.kjwo_kl_dat_bis
     ,v01.akt_kjwo_kl
     ,v01.akt_kjwo_kl_komplett
     ,v01.akt_kj
     ,v01.akt_kj_komplett
     ,FLOOR (v01.kjwo_kl / 100 ) AS kj
     ,v01.kjwo, v01.akt_wo

   FROM dbp_view.v_woche_kj_kl_1  v01;