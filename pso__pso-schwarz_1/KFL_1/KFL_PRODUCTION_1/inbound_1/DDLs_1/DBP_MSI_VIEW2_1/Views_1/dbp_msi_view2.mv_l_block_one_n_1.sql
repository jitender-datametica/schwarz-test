CREATE OR REPLACE VIEW dbp_msi_view2.mv_l_block_one_n_1
--SPEC0125775
--SPEC0126619 - Anpassung kz_block 
(
one_n_block_id
,one_n_block_kl_id
,one_n_block_kl_art_id
,one_n_block_bez
,one_n_kz_block
)
AS
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
FROM dbp_view.v_art_1 v01
INNER JOIN dbp_view.v_art_spr_zu_1 v02
ON
v01.art_id=v02.art_id
AND
v01.mandant_id=v02.mandant_id
WHERE
v02.spr_id=22
AND
v01.dat_bis=TO_DATE('9999-12-31', 'YYYY-MM_1-DD')
AND v01.mandant_id = 1;