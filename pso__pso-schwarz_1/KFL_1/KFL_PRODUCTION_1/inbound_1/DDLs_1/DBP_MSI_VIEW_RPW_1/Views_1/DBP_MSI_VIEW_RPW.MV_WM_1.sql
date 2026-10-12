CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_WM_1
    (
        wm_id
      , wm_name
      , mandant_id
      , system_id
    )
    AS
       SELECT
        wm_id,
       wm_name,
       mandant_id,
       7 AS system_id
FROM dbp_view.v_wm_1
WHERE mandant_id = 1
 ;