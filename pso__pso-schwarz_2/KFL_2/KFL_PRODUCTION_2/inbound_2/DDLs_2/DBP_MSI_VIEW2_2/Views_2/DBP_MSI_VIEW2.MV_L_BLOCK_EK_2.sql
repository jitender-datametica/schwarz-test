CREATE OR REPLACE VIEW dbp_msi_view2.mv_l_block_ek_2
--SPEC0125775
(
muki_block_ek_kl_id
,muki_block_ek_kl_art_id
,muki_block_ek_id
,muki_block_ek_bez
,muki_block_kz_ek_id
)
AS
SELECT
/*Snowflake Adujustment*/
TO_VARCHAR(v03.kl_art_id, 'FM00000000') AS  muki_block_ek_kl_id,
v03.kl_art_id,
v01.art_id AS muki_block_ek_id,
v02.art_bez AS muki_block_ek_bez,
CASE
WHEN (v01.mutter_ek_id IS NULL) THEN
'W'
ELSE
'M' END
AS MuKi_block_kz_ek_id
FROM dbp_view.v_art_gp_zu_per_2 v01
INNER JOIN dbp_view.v_art_spr_zu_2 v02
ON
v01.art_id=v02.art_id
AND
v01.mandant_id=v02.mandant_id
INNER JOIN dbp_view.v_art_2 v03
ON
v02.art_id=v03.art_id
AND
v02.mandant_id=v03.mandant_id
WHERE
v02.spr_id=22
AND
COALESCE(v01.mutter_ek_id,v01.art_id) = v01.art_id
AND
v01.dat_bis=TO_DATE('9999-12-31', 'YYYY-MM_2-DD')
AND
v03.dat_bis=TO_DATE('9999-12-31', 'YYYY-MM_2-DD')
AND v03.mandant_id = 1;