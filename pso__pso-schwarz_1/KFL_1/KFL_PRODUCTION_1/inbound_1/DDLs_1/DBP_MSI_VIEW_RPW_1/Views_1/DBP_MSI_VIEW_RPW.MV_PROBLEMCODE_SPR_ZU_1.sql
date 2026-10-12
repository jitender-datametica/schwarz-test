CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_PROBLEMCODE_SPR_ZU_1
 (
 mandant_id
 ,problemcode_id
 ,spr_id
 ,problemcode_bez
 ,problemcode_bez_kurz
 ,problemcode_bez_lang
 ,system_id
 )
 AS
    SELECT
    mandant_id,
    problemcode_id,
    spr_id,
    problemcode_bez,
    problemcode_bez_kurz,
    problemcode_bez_lang,
    7
    FROM dbp_view.v_problemcode_spr_zu_1
    WHERE mandant_id = 1
    AND spr_id = 22
 ;