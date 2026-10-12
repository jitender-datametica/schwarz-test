CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_WOCHE_MONAT_ZU_1
(
pjmo
,akt_mo
,pjwo
)
AS

   SELECT
   v01.kjmo AS pjmo, v01.akt_mo, v01.pjwo AS pjwo
   FROM dbp_view.v_tag_1 v01

   GROUP BY
   v01.kjmo
   ,v01.akt_mo
   ,v01.pjwo
   HAVING  COUNT(v01.dat) > 3;