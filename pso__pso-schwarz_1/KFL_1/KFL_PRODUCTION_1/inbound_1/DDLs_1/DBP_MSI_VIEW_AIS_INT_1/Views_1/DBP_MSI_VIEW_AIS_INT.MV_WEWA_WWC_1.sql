CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_WEWA_WWC_1(
	MANDANT_ID,
	WEWA_BELEG_ID,
	WEWA_BELEG_POS_ID,
	WEWA_JAHR,
	ART_ID,
	WUP_ID,
	NB_ID,
	GP_ID,
	LAGER_BEWART_ID,
	DAT_BUCH,
	MENGE_BASIS,
	WEWA_STATUS,
	VORZEICHEN_RSEG,
	VORZEICHEN,
	EK_MEP,
	EK_MEP_OLK,
	WEWA_MENGE_ZL_WE,
	WEWA_MENGE_ZL_RE,
	BETRAG_EKN_ZL_WE,
	BETRAG_EKN_ZL_RE,
	WEWA_MENGE_RET_ZL_WE,
	WEWA_MENGE_RET_ZL_RE,
	BETRAG_EKN_RET_ZL_WE,
	BETRAG_EKN_RET_ZL_RE,
	WEWA_MENGE_INKL_RET_ZL_WE,
	WEWA_MENGE_INKL_RET_ZL_RE,
	BETRAG_EKN_INKL_RET_ZL_WE,
	BETRAG_EKN_INKL_RET_ZL_RE,
	WEWA_MENGE_DZ_WE,
	WEWA_MENGE_DZ_RE,
	BETRAG_EKN_DZ_WE,
	BETRAG_EKN_DZ_RE,
	WEWA_MENGE_RET_DZ_WE,
	WEWA_MENGE_RET_DZ_RE,
	BETRAG_EKN_RET_DZ_WE,
	BETRAG_EKN_RET_DZ_RE,
	WEWA_MENGE_INKL_RET_DZ_WE,
	WEWA_MENGE_INKL_RET_DZ_RE,
	BETRAG_EKN_INKL_RET_DZ_WE,
	BETRAG_EKN_INKL_RET_DZ_RE,
	WEWA_MENGE_WE,
	WEWA_MENGE_RE,
	BETRAG_EKN_WE,
	BETRAG_EKN_RE,
	WEWA_MENGE_RET_WE,
	WEWA_MENGE_RET_RE,
	BETRAG_EKN_RET_WE,
	BETRAG_EKN_RET_RE,
	WEWA_MENGE_INKL_RET_WE,
	WEWA_MENGE_INKL_RET_RE,
	BETRAG_EKN_INKL_RET_WE,
	BETRAG_EKN_INKL_RET_RE,
	WRG_ID,
	POSTEN_KZ_PER
) AS
SELECT
v01.ekbe_mandant_id AS mandant_id,
v01.mseg_beleg_id AS wewa_beleg_id,
v01.mseg_beleg_pos_id AS wewa_beleg_pos_id,
v01.mseg_kj AS wewa_jahr,
v01.ekpo_art_id AS art_id,
v01.ekbe_wup_id AS wup_id,
v01.ekbe_nb_id AS nb_id,
v01.mseg_gp_id AS gp_id,
v01.mseg_lager_bewart_id AS lager_bewart_id, 
v01.mkpf_dat_buch AS dat_buch,
v01.mseg_menge_bestand_bme AS menge_basis,
v01.RBKP_BELEGART_ID    AS wewa_status,
CASE WHEN v01.rseg_soll_haben_kz = 'H' THEN -1 ELSE 1 END AS vorzeichen_rseg,
CASE WHEN v01.ekbe_soll_haben_kz = 'H' THEN -1 ELSE 1 END AS vorzeichen,

