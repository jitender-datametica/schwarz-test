CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_L_BLOCK_WB
(
mandant_id
,muki_block_wb_id
,muki_block_wb_kl_id_lang
,muki_block_wb_kl_id
,muki_block_wb_bez
,muki_block_kz_wb_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
   v01.mandant_id, 
   v01.art_id AS muki_block_wb_id, 
   LPAD (v01.kl_art_id, 8,0) AS muki_block_wb_kl_id_lang,
   v01.kl_art_id AS muki_block_wb_kl_id, 
   v02.art_bez AS muki_block_wb_bez, 
   CASE WHEN (v01.mutter_wb_id IS NULL) THEN 'W' ELSE 'M' END AS muki_block_kz_wb_id
   FROM dbp_view.v_art v01
   INNER JOIN dbp_view.v_art_spr_zu v02
   ON v01.art_id=v02.art_id
   AND v01.mandant_id=v02.mandant_id
   WHERE v02.spr_id=22
   AND
   (
   v01.mutter_wb_id IS NULL OR v01.mutter_wb_id = v01.art_id
   )
   AND
   v01.dat_bis='9999-12-31';