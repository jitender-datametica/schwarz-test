CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_JAHR_KJ
(
kj
, akt_kj
, akt_kj_komplett
, kj_kurz
)
AS
   SELECT
   v01.kj, v01.akt_kj, v01.akt_kj_komplett, SUBSTR(CAST(v01.kj AS CHAR(4)),3,2) AS kj_kurz

   FROM dbp_view.v_jahr_kj v01;