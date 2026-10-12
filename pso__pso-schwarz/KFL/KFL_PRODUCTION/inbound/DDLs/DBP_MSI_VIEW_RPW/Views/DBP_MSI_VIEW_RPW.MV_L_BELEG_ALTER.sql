CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_BELEG_ALTER
 (
 mandant_id
 ,beleg_alter_id
 ,system_id
 )
 AS
    SELECT
    mandant_id,
    beleg_alter_id,
    7
    FROM dbp_view.v_l_beleg_alter
    WHERE mandant_id = 1;