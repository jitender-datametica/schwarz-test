CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_BEST_BELEG_STATUS
 (
 best_beleg_status_id
 ,mandant_id
 ,system_id
 )
 AS
    SELECT
    best_beleg_status_id,
    mandant_id,
    7
    FROM dbp_view.v_l_best_beleg_status
    WHERE mandant_id = 1;