-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
SUM(CASE WHEN v01.ekbe_mandant_id = 1 THEN 0
WHEN v200.wrg_typ_id  = 1 THEN COALESCE(v02.ek_mep,v03.ek_mep)
WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  COALESCE(v02.ek_mep,v03.ek_mep)  * v300.umrechnungskurs
WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN  COALESCE(v02.ek_mep,v03.ek_mep)  * v400.umrechnungskurs
END ) AS ek_mep,
SUM(CASE WHEN v01.ekbe_mandant_id = 1 THEN 0
WHEN v200.wrg_typ_id  = 1 THEN (COALESCE(v02.ek_mep,v03.ek_mep)-COALESCE(v02.logistikkostenzuschlag ,v03.logistikkostenzuschlag ))
WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  (COALESCE(v02.ek_mep,v03.ek_mep)-COALESCE(v02.logistikkostenzuschlag ,v03.logistikkostenzuschlag ))  * v300.umrechnungskurs
WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN  (COALESCE(v02.ek_mep,v03.ek_mep)-COALESCE(v02.logistikkostenzuschlag ,v03.logistikkostenzuschlag ))  * v400.umrechnungskurs
END ) AS ek_mep_olk,


/* vorerst nicht dabei
SUM(CAST(CASE
WHEN   v200.wrg_typ_id  = 1 THEN v01.ekbe_betrag
WHEN   v200.wrg_typ_id  = 0 THEN  v01.ekbe_betrag* v300.umrechnungskurs END AS DECIMAL(18,6)))   AS betrag_ekn,

CAST(CASE
WHEN v200.wrg_typ_id  = 1 THEN v01.betrag_vk_netto
WHEN v200.wrg_typ_id  = 0 THEN  v01.betrag_vk_netto* v300.umrechnungskurs END AS DECIMAL(18,6))   AS betrag_vk_netto,*/

/*** ZL Wareneingang / Faktura  ***/ 
/* Menge */
SUM(CASE 
WHEN v01.ekbe_mandant_id != 1 AND v01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND v01.ekbe_nb_id = -111  THEN v01.ekbe_menge_best
ELSE 0 END) AS wewa_menge_zl_WE,
SUM(CASE
WHEN v01.ekbe_mandant_id != 1 AND v01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND v01.ekbe_nb_id = -111 THEN (CASE WHEN v01.ekbe_best_entw_typ_id_rech = ('N') THEN 0 ELSE v01.ekbe_menge_best_rech END)
ELSE 0 END) AS wewa_menge_zl_RE,
/* Betrag */
SUM(CASE
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 1 AND v01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND v01.ekbe_nb_id = -111 THEN v01.ekbe_betrag*vorzeichen
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 AND v01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND v01.ekbe_nb_id = -111 THEN  v01.ekbe_betrag*vorzeichen* v300.umrechnungskurs
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 AND v01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND v01.ekbe_nb_id = -111 THEN  v01.ekbe_betrag*vorzeichen* v400.umrechnungskurs 
ELSE 0 END)   AS betrag_ekn_ZL_WE,
SUM(CASE
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 1 AND v01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND v01.ekbe_nb_id = -111 THEN v01.ekbe_betrag_rech*vorzeichen_rseg
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 AND v01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND v01.ekbe_nb_id = -111 THEN v01.ekbe_betrag_rech*vorzeichen_rseg* v300.umrechnungskurs 
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 AND v01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND v01.ekbe_nb_id = -111 THEN v01.ekbe_betrag_rech*vorzeichen_rseg* v400.umrechnungskurs 
ELSE 0 END)   AS betrag_ekn_ZL_RE,

