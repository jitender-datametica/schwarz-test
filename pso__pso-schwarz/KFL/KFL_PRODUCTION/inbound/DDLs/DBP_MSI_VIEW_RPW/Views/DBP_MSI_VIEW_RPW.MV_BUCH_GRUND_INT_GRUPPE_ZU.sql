CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BUCH_GRUND_INT_GRUPPE_ZU
 (
 system_id
 ,mandant_id
 ,buch_grund_int_id
 ,buch_grund_int_gruppe_id
 )
 AS
    SELECT
    7,
    mandant_id,
    buch_grund_int_id,
    buch_grund_int_gruppe_id
    FROM dbp_view.v_buch_grund_int_gruppe_zu
    WHERE mandant_id = 1;