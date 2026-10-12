CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_VS_2
 (
   vs_id
   ,vs_bez
   ,vk_id
   ,mandant_id
   ,vsvt_bez
   ,system_id
 )
 AS
    SELECT
       vs_id,
    vs_bez,
    vk_id,
    mandant_id,
    vsvt_bez,
    7 AS system_id
    FROM dbp_view.v_vs_2
    WHERE mandant_id = 1
 ;