/*** ZL Wareneingang / Faktura Retoure ***/ 
/* Menge */
SUM(CASE
WHEN v01.ekbe_mandant_id != 1 AND v01.mseg_lager_bewart_id IN ('161', '162') AND v01.ekbe_nb_id = -111 THEN v01.ekbe_menge_best
ELSE 0 END) AS wewa_menge_ret_zl_WE,
SUM(CASE
WHEN v01.ekbe_mandant_id != 1 AND v01.mseg_lager_bewart_id IN ('161', '162') AND v01.ekbe_nb_id = -111 THEN (CASE WHEN v01.ekbe_best_entw_typ_id_rech = ('N') THEN 0 ELSE v01.ekbe_menge_best_rech END)
ELSE 0 END) AS wewa_menge_ret_zl_RE,
/* Betrag */
SUM(CASE
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 1 AND v01.mseg_lager_bewart_id IN ('161', '162') AND v01.ekbe_nb_id = -111 THEN v01.ekbe_betrag*vorzeichen
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 AND v01.mseg_lager_bewart_id IN ('161', '162') AND v01.ekbe_nb_id = -111 THEN  v01.ekbe_betrag*vorzeichen* v300.umrechnungskurs
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 AND v01.mseg_lager_bewart_id IN ('161', '162') AND v01.ekbe_nb_id = -111 THEN  v01.ekbe_betrag*vorzeichen* v400.umrechnungskurs 
ELSE 0 END)   AS betrag_ekn_ret_ZL_WE,
SUM(CASE
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 1 AND v01.mseg_lager_bewart_id IN ('161', '162') AND v01.ekbe_nb_id = -111 THEN v01.ekbe_betrag_rech*vorzeichen_rseg
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 AND v01.mseg_lager_bewart_id IN ('161', '162') AND v01.ekbe_nb_id = -111 THEN v01.ekbe_betrag_rech*vorzeichen_rseg* v300.umrechnungskurs
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 AND v01.mseg_lager_bewart_id IN ('161', '162') AND v01.ekbe_nb_id = -111 THEN v01.ekbe_betrag_rech*vorzeichen_rseg* v400.umrechnungskurs 
ELSE 0 END)  AS betrag_ekn_ret_ZL_RE,
/*** ZL Wareneingang / Faktura inkl. Retoure ***/ 
/* Menge */
wewa_menge_zl_WE + wewa_menge_ret_zl_WE AS wewa_menge_inkl_ret_zl_WE,
wewa_menge_zl_RE + wewa_menge_ret_zl_RE AS wewa_menge_inkl_ret_zl_RE,
/* Betrag */
betrag_ekn_ZL_WE + betrag_ekn_ret_ZL_WE AS betrag_ekn_inkl_ret_zl_WE,
betrag_ekn_ZL_RE + betrag_ekn_ret_ZL_RE AS betrag_ekn_inkl_ret_zl_RE,

/*** DZ Wareneingang / Faktura  ***/ 
/* Menge */
SUM(CASE
WHEN v01.ekbe_mandant_id != 1 AND v01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND v01.ekbe_nb_id = 0 THEN v01.ekbe_menge_best 
ELSE 0 END) AS wewa_menge_dz_WE,
SUM(CASE
WHEN v01.ekbe_mandant_id != 1 AND v01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND v01.ekbe_nb_id = 0 THEN (CASE WHEN v01.ekbe_best_entw_typ_id_rech = ('N') THEN 0 ELSE v01.ekbe_menge_best_rech END)
ELSE 0 END) AS wewa_menge_dz_RE,
/* Betrag */
SUM(CASE
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 1 AND v01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND v01.ekbe_nb_id = 0 THEN v01.ekbe_betrag*vorzeichen
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 AND v01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND v01.ekbe_nb_id = 0 THEN  v01.ekbe_betrag*vorzeichen* v300.umrechnungskurs
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 1 AND v200.berichtskurs_typ_id = 1 AND v01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND v01.ekbe_nb_id = 0 THEN  v01.ekbe_betrag*vorzeichen* v400.umrechnungskurs 
ELSE 0 END)  AS betrag_ekn_DZ_WE,
SUM(CASE
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 1 AND v01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND v01.ekbe_nb_id = 0 THEN v01.ekbe_betrag_rech*vorzeichen_rseg
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 AND v01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND v01.ekbe_nb_id = 0 THEN v01.ekbe_betrag_rech*vorzeichen_rseg* v300.umrechnungskurs
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 AND v01.mseg_lager_bewart_id IN ('101', '102', '901', '902') AND v01.ekbe_nb_id = 0 THEN v01.ekbe_betrag_rech*vorzeichen_rseg* v400.umrechnungskurs 
ELSE 0 END)   AS betrag_ekn_DZ_RE,
/*** DZ Wareneingang / Faktura Retoure ***/ 
/* Menge */
SUM(CASE
WHEN v01.ekbe_mandant_id != 1 AND v01.mseg_lager_bewart_id IN ('161', '162') AND v01.ekbe_nb_id = 0 THEN v01.ekbe_menge_best
ELSE 0 END) AS wewa_menge_ret_dz_WE,
SUM(CASE
WHEN v01.ekbe_mandant_id != 1 AND v01.mseg_lager_bewart_id IN ('161', '162') AND v01.ekbe_nb_id = 0 THEN (CASE WHEN v01.ekbe_best_entw_typ_id_rech = ('N') THEN 0 ELSE v01.ekbe_menge_best_rech END)
ELSE 0 END) AS wewa_menge_ret_dz_RE,
/* Betrag */
SUM(CASE
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 1 AND v01.mseg_lager_bewart_id IN ('161', '162') AND v01.ekbe_nb_id = 0 THEN v01.ekbe_betrag*vorzeichen
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 AND v01.mseg_lager_bewart_id IN ('161', '162') AND v01.ekbe_nb_id = 0 THEN  v01.ekbe_betrag*vorzeichen* v300.umrechnungskurs
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 AND v01.mseg_lager_bewart_id IN ('161', '162') AND v01.ekbe_nb_id = 0 THEN  v01.ekbe_betrag*vorzeichen* v400.umrechnungskurs
ELSE 0 END )   AS betrag_ekn_ret_DZ_WE,
SUM(CASE
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 1 AND v01.mseg_lager_bewart_id IN ('161', '162') AND v01.ekbe_nb_id = 0 THEN v01.ekbe_betrag_rech*vorzeichen_rseg
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 AND v01.mseg_lager_bewart_id IN ('161', '162') AND v01.ekbe_nb_id = 0 THEN v01.ekbe_betrag_rech*vorzeichen_rseg* v300.umrechnungskurs
WHEN v01.ekbe_mandant_id != 1 AND v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 AND v01.mseg_lager_bewart_id IN ('161', '162') AND v01.ekbe_nb_id = 0 THEN v01.ekbe_betrag_rech*vorzeichen_rseg* v400.umrechnungskurs 
ELSE 0 END)   AS betrag_ekn_ret_DZ_RE,

