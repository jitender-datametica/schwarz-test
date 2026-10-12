CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_JAHR_KJ_2
(
kj
, akt_kj
, akt_kj_komplett
)
AS
   SELECT
   v01.kj, v01.akt_kj, v01.akt_kj_komplett

   FROM dbp_view.v_jahr_kj_2 v01;