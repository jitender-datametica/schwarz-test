CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_GJ as
         -- 2008-12-15
         -- FAKTVIEW ZEIT (GJ)
         -- Dynamisch + Ergänzungen

         SELECT
         gj,
         akt_gj,
         akt_gj_komplett,
         TO_DATE( CAST(gj AS CHAR(4)) || '03', 'YYYYMM')  dat_gj_beginn,
         ADD_MONTHS(dat_gj_beginn, 12) -1  dat_gj_ende
        FROM dbp_view.v_jahr_gj
        WHERE akt_gj BETWEEN -5 AND 1;