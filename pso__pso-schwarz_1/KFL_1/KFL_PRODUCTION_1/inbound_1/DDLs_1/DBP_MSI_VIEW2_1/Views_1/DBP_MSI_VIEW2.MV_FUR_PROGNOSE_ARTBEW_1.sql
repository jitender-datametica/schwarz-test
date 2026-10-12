CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_FUR_PROGNOSE_ARTBEW_1
-- #619834 Erweiterung Berechnung Wert diff_menge_af_prognose - sschuecke 14.07.2015
-- Anpassung Berechnung Diff_menge_af_prognose - sschuecke 31.08.2015
-- #AP0002450 erweiterung um neue Felder - sschuecke 09.08.2016
--#AP0004411 Erweiterung Filterung DM - sschuecke 27.04.2017
--#INC1293744 Anpassung Berechnung diff_menge_af_prognose - sschuecke 09.11.2017
--#NSR0557072 Include KJMO/KJWO/KJ to trigger partition elimination in report SQL - nwagner 20.02.2019
-- AP0055243_SPEC0076970_SCM - Add: menge_ofc - nwag2310 13.05.2020
-- AP0077909 - Add: metrics _kolli - nwag2310 25.11.2020
-- AP0079026 SPEC0122828 Anpassung art_gp_zu_per_1 -> art_gp_nm_zu_per_1 - richternic 16.08.2021
(
wup_id
,nb_id
,mandant_id
,art_id
,loesch_id
,kl_art_id
,dat
,kjwo
,kjmo
,kj
,menge_prognose
,menge_prognose_kolli
,menge_prognose_bef
,menge_prognose_bef_kolli
,menge_prognose_max
,menge_prognose_max_kolli
,menge_ofc
,menge_ofc_kolli
,vk_menge
,vk_menge_af
,vk_menge_sa
,diff_menge_af_prognose
,gp_id
,progn_groesser_fg
,menge_af_groesser_fg
)
AS
SELECT
dt1.wup_id,
dt1.nb_id,
dt1.mandant_id,
dt1.art_id,
dt1.loesch_id,
dt1.kl_art_id,
dt1.dat,
dt1.kjwo,
dt1.kjmo,
dt1.kj,
MIN(dt1.menge_prognose) AS menge_prognose,
MIN(dt1.menge_prognose_kolli) AS menge_prognose_kolli,
MIN(dt1.menge_prognose_bef) AS menge_prognose_bef,
MIN(dt1.menge_prognose_bef_kolli) AS menge_prognose_bef_kolli,
MIN(dt1.menge_prognose_max) AS menge_prognose_max,
MIN(dt1.menge_prognose_max_kolli) AS menge_prognose_max_kolli,
MIN(dt1.menge_ofc) AS menge_ofc,
MIN(dt1.menge_ofc_kolli) AS menge_ofc_kolli,
SUM(dt1.menge) AS menge,
SUM(vk_menge_af) AS vk_menge_af,
SUM(vk_menge_sa) AS vk_menge_sa,
CASE
WHEN SUM(vk_menge_sa) IS NOT NULL THEN NULL
ELSE ABS(ZEROIFNULL(SUM(vk_menge_af)) - MIN(menge_prognose)) END AS diff_menge_af_prognose,
dt1.gp_id,
dt1.progn_groesser_fg,
dt1.menge_af_groesser_fg
FROM

(SELECT
v01.wup_id,
v01.nb_id,
v01.mandant_id,
v01.art_id,
v04.loesch_id,
v04.kl_art_id,
v02.kjwo,
v02.kjmo,
v02.kj,
v02.dat,
CAST(v01.menge_prognose AS DECIMAL(18,3)) AS menge_prognose,
CAST(v01.menge_prognose * coalesce(v07.umrech_faktor,1) AS DECIMAL(18,3)) AS menge_prognose_kolli,
CAST(v01.menge_prognose_bef AS DECIMAL(18,3)) AS menge_prognose_bef,
CAST(v01.menge_prognose_bef * coalesce(v07.umrech_faktor,1) AS DECIMAL(18,3)) AS menge_prognose_bef_kolli,
CAST(v01.menge_prognose_max AS DECIMAL(18,3)) AS menge_prognose_max,
CAST(v01.menge_prognose_max * coalesce(v07.umrech_faktor,1) AS DECIMAL(18,3)) AS menge_prognose_max_kolli,
CAST(v01.menge_ofc AS DECIMAL(18,3)) AS menge_ofc,
CAST(v01.menge_ofc * coalesce(v07.umrech_faktor,1) AS DECIMAL(18,3)) AS menge_ofc_kolli,
CAST(v05.menge AS NUMBER(38,5)) AS menge,
CASE
WHEN v05.bewart_id = 1001 THEN CAST(v05.menge AS NUMBER(38,5)) END vk_menge_af,
CASE
WHEN v05.bewart_id = 1002 THEN CAST(v05.menge AS NUMBER(38,5)) END vk_menge_sa,
-- Berechnung diff_menge_af_prognose
CASE
WHEN vk_menge_sa IS NOT NULL THEN NULL
ELSE ABS(ZEROIFNULL(vk_menge_af) - menge_prognose) END AS diff_menge_af_prognose,
v03.gp_id,
v01.progn_groesser_fg,
v01.menge_af_groesser_fg
FROM dbp_view.v_fur_prognose_1 v01

-- Tag_1-Join aus Performancegründen
INNER JOIN dbp_view.v_tag_1 v02
ON v02.dat = v01.dat

INNER JOIN dbp_view.v_art_gp_nm_zu_per_1 v03
ON v01.art_id = v03.art_id
AND v01.mandant_id = v03.mandant_id
and v01.wup_id = v03.wup_id
AND v02.dat BETWEEN v03.dat_von AND v03.dat_bis

-- Artikel_1-Join aus Performancegründen
INNER JOIN dbp_view.v_art_1 v04
ON (v01.art_id = v04.art_id
AND v01.mandant_id = v04.mandant_id)

LEFT JOIN dbp_view.v_artbew_1 v05
ON v01.art_id = v05.art_id
AND v01.mandant_id = v05.mandant_id
AND v01.wup_id = v05.wup_id
AND v01.nb_id = v05.nb_id
AND v02.dat = v05.dat

INNER JOIN dbp_view.v_art_vorschlagswert_per_1 v06
ON v04.mandant_id = v06.mandant_id
AND v04.art_id = v06.art_id
AND v06.dat_bis = to_date('9999-12-31', 'YYYY-MM_1-DD') 

LEFT OUTER JOIN dbp_view.v_art_umrechnung_faktor_per_1 v07
ON v03.mandant_id = v07.mandant_id
AND v03.art_id = v07.art_id
AND v06.ausg_menge_einh_id = v07.altnv_menge_einh_id
AND v07.dat_bis = to_date('9999-12-31', 'YYYY-MM_1-DD') 

WHERE v01.mandant_id = 1
AND v01.dispomerkmal IN ('10', '11', '12', '14')
AND v01.listung_id = 1
AND v01.kdis = 0
) dt1

GROUP BY
dt1.wup_id
,dt1.nb_id
,dt1.mandant_id
,dt1.art_id
,dt1.loesch_id
,dt1.kl_art_id
,dt1.dat
,dt1.kjwo
,dt1.kjmo
,dt1.kj
,dt1.gp_id
,dt1.progn_groesser_fg
,dt1.menge_af_groesser_fg;


