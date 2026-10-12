CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_KONDITIONSGRUPPE_1
 (
 system_id
 ,mandant_id
 ,konditionsgruppe_id
 )
 AS
    SELECT
    7,
    mandant_id,
    konditionsgruppe_id
    FROM dbp_view.v_l_konditionsgruppe_1
    WHERE mandant_id = 1;