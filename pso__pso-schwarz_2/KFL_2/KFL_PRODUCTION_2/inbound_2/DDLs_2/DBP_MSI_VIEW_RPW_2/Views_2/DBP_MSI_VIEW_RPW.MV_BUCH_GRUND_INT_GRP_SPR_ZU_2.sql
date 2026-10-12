CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BUCH_GRUND_INT_GRP_SPR_ZU_2
 (
 system_id
 ,mandant_id
 ,spr_id
 ,buch_grund_int_gruppe_id
 ,buch_grund_int_gruppe_bez
 )
 AS
    SELECT
    7,
    mandant_id,
    spr_id,
    buch_grund_int_gruppe_id,
    buch_grund_int_gruppe_bez
    FROM dbp_view.v_buch_grund_int_gruppe_spr_zu_2
    WHERE spr_id = 22
    AND mandant_id = 1;