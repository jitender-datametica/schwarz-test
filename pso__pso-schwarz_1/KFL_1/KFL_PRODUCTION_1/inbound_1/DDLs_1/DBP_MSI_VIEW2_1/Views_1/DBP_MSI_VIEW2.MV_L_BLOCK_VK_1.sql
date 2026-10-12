CREATE OR REPLACE VIEW dbp_msi_view2.mv_l_block_vk_1
--SPEC0125775
(
muki_block_vk_id
,muki_block_vk_kl_id
,muki_block_vk_kl_art_id
,muki_block_vk_bez
,muki_block_kz_vk_id
)
AS
SELECT
v01.art_id AS muki_block_vk_id,
/*Snowflake Adujustment*/
TO_VARCHAR(v01.kl_art_id, 'FM00000000') AS muki_block_vk_kl_id,
v01.kl_art_id,
v02.art_bez AS muki_block_vk_bez,
CASE
WHEN (v01.mutter_vk_id IS NULL) THEN 'W'
ELSE
'M' END
AS
muki_block_kz_vk_id
FROM dbp_view.v_art_1 v01
INNER JOIN dbp_view.v_art_spr_zu_1 v02
ON
v01.art_id=v02.art_id
AND
v01.mandant_id=v02.mandant_id
WHERE
v02.spr_id=22
AND
(
v01.mutter_vk_id IS NULL
OR
v01.mutter_vk_id = v01.art_id
)
AND
v01.dat_bis=TO_DATE('9999-12-31', 'YYYY-MM_1-DD')
AND v01.mandant_id = 1;
