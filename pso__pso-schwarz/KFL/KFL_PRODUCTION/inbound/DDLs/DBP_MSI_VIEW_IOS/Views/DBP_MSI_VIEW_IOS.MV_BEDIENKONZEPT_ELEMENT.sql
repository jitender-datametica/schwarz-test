CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_BEDIENKONZEPT_ELEMENT
(
rpm_hierarchie_id
--,rpm_tab_id
,dat_von
,dat_bis
,bedienkonzept_id
,bedienkonzept_bez
,dat_bedienkonzept
,bedienkonzept_auspr_id
/*,bedienkonzept_auspr_bez*/
)

AS

   SELECT

   v01.rpm_hierarchie_id, v06.dat AS dat_von, v06.dat AS dat_bis, v01.bedienkonzept_id, v02.bedienkonzept_bez, v01.dat_bedienkonzept, v01.bedienkonzept_auspr_id
   /*,v03.bedienkonzept_auspr_bez*/
   FROM
   dbp_view.v_rpm_hier_bed_konzept_zu_per v01
   INNER JOIN dbp_view.v_l_bedienkonzept v02
   ON v01.bedienkonzept_id = v02.bedienkonzept_id
   INNER JOIN dbp_view.v_l_bedienkonzept_auspr v04
   ON v04.bedienkonzept_id = v02.bedienkonzept_id
   AND v01.bedienkonzept_auspr_id = v04.bedienkonzept_auspr_id
   INNER  JOIN dbp_view.v_l_rpm_tab v05
   ON v05.rpm_tab_bez = '/RPM/ITEM_D'
   AND v05.rpm_tab_id = v01.rpm_tab_id
   INNER JOIN dbp_view.v_tag v06
   ON v06.dat BETWEEN v01.dat_von AND v01.dat_bis
   AND v06.dat <= "CURRENT_DATE"

   /*WHERE  v03.spr_id = 22*/
   ;