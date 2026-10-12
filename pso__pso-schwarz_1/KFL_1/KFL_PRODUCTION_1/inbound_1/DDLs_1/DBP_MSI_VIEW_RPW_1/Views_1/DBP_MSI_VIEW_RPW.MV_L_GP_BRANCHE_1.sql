CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_GP_BRANCHE_1
 (
 mandant_id
 ,gp_branche_id
 ,system_id
 )
 AS
    SELECT
    mandant_id,
    gp_branche_id,
    7
    FROM dbp_view.v_l_gp_branche_1
    WHERE mandant_id = 1;