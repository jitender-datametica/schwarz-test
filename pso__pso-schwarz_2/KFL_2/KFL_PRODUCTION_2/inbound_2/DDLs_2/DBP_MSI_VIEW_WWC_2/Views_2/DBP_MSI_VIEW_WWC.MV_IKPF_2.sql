CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_IKPF_2
-- 20140526 kkaiser - initiale Erstellung für # 586188
(
mandant_id
,inv_beleg_id
,gj
,zaehl_status_id
,diff_ausb_status_id
,dat_letzt_zaehl

)
AS
   SELECT
  v01.mandant_id, v01.inv_beleg_id, v01.gj, v01.zaehl_status_id, v01.diff_ausb_status_id, v01.dat_letzt_zaehl

   FROM dbp_view.v_inventur_2 v01 ;