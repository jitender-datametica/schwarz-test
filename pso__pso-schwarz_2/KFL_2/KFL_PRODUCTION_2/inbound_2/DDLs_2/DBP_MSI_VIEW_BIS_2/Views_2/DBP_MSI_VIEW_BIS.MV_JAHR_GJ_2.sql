CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_JAHR_GJ_2
         --11.01.2013SHoger initial
         (
         gj
         , akt_gj
         , akt_gj_komplett
         )
         AS
            SELECT
            gj,
            akt_gj,
            akt_gj_komplett

           FROM dbp_view.v_jahr_gj_2;