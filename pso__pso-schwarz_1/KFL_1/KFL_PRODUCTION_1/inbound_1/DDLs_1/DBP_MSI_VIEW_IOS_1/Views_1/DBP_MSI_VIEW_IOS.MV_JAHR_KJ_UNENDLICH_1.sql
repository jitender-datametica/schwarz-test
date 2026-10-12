CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_JAHR_KJ_UNENDLICH_1
--kkaiser 20140729 '0577, MSI  - IOS - KJ mit 9999'
(
kj
,akt_kj
)
AS

   SELECT
   kj, akt_kj

   FROM dbp_view.v_jahr_kj_1
   WHERE akt_kj > -3

   UNION ALL

   (Select distinct
   CAST( 9999 as SMALLINT) AS kj,
   CAST( 9999 as SMALLINT) AS akt_kj
   from dbp_view.v_jahr_kj_1)

;