CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BUCH_GRUND_EXT_SPR_ZU
 (
 system_id
 ,mandant_id
 ,buch_grund_ext_id
 ,spr_id
 ,buch_grund_ext_bez
 )
 AS
    --INC INC5341249 Hard-coded system_id ersetzen durch Spaltenbezug
    SELECT
    system_id,
    mandant_id,
    buch_grund_ext_id,
    spr_id,
    buch_grund_ext_bez
    FROM dbp_view.v_buch_grund_ext_spr_zu
    WHERE mandant_id = 1
    AND spr_id = 22;