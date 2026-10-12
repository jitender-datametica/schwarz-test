CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_BELEGKLASSE
 (
 mandant_id
 ,belegklasse_id
 ,system_id
 )
 AS
    SELECT
    mandant_id,
    belegklasse_id,
    7
    FROM dbp_view.v_l_belegklasse
    WHERE mandant_id = 1;