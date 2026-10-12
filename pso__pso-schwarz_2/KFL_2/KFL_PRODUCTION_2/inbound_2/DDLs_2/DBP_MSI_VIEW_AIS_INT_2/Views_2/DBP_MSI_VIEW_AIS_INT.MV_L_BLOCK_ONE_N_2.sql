CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_L_BLOCK_ONE_N_2(
	ONE_N_BLOCK_ID,
	ONE_N_BLOCK_KL_ID,
	ONE_N_BLOCK_KL_ART_ID,
	ONE_N_BLOCK_BEZ,
	ONE_N_KZ_BLOCK
) AS
-- SPEC0277081/ Neuanlage / prescherad 12.11.2024 
SELECT
v01.art_id AS one_n_block_id,
TO_VARCHAR(kl_art_id, 'FM00000000') AS  one_n_block_kl_id,
kl_art_id,
v02.art_bez AS one_n_block_bez,
CASE
WHEN (v01.mutter_1_n_id IS NULL) THEN '1:1'
ELSE '1:N' END
AS
one_n_kz_block
FROM dbp_view.v_art_2 v01
INNER JOIN dbp_view.v_art_spr_zu_2 v02
ON
v01.art_id=v02.art_id
AND
v01.mandant_id=v02.mandant_id
WHERE
v02.spr_id=22
AND
v01.dat_bis=TO_DATE('9999-12-31', 'YYYY-MM_2-DD')
AND v01.mandant_id = 1;