CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_TAG_WERBEWOCHE_ZU_2
(
	DAT,
	KJWO_MI,
	KJWO_DO
) AS
-- 01.09.2016 twie: Zuordnung Tag_2 zu Werbewochen (beginnt immer Do)
-- 01.07.2024 twie: SPEC0255958 Werbewoche mit Start Mittwoch ergänzt

   SELECT
   v01.dat
   , v02.kjwo AS kjwo_mi
   , v03.kjwo AS kjwo_do

   FROM dbp_view.v_tag_2 v01

   JOIN dbp_view.v_tag_2 v02
   ON v01.dat = v02.dat +2
   
   JOIN dbp_view.v_tag_2 v03
   ON v01.dat = v03.dat +3;