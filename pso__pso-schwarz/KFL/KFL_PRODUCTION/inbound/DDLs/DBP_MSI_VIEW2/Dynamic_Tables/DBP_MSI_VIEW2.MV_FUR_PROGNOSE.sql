CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_FUR_PROGNOSE
(
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	ART_ID,
	DAT,
	MENGE_PROGNOSE,
	MENGE_PROGNOSE_KOLLI,
	MENGE_PROGNOSE_BEF,
	MENGE_PROGNOSE_BEF_KOLLI,
	MENGE_PROGNOSE_MAX,
	MENGE_PROGNOSE_MAX_KOLLI,
	MENGE_OFC,
	MENGE_OFC_KOLLI,
	GP_ID,
	PROGN_GROESSER_FG,
	MENGE_AF_GROESSER_FG
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.wup_id,
v01.nb_id,
v01.mandant_id,
v01.art_id,
v01.dat,
CAST(v01.menge_prognose AS DECIMAL(18,3)) AS menge_prognose,
CAST(v01.menge_prognose * COALESCE(v04.umrech_faktor,1) AS DECIMAL(18,3)) AS menge_prognose_kolli,
CAST(v01.menge_prognose_bef AS DECIMAL(18,3)) AS menge_prognose_bef,
CAST(v01.menge_prognose_bef * COALESCE(v04.umrech_faktor,1) AS DECIMAL(18,3)) AS menge_prognose_bef_kolli,
CAST(v01.menge_prognose_max AS DECIMAL(18,3)) AS menge_prognose_max,
CAST(v01.menge_prognose_max * COALESCE(v04.umrech_faktor,1) AS DECIMAL(18,3)) AS menge_prognose_max_kolli,
CAST(v01.menge_ofc AS DECIMAL(18,3)) AS menge_ofc,
CAST(v01.menge_ofc * COALESCE(v04.umrech_faktor,1) AS DECIMAL(18,3)) AS menge_ofc_kolli,
v02.gp_id,
v01.progn_groesser_fg,
v01.menge_af_groesser_fg

FROM dbp_view.v_fur_prognose v01

INNER JOIN dbp_view.v_art_gp_nm_zu_per v02
ON v01.art_id = v02.art_id
AND v01.mandant_id = v02.mandant_id
AND v01.wup_id = v02.wup_id
AND v01.dat BETWEEN v02.dat_von AND v02.dat_bis

INNER JOIN dbp_view.v_art v021
ON v01.mandant_id=v021.mandant_id
AND v01.art_id=v021.art_id
AND v021.dat_bis= TO_DATE('9999-12-31', 'YYYY-MM-DD') 

LEFT OUTER JOIN dbp_view.v_art_vorschlagswert_per v03
ON v021.mandant_id = v03.mandant_id
AND v021.art_id = v03.art_id
AND v03.dat_bis = TO_DATE('9999-12-31', 'YYYY-MM-DD') 

LEFT OUTER JOIN dbp_view.v_art_umrechnung_faktor_per v04
ON v03.mandant_id = v04.mandant_id
AND v03.art_id = v04.art_id
AND v03.ausg_menge_einh_id = v04.altnv_menge_einh_id
AND v04.dat_bis = TO_DATE('9999-12-31', 'YYYY-MM-DD') 

WHERE v01.mandant_id = 1
AND v01.dispomerkmal IN ('10', '11', '12', '14')
AND v01.listung_id = 1
AND v01.kdis = 0;