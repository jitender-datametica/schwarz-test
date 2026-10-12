--fur_prognose_1
CREATE OR REPLACE VOLATILE TABLE _fur_pass AS (
WITH _artbew AS (
SELECT
dat,
art_id,
mandant_id,
nb_id,
wup_id,
SUM(menge) AS vk_menge,
SUM( CASE WHEN bewart_id = 1002 THEN menge ELSE NULL END) AS vk_menge_sa,
SUM( CASE WHEN bewart_id = 1001 THEN menge ELSE NULL END) AS vk_menge_af
FROM
DBP_DATA.artbew_1
GROUP BY
dat,
art_id,
mandant_id,
nb_id,
wup_id
)
SELECT
p_fur.mandant_id,
p_fur.wup_id,
p_fur.nb_id,
p_fur.art_id,
p_fur.dat,
CASE WHEN p_fur.dat <= CURRENT_DATE THEN p_fur.dat - 1 ELSE CURRENT_DATE END AS dat_prognoselauf,
t.kjwo,
t.kjmo,
p_fur.prognose_horizont AS prognose_horizont_fur,
p_fur.menge_prognose_aktion AS menge_prognose_sa_fur,
CASE WHEN p_fur.menge_prognose_aktion > 0 THEN 0 ELSE p_fur.menge_prognose END AS menge_prognose_af_fur,
CASE WHEN p_fur.menge_prognose_aktion > 0 THEN p_fur.menge_prognose_aktion ELSE p_fur.menge_prognose END AS menge_prognose_fur,
p_fur.menge_prognose_max AS menge_prognose_max_fur,
COALESCE(artbew.vk_menge, 0) AS vk_menge_fur,
COALESCE(artbew.vk_menge_sa, 0) AS vk_menge_sa_fur,
COALESCE(artbew.vk_menge_af, 0) AS vk_menge_af_fur,
ABS(menge_prognose_fur - vk_menge_fur) AS abs_diff_fur,
ABS(menge_prognose_sa_fur - vk_menge_sa_fur) AS abs_diff_sa_fur,
ABS(menge_prognose_af_fur - vk_menge_af_fur) AS abs_diff_af_fur
FROM DBP_DATA.fur_prognose_1 p_fur
JOIN DBP_DATA.tag_1 t ON p_fur.dat = t.dat
LEFT JOIN _artbew artbew_1
ON p_fur.mandant_id = artbew.mandant_id
   AND p_fur.wup_id = artbew.wup_id
   AND p_fur.dat = artbew.dat
   AND p_fur.art_id = artbew.art_id
WHERE p_fur.dat BETWEEN DATE(${DAT_KALK})-3 AND DATE(${DAT_KALK})
);

CREATE OR REPLACE TABLE DBP_ETL.fur_pass_agg_1 AS (
SELECT
fur_pass.mandant_id,
fur_pass.wup_id,
fur_pass.nb_id,
fur_pass.dat,
fur_pass.dat_prognoselauf,
fur_pass.kjwo,
fur_pass.kjmo,
MAX(fur_pass.prognose_horizont_fur) AS fur_prognose_horizont,
awg.wg_id,
SUM(fur_pass.menge_prognose_sa_fur) AS fur_menge_prognose_sa,
SUM(fur_pass.menge_prognose_af_fur) AS fur_menge_prognose_af,
SUM(fur_pass.menge_prognose_fur) AS fur_menge_prognose,
SUM(fur_pass.menge_prognose_max_fur) AS fur_menge_prognose_max,
SUM(fur_pass.vk_menge_fur) AS fur_vk_menge,
SUM(fur_pass.vk_menge_sa_fur) AS fur_vk_menge_sa,
SUM(fur_pass.vk_menge_af_fur) AS fur_vk_menge_af,
SUM(fur_pass.abs_diff_fur) AS fur_abs_diff,
SUM(fur_pass.abs_diff_sa_fur) AS fur_abs_diff_sa,
SUM(fur_pass.abs_diff_af_fur) AS fur_abs_diff_af
FROM _fur_pass fur_pass
JOIN (SELECT mandant_id, art_id, wg_id FROM DBP_DATA.art_wg_zu_per_1 WHERE arthiertyp_id = 2 AND dat_bis = '9999-12-31') awg 
ON fur_pass.mandant_id = awg.mandant_id
   AND fur_pass.art_id = awg.art_id
GROUP BY
fur_pass.mandant_id,
fur_pass.wup_id,
fur_pass.nb_id,
fur_pass.dat,
fur_pass.dat_prognoselauf,
fur_pass.kjwo,
fur_pass.kjmo,
awg.wg_id
);
