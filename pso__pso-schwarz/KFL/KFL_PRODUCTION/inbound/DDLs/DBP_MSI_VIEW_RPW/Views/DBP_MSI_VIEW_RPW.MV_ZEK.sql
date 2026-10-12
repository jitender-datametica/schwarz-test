CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ZEK
 (
 mandant_id
 ,zek_id
 ,wbl_id
 ,zek_name
 ,zek_abt_bez
 ,system_id
 )
 AS
    SELECT
    mandant_id,
    zek_id,
    wbl_id,
    zek_name,
    zek_abt_bez,
    7 AS system_id
    FROM dbp_view.v_zek
    WHERE mandant_id = 1;