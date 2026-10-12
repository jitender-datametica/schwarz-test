CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WM
-- AL 17.10.2011 neu erstellt
(
wm_id,
wm_name,
mandant_id
)
AS
   SELECT
   wm_id, wm_name, mandant_id
   FROM dbp_view.v_wm;