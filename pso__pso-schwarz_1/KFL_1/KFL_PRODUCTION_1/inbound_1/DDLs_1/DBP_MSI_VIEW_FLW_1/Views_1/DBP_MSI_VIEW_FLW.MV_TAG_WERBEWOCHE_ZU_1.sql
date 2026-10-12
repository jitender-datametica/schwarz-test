CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_TAG_WERBEWOCHE_ZU_1
-- 11.09.2015 twie: Zuordnung Tag_1 zu Werbewochen
-- 22.09.2016 twie: SPEC0014881 Werbewoche Donnerstag nicht der Woche_1 am letzten, sondern am ersten Tag_1 zuordnen (Versatz +3 statt -4)
-- 13.06.2019 naku: SPEC0057190 Werbewoche Mittwoch hinzugefuegt wegen CZ, analoge zu Werbewoche Donnerstag.
(
dat
,kjwo_so
,kjwo_do
,kjwo_mi

)
AS
   SELECT
   v01.dat, v02.kjwo AS kjwo_so, v03.kjwo AS kjwo_do, v04.kjwo AS kjwo_mi

   FROM dbp_view.v_tag_1 v01

   JOIN dbp_view.v_tag_1 v02
   ON v01.dat = v02.dat -1

   JOIN dbp_view.v_tag_1 v03
   ON v01.dat = v03.dat +3

   JOIN dbp_view.v_tag_1 v04
   ON v01.dat = v04.dat +2;