CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_KONDITIONSART_SPR_ZU
 (
 system_id
 ,mandant_id
 ,konditionsart_id
 ,spr_id
 ,konditionsart_bez
 )
 AS
    SELECT
    7,
    mandant_id,
    konditionsart_id,
    spr_id,
    konditionsart_bez
    FROM dbp_view.v_konditionsart_spr_zu
    WHERE mandant_id = 1
    AND  spr_id = 22;