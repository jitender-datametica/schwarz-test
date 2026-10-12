CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_BLOCK_WB_BG_1
(
mandant_id
,muki_block_wb_id
,muki_block_wb_kl_id
,muki_block_wb_bez
,muki_block_kz_wb_id
)
AS
   SELECT v01.mandant_id, v01.art_id AS muki_block_wb_id, v01.kl_art_id AS muki_block_wb_kl_id, v02.art_bez AS muki_block_wb_bez, CASE WHEN (v01.mutter_wb_id IS NULL)
   THEN 'W'
   ELSE 'M'
   END AS muki_block_kz_wb_id

   FROM dbp_view.v_art_1 v01
   INNER JOIN dbp_view.v_art_spr_zu_1 v02
   ON v01.art_id = v02.art_id
   AND v01.mandant_id = v02.mandant_id
   WHERE v02.spr_id = 18
   AND (v01.mutter_wb_id IS NULL
   OR
   v01.mutter_wb_id = v01.art_id
   )
   AND v01.dat_bis = '9999-12-31';