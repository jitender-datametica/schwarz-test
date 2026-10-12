CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_STATUSGRUPPE
 (
 mandant_id
 ,statusgruppe_id
 ,system_id
 )
 AS
    SELECT
    mandant_id,
    statusgruppe_id,
    7
    FROM dbp_view.v_l_statusgruppe
    WHERE mandant_id = 1
 ;