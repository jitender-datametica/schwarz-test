CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_ART_MUKI_EK_1
(
art_id
,mandant_id
,muki_block_ek_id
,MuKi_kz_ek_id
,MuKi_block_kz_ek_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
   art_id, 
   mandant_id, 
   COALESCE(mutter_ek_id,art_id) AS muki_block_ek_id, 
   CASE
   WHEN(mutter_ek_id IS NULL) THEN 'W'
   WHEN(art_id=mutter_ek_id) THEN 'M'
   ELSE 'K'
   END AS MuKi_kz_ek_id, CASE
   WHEN(mutter_ek_id IS NULL) THEN 'W'
   ELSE 'M'
   END AS MuKi_block_kz_ek_id
   FROM dbp_view.v_art_gp_zu_per_1
   QUALIFY
   SUM(1) OVER (PARTITION BY  art_id, mandant_id ORDER BY dat_bis DESC NULLS LAST ROWS UNBOUNDED PRECEDING) = 1;