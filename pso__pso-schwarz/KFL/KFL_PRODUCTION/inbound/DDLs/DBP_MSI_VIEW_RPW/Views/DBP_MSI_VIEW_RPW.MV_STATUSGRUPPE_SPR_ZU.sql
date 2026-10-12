CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_STATUSGRUPPE_SPR_ZU
 (
 mandant_id
 ,statusgruppe_id
 ,spr_id
 ,statusgruppe_bez
 ,system_id
 )
 AS
    SELECT
    mandant_id,
    statusgruppe_id,
    spr_id,
    statusgruppe_bez,
    7
    FROM dbp_view.v_statusgruppe_spr_zu
    WHERE mandant_id = 1
    AND spr_id = 22
 ;