CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_L_TEILBEREICH_UK_2
-- 20180926 twie: SPEC0043226

(
kmr_teilbereich_uk_id
)
AS

   select kmr_teilbereich_uk_id
   from dbp_view.v_kmr_l_teilbereich_uk_2;