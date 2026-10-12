CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_GF_2
 (
 gf_id
 , mandant_id
 , ek_fg
 , gf_name
 , system_id
 )
 AS

    SELECT
    gf_id,
    mandant_id,
    ek_fg,
    gf_name,
    7
FROM dbp_view.v_gf_2

WHERE mandant_id = 1
AND ek_fg = 0;