/*** ZL Wareneingang / Faktura inkl. Retoure ***/ 
/* Menge */
wewa_menge_dz_WE + wewa_menge_ret_dz_WE AS wewa_menge_inkl_ret_dz_WE,
wewa_menge_dz_RE + wewa_menge_ret_dz_RE AS wewa_menge_inkl_ret_dz_RE,
/* Betrag */
betrag_ekn_DZ_WE + betrag_ekn_ret_DZ_WE AS betrag_ekn_inkl_ret_dz_WE,
betrag_ekn_DZ_RE + betrag_ekn_ret_DZ_RE AS betrag_ekn_inkl_ret_dz_RE,

/*** Gesamt Wareneingang / Faktura ***/
/* Menge */
wewa_menge_zl_WE + wewa_menge_dz_WE  AS wewa_menge_WE,
wewa_menge_zl_RE + wewa_menge_dz_RE  AS wewa_menge_RE,
/* Betrag */
betrag_ekn_ZL_WE + betrag_ekn_DZ_WE  AS betrag_ekn_WE,
betrag_ekn_ZL_RE + betrag_ekn_DZ_RE  AS betrag_ekn_RE,

/*** Gesamt Wareneingang / Faktura Retoure ***/
/* Menge */
wewa_menge_ret_zl_WE + wewa_menge_ret_dz_WE  AS wewa_menge_ret_WE,
wewa_menge_ret_zl_RE + wewa_menge_ret_dz_RE  AS wewa_menge_ret_RE,
/* Betrag */
betrag_ekn_ret_ZL_WE + betrag_ekn_ret_DZ_WE  AS betrag_ekn_ret_WE,
betrag_ekn_ret_ZL_RE + betrag_ekn_ret_DZ_RE  AS betrag_ekn_ret_RE,

/*** Gesamt Wareneingang / Faktura inkl Retoure ***/
/* Menge */
wewa_menge_inkl_ret_zl_WE + wewa_menge_inkl_ret_dz_WE  AS wewa_menge_inkl_ret_WE,
wewa_menge_inkl_ret_zl_RE + wewa_menge_inkl_ret_dz_RE  AS wewa_menge_inkl_ret_RE,
/* Betrag */
betrag_ekn_inkl_ret_zl_WE + betrag_ekn_inkl_ret_dz_WE  AS betrag_ekn_inkl_ret_WE,
betrag_ekn_inkl_ret_zl_RE + betrag_ekn_inkl_ret_dz_RE  AS betrag_ekn_inkl_ret_RE,


