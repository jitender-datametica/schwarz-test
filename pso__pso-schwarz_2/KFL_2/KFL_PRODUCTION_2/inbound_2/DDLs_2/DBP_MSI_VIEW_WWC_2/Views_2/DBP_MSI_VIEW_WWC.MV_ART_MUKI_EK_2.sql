CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ART_MUKI_EK_2
--AP0032822, SPEC0041631, 25.10.2018, mkub1811, neue View
(
art_id
,mandant_id
,muki_block_ek_id
,MuKi_kz_ek_id
,MuKi_block_kz_ek_id
)
AS
   SELECT
   art_id, mandant_id, COALESCE(mutter_ek_id,art_id) AS muki_block_ek_id, CASE
   WHEN(mutter_ek_id IS NULL) THEN 'W'
   WHEN(art_id=mutter_ek_id) THEN 'M'
   ELSE 'K'
   END AS MuKi_kz_ek_id, CASE
   WHEN(mutter_ek_id IS NULL) THEN 'W'
   ELSE 'M'
   END AS MuKi_block_kz_ek_id
   FROM dbp_view.v_art_gp_zu_per_2
   QUALIFY
   SUM(1) OVER (PARTITION BY  art_id, mandant_id ORDER BY dat_bis DESC NULLS LAST ROWS UNBOUNDED PRECEDING) = 1;