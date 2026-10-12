CREATE OR REPLACE VIEW DBP_MSI_VIEW_AAD.MV_JAHR_GJ AS
--15.06.2023 snik: SPEC0200542 Lookup GJ
SELECT
     v01.gj
   , v01.akt_gj
   , v01.akt_gj_komplett
FROM dbp_view.v_jahr_gj v01
WHERE gj>=2023;