v01.mseg_wrg_id AS wrg_id,
CASE
WHEN v04.POSTEN_ID NOT IN ('1') THEN 'SO'
ELSE 'PN'
END :: CHAR(2) AS posten_kz_per

FROM dbp_view.v_wewa_wwc_1 v01
-- Ermittlung der eingestellter Währung
CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200

--ZEKP_1 Auflösung, marktspezifische Preise
LEFT JOIN
(
SELECT mandant_id,
    art_id,
    gp_id,
    wup_id,
    dat_von,
    dat_bis,
    einstandspreis,
    ek_nettonetto,
    ek_brutto,
    ek_brutto_normal,
    ek_mep,
    logistikkostenzuschlag
FROM dbp_view.v_art_gp_wup_zu_per_1
WHERE mandant_id != 1 AND wup_id > -1
) v02
ON v01.ekbe_mandant_id= v02.mandant_id
AND v01.ekbe_wup_id = v02.wup_id
AND v01.mseg_gp_id = v02.gp_id
AND v01.ekpo_art_id  =  v02.art_id 
AND v01.mkpf_dat_buch BETWEEN v02.dat_von AND v02.dat_bis
 
LEFT JOIN
--ZEKP_1 Auflösung allgemeingeltende Preise
(
SELECT mandant_id,
    art_id,
    gp_id,
    wup_id,
    dat_von,
    dat_bis,
    einstandspreis,
    ek_nettonetto,
    ek_brutto,
    ek_brutto_normal,
    ek_mep,
    logistikkostenzuschlag
FROM dbp_view.v_art_gp_wup_zu_per_1
WHERE mandant_id != 1 AND wup_id = -1
) v03
ON v01.ekbe_mandant_id =  v03.mandant_id 
AND v01.mseg_gp_id  =  v03.gp_id 
AND v01.ekpo_art_id =  v03.art_id 
AND v01.mkpf_dat_buch BETWEEN v03.dat_von AND v03.dat_bis

/*-- Umrechnung Standardkurs, Tageskurs              
JOIN
dbp_view.v_kurs_1 v300
ON v01.mkpf_dat_buch BETWEEN v300.dat_von AND v300.dat_bis
AND v01.mseg_wrg_id = v300.von_wrg_id
AND v300.kurstyp_id = 9
AND v300.nach_wrg_id ='EUR' */

-- JOIN aktueller Berichtskurs
JOIN dbp_view.v_kurs_1 v300
ON v300.dat_bis = '9999-12-31'
AND v01.mseg_wrg_id = v300.von_wrg_id
AND v300.kurstyp_id = 3
AND v300.nach_wrg_id ='EUR'

-- JOIN historischer Berichtskurs
JOIN dbp_view.v_kurs_1 v400
ON v01.mkpf_dat_buch BETWEEN v400.dat_von AND v400.dat_bis
AND v01.mseg_wrg_id = v400.von_wrg_id
AND v400.kurstyp_id = 3
AND v400.nach_wrg_id ='EUR'

LEFT JOIN dbp_view.v_art_per_1 v04
ON v01.ekpo_art_id = v04.art_id
AND v01.ekbe_mandant_id = v04.mandant_id
AND v01.mkpf_dat_buch BETWEEN v04.dat_von-1 AND v04.dat_bis-1 
GROUP BY v01.ekbe_mandant_id ,
v01.mseg_beleg_id,
v01.mseg_beleg_pos_id,
v01.mseg_kj,
v01.ekpo_art_id,
v01.ekbe_wup_id,
v01.ekbe_nb_id,
v01.mseg_gp_id,
v01.mseg_lager_bewart_id, 
v01.mkpf_dat_buch,
v01.mseg_menge_bestand_bme ,
v01.RBKP_BELEGART_ID,
vorzeichen_rseg,
vorzeichen,
v01.mseg_wrg_id,
posten_kz_per;