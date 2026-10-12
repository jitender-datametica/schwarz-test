CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_WM_2 (wm_id ,wm_name,mandant_id)
AS
   SELECT wm_id, wm_name, mandant_id from dbp_view.v_wm_2 where mandant_id=1;