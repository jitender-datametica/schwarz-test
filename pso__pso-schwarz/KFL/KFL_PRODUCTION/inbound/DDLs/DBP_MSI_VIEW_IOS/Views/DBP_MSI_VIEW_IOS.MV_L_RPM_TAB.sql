CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_RPM_TAB
(
rpm_tab_id
,rpm_tab_bez
)
AS
   SELECT
   v01.rpm_tab_id, v01.rpm_tab_bez
   FROM dbp_view.v_l_rpm_tab  v01;