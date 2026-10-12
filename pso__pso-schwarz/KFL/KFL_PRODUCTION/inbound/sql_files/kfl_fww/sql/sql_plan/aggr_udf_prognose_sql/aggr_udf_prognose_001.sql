--aktion_list
CREATE OR REPLACE VOLATILE TABLE _aaw AS (
SELECT mandant_id, wup_id, art_id, aktion_id
FROM DBP_DATA.aktion_art_wup_zu 
WHERE (
(mandant_id <> 1 AND dat_preisaktiviert <> '1900-01-01' AND vk_aktion_brutto > 0)
OR 
(mandant_id = 1 AND dat_sperrung IS NULL)) 
);

CREATE OR REPLACE VOLATILE TABLE _a AS (
SELECT aktion_id, mandant_id, t.dat
FROM DBP_DATA.aktion 
JOIN DBP_DATA.tag t ON t.dat BETWEEN dat_von AND dat_bis
);

CREATE OR REPLACE VOLATILE TABLE _aktion_list AS (
SELECT DISTINCT
aaw.mandant_id,
aaw.wup_id,
aaw.art_id,
a.dat,
1 AS aktionslistung_fg
FROM _aaw aaw
JOIN _a a
ON a.aktion_id = aaw.aktion_id
   AND a.mandant_id = aaw.mandant_id
);

CREATE OR REPLACE VOLATILE TABLE _p_udf_aktion AS (
WITH _p_udf AS (  
SELECT
mandant_id,
wup_id,
nb_id,
art_id,
dat,
dat_prognoselauf,
prognose_horizont,
menge_prognose_sa,
menge_prognose_af,
menge_prognose_gesteuert
FROM
DBP_DATA.udf_prognose   
WHERE diagnose_id = '')
SELECT
p_udf.mandant_id,
p_udf.wup_id,
p_udf.nb_id,
p_udf.art_id,
p_udf.dat,
p_udf.dat_prognoselauf,
MAX(p_udf.prognose_horizont) AS prognose_horizont,
SUM(p_udf.menge_prognose_sa) AS menge_prognose_sa_udf,
SUM(p_udf.menge_prognose_af) AS menge_prognose_af_udf,
SUM(
CASE
WHEN p_udf.menge_prognose_sa IS NULL
AND p_udf.menge_prognose_af IS NULL THEN NULL
ELSE COALESCE(p_udf.menge_prognose_sa, 0) + COALESCE(p_udf.menge_prognose_af, 0)
END
) AS menge_prognose,
SUM(
CASE
WHEN aktion_list.aktionslistung_fg = 1 THEN p_udf.menge_prognose_gesteuert
ELSE NULL
END
) AS menge_prognose_sa_udf_gesteuert
,SUM(
CASE
WHEN aktion_list.aktionslistung_fg IS NULL THEN p_udf.menge_prognose_gesteuert
ELSE NULL
END
) AS menge_prognose_af_udf_gesteuert,
SUM(p_udf.menge_prognose_gesteuert) AS menge_prognose_gesteuert  
FROM _p_udf p_udf
LEFT JOIN _aktion_list aktion_list
    ON aktion_list.mandant_id = p_udf.mandant_id
       AND aktion_list.wup_id = p_udf.wup_id
       AND aktion_list.art_id = p_udf.art_id
       AND aktion_list.dat = p_udf.dat
WHERE p_udf.dat BETWEEN DATE(${DAT_KALK})-3 AND DATE(${DAT_KALK})
GROUP BY
p_udf.mandant_id,
p_udf.wup_id,
p_udf.nb_id,
p_udf.art_id,
p_udf.dat,
p_udf.dat_prognoselauf  
);  

CREATE OR REPLACE VOLATILE TABLE _udf_pass AS (
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
DBP_DATA.artbew
GROUP BY
dat,
art_id,
mandant_id,
nb_id,
wup_id
)
SELECT
p_udf_aktion.mandant_id,
p_udf_aktion.wup_id,
p_udf_aktion.nb_id,
p_udf_aktion.art_id,
p_udf_aktion.dat,
p_udf_aktion.dat_prognoselauf,
t.kjwo,
t.kjmo,
p_udf_aktion.prognose_horizont AS prognose_horizont_udf,
COALESCE(artbew.vk_menge, 0) AS vk_menge_udf,
COALESCE(artbew.vk_menge_sa, 0) AS vk_menge_sa_udf,
COALESCE(artbew.vk_menge_af, 0) AS vk_menge_af_udf,
p_udf_aktion.menge_prognose_sa_udf,
p_udf_aktion.menge_prognose_af_udf,
p_udf_aktion.menge_prognose AS menge_prognose_udf,
ABS(p_udf_aktion.menge_prognose - vk_menge_udf) AS abs_diff_udf,
ABS(p_udf_aktion.menge_prognose_sa_udf - vk_menge_sa_udf) AS abs_diff_sa_udf,
ABS(p_udf_aktion.menge_prognose_af_udf - vk_menge_af_udf) AS abs_diff_af_udf,
p_udf_aktion.menge_prognose_sa_udf_gesteuert,
p_udf_aktion.menge_prognose_af_udf_gesteuert,
p_udf_aktion.menge_prognose_gesteuert AS menge_prognose_udf_gesteuert,
ABS(p_udf_aktion.menge_prognose_gesteuert - vk_menge_udf) AS abs_diff_udf_gesteuert,
ABS(p_udf_aktion.menge_prognose_sa_udf_gesteuert - vk_menge_sa_udf) AS abs_diff_sa_udf_gesteuert,
ABS(p_udf_aktion.menge_prognose_af_udf_gesteuert - vk_menge_af_udf) AS abs_diff_af_udf_gesteuert
FROM _p_udf_aktion p_udf_aktion
LEFT JOIN _artbew artbew
ON p_udf_aktion.mandant_id = artbew.mandant_id
   AND p_udf_aktion.wup_id = artbew.wup_id
   AND p_udf_aktion.dat = artbew.dat
   AND p_udf_aktion.art_id = artbew.art_id
JOIN DBP_DATA.tag t ON p_udf_aktion.dat = t.dat
);

CREATE OR REPLACE TABLE DBP_ETL.udf_pass_agg AS (
SELECT
udf_pass.mandant_id,
udf_pass.wup_id,
udf_pass.nb_id,
udf_pass.dat,
udf_pass.dat_prognoselauf,
udf_pass.kjwo,
udf_pass.kjmo,
MAX(udf_pass.prognose_horizont_udf) AS udf_prognose_horizont,
awg.wg_id,
SUM(udf_pass.vk_menge_udf) AS udf_vk_menge,
SUM(udf_pass.vk_menge_sa_udf) AS udf_vk_menge_sa,
SUM(udf_pass.vk_menge_af_udf) AS udf_vk_menge_af,
SUM(udf_pass.menge_prognose_sa_udf) AS udf_menge_prognose_sa,
SUM(udf_pass.menge_prognose_af_udf) AS udf_menge_prognose_af,
SUM(udf_pass.menge_prognose_udf) AS udf_menge_prognose,
SUM(udf_pass.abs_diff_udf) AS udf_abs_diff,
SUM(udf_pass.abs_diff_sa_udf) AS udf_abs_diff_sa,
SUM(udf_pass.abs_diff_af_udf) AS udf_abs_diff_af,
SUM(udf_pass.menge_prognose_sa_udf_gesteuert) AS udf_gesteuert_menge_prognose_sa,
SUM(udf_pass.menge_prognose_af_udf_gesteuert) AS udf_gesteuert_menge_prognose_af,
SUM(udf_pass.menge_prognose_udf_gesteuert) AS udf_gesteuert_menge_prognose,
SUM(udf_pass.abs_diff_udf_gesteuert) AS udf_gesteuert_abs_diff,
SUM(udf_pass.abs_diff_sa_udf_gesteuert) AS udf_gesteuert_abs_diff_sa,
SUM(udf_pass.abs_diff_af_udf_gesteuert) AS udf_gesteuert_abs_diff_af
FROM _udf_pass udf_pass
JOIN (SELECT mandant_id, art_id, wg_id FROM DBP_DATA.art_wg_zu_per WHERE arthiertyp_id = 2 AND dat_bis = '9999-12-31') awg 
     ON udf_pass.mandant_id = awg.mandant_id
     AND udf_pass.art_id = awg.art_id
GROUP BY
udf_pass.mandant_id,
udf_pass.wup_id,
udf_pass.nb_id,
udf_pass.dat,
udf_pass.dat_prognoselauf,
udf_pass.kjwo,
udf_pass.kjmo,
awg.wg_id
);
