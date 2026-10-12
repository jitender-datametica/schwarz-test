CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_TAG_SUPERWEEKEND_ZU_1
-- 11.09.2015 twie: Zuordnung Tag_1 zum Super Weekend (Do-So). Die Tage Mo-Mi entfallen
(
dat
,kjwo_sw

)
AS
   SELECT
   v01.dat, v02.kjwo AS kjwo_sw

   FROM dbp_view.v_tag_1 v01

   JOIN dbp_view.v_tag_1 v02
   ON v01.dat = v02.dat +3

   WHERE v01.wtag_id IN (4,5,6,7);