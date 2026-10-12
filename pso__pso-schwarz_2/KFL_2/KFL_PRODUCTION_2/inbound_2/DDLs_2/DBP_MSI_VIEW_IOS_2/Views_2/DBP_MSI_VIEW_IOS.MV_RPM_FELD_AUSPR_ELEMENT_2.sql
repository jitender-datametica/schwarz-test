CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_RPM_FELD_AUSPR_ELEMENT_2
(
rpm_feld_id
,rpm_feld_bez
,rpm_hierarchie_id
,rpm_feld_auspr_bez
--,rpm_tab_id
,rpm_feld_auspr_id
,rpm_gewichtung
,dat_von
,dat_bis
)
AS
   SELECT
   v02.rpm_feld_id, v02.rpm_feld_bez, v01.rpm_hierarchie_id, v04.rpm_feld_auspr_bez, v03.rpm_feld_auspr_id, v01.rpm_gewichtung, v01.dat_von, v01.dat_bis
   FROM dbp_view.v_rpm_feld_zu_per_2 v01
   INNER JOIN dbp_view.v_l_rpm_feld_2 v02
   ON v01.rpm_feld_id = v02.rpm_feld_id
   INNER JOIN dbp_view.v_rpm_feld_auspr_zu_2 v03
   ON v02.rpm_feld_id = v03.rpm_feld_id
   AND v01.rpm_tab_id = v03.rpm_tab_id
   AND v01.rpm_feld_auspr_id = v03.rpm_feld_auspr_id
   INNER JOIN dbp_view.v_rpm_feld_auspr_spr_zu_2 v04
   ON v04.rpm_feld_id = v03.rpm_feld_id
   AND v04.rpm_tab_id = v03.rpm_tab_id
   AND v04.rpm_feld_auspr_id = v03.rpm_feld_auspr_id
   INNER JOIN dbp_view.v_l_rpm_tab_2 v05
   ON v05.rpm_tab_bez = '/RPM/ITEM_D'
   AND v05.rpm_tab_id = v01.rpm_tab_id

   WHERE
   v04.spr_id = 22
   and v01.dat_bis ='9999-12-31'
   -- AND v01.rpm_tab_id =2 zu tauschen
   ;