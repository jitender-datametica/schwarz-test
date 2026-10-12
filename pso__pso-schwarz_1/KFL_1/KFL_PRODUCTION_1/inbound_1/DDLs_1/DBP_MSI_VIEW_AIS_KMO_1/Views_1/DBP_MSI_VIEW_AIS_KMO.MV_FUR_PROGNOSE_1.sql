CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_FUR_PROGNOSE_1
-- #597789 Erweiterung Feld menge_prognose_max, Join auf art_wup_status_per_1 entfällt - sschuecke 25.08.2014
-- #619834 Erweiterung Filterung um dispomerkmal 12, listung_id = 1 und kdis = 0  - sschuecke 15.07.2015
-- #AP0003026 Erweiterung um neue Felder - sschuecke 16.08.2016
-- #AP0004411 Erweiterung  Filterung DM - sschuecke 27.04.2017
-- AP0055243_SPEC0076970_SCM - Add: menge_ofc - nwag2310 13.05.2020
-- AP0077909 - Add: metrics _kolli - nwag2310 25.11.2020
(
wup_id
,nb_id
,mandant_id
,art_id
,dat
,menge_prognose
,menge_prognose_kolli
,menge_prognose_bef
,menge_prognose_bef_kolli
,menge_prognose_max
,menge_prognose_max_kolli
,menge_ofc
,menge_ofc_kolli
,gp_id
,progn_groesser_fg
,menge_af_groesser_fg
)
AS
SELECT
v01.wup_id,
v01.nb_id,
v01.mandant_id,
v01.art_id,
v01.dat,
CAST(v01.menge_prognose AS DECIMAL(18,3)) AS menge_prognose,
CAST(v01.menge_prognose * coalesce(v04.umrech_faktor,1) AS DECIMAL(18,3)) AS menge_prognose_kolli,
CAST(v01.menge_prognose_bef AS DECIMAL(18,3)) AS menge_prognose_bef,
CAST(v01.menge_prognose_bef * coalesce(v04.umrech_faktor,1) AS DECIMAL(18,3)) AS menge_prognose_bef_kolli,
CAST(v01.menge_prognose_max AS DECIMAL(18,3)) AS menge_prognose_max,
CAST(v01.menge_prognose_max * coalesce(v04.umrech_faktor,1) AS DECIMAL(18,3)) AS menge_prognose_max_kolli,
CAST(v01.menge_ofc AS DECIMAL(18,3)) AS menge_ofc,
CAST(v01.menge_ofc * coalesce(v04.umrech_faktor,1) AS DECIMAL(18,3)) AS menge_ofc_kolli,
v02.gp_id,
v01.progn_groesser_fg,
v01.menge_af_groesser_fg
FROM dbp_view.v_fur_prognose_1 v01

INNER JOIN dbp_view.v_art_gp_nm_zu_per_1 v02
ON v01.art_id = v02.art_id
AND v01.wup_id =v02.wup_id
AND v01.mandant_id = v02.mandant_id
AND v01.dat BETWEEN v02.dat_von AND v02.dat_bis

INNER JOIN dbp_view.v_art_1 v021
ON v01.mandant_id=v021.mandant_id
AND v01.art_id=v021.art_id
AND v021.dat_bis='9999-12-31'

LEFT OUTER JOIN dbp_view.v_art_vorschlagswert_per_1 v03
ON v021.mandant_id = v03.mandant_id
AND v021.art_id = v03.art_id
AND v03.dat_bis = '9999-12-31'

LEFT OUTER JOIN dbp_view.v_art_umrechnung_faktor_per_1 v04
ON v03.mandant_id = v04.mandant_id
AND v03.art_id = v04.art_id
AND v03.ausg_menge_einh_id = v04.altnv_menge_einh_id
AND v04.dat_bis = '9999-12-31'

WHERE v01.mandant_id > 1
AND v01.dispomerkmal IN ('S2', '10', '12', '14')
AND v01.listung_id = 1
AND v01.kdis = 0;


