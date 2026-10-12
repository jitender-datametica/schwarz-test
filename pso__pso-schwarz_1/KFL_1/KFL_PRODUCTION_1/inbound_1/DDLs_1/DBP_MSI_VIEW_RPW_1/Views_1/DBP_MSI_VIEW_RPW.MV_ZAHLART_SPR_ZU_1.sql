CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ZAHLART_SPR_ZU_1
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
FROM dbp_view.v_zahlart_spr_zu_1
WHERE mandant_id = 1
AND   spr_id = 22
 ;