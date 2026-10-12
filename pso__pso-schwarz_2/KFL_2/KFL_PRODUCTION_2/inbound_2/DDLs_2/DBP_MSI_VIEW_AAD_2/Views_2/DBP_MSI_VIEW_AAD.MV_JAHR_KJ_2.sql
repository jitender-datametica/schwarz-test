CREATE OR REPLACE VIEW DBP_MSI_VIEW_AAD.MV_JAHR_KJ_2 As
--20.06.2023 twie: SPEC0200542 Lookup KJ
SELECT
     v01.kj
   , v01.akt_kj
   , v01.akt_kj_komplett
FROM dbp_view.v_jahr_kj_2 v01
WHERE kj>=2023;