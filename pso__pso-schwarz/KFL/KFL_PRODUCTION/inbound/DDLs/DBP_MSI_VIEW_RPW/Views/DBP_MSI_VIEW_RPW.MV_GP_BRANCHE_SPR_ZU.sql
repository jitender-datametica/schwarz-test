CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_GP_BRANCHE_SPR_ZU
 (
 mandant_id
 ,gp_branche_id
 ,spr_id
 ,gp_branche_bez
 ,system_id
 )
 AS
    SELECT
    mandant_id,
    gp_branche_id,
    spr_id,
    gp_branche_bez,
    7
    FROM dbp_view.v_gp_branche_spr_zu
    WHERE mandant_id = 1
    AND spr_id = 22;