CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ZAHLART_SPR_ZU
                (
                mandant_id
                , zahlart_id
                , spr_id
                , zahlart_bez
                , system_id
                )
                AS
                   SELECT
                   mandant_id,
                   zahlart_id,
                   spr_id,
                   zahlart_bez,
                   7
FROM dbp_view.v_zahlart_spr_zu
WHERE mandant_id = 1
AND   spr_id = 22
 ;