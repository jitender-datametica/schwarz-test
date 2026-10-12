CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_RECH_BELEG_STATUS_SPR_ZU_1
 (
 system_id
 ,mandant_id
 ,rech_beleg_status_id
 ,spr_id
 ,rech_beleg_status_bez
 )
 AS
    SELECT
    7,
    mandant_id,
    rech_beleg_status_id,
    spr_id,
    rech_beleg_status_bez
    FROM dbp_view.v_rech_beleg_status_spr_zu_1
    WHERE spr_id =22
    AND mandant_id = 1
 ;