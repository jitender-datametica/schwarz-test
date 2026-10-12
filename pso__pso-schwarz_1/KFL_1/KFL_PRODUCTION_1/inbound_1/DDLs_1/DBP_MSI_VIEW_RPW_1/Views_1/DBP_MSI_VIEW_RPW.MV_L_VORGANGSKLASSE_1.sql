CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_VORGANGSKLASSE_1
 (
 system_id
 ,mandant_id
 ,vorgangsklasse_id
 )
 AS
    SELECT
    7,
    mandant_id,
    vorgangsklasse_id
    FROM dbp_view.v_l_vorgangsklasse_1
    WHERE mandant_id = 1
 ;