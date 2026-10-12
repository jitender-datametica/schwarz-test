CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_BELEGKLASSE_GRUPPE
 (
 system_id
 ,mandant_id
 ,belegklasse_gruppe_id
 )
 AS
    SELECT
    7,
    mandant_id,
    belegklasse_gruppe_id
    FROM dbp_view.v_l_belegklasse_gruppe
    WHERE mandant_id = 1;