CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_TAG_UNENDLICH_2
-- 20140729 - kkaiser - #0577, 'MSI  - IOS - Tag_2 mit 9999-12-31'
(
dat
,kj
,akt_kj
)
AS
   SELECT
   v01.dat,
   v01.kj,
   v01.akt_kj

   FROM dbp_view.v_tag_2 v01

   WHERE v01.akt_kj > -3


   UNION ALL

   (Select distinct
   CAST( '9999-12-31' AS VARCHAR ) AS dat,
   CAST( 9999 AS SMALLINT) AS kj,
   CAST( 9999 AS SMALLINT) AS akt_kj
   from dbp_view.v_tag_2)

;