CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.TBL_MV_ARTBEW_ZEK_MO_SUM_1
    (
	KJMO,
	ZEK_ID,
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	BEWART_ID,
	BEWART_DET_ID,
	POSTEN_ID_PER,
	POSTEN_KZ_PER,
	UMSATZ_MWST_BETRAG,
	UMSATZ_NETTO,
	VK_MENGE,
	EK_BRUTTO_ABSATZ,
	EK_NETTO_ABSATZ,
	EK_NETTOBNK_ABSATZ,
	EK_NETTO2_ABSATZ,
	EK_NETTO3_ABSATZ,
	EK_NETTO4_ABSATZ,
	EK_NETTO4_ABSATZ_EINSTANDSPREIS,
	UMSATZ_MWST_BETRAG_AF,
	UMSATZ_NETTO_AF,
	VK_MENGE_AF,
	EK_BRUTTO_ABSATZ_AF,
	EK_NETTO_ABSATZ_AF,
	EK_NETTOBNK_ABSATZ_AF,
	EK_NETTO2_ABSATZ_AF,
	EK_NETTO3_ABSATZ_AF,
	EK_NETTO4_ABSATZ_AF,
	EK_NETTO4_ABSATZ_AF_EINSTANDSPREIS,
	UMSATZ_MWST_BETRAG_SA,
	UMSATZ_NETTO_SA,
	VK_MENGE_SA,
	EK_BRUTTO_ABSATZ_SA,
	EK_NETTO_ABSATZ_SA,
	EK_NETTOBNK_ABSATZ_SA,
	EK_NETTO2_ABSATZ_SA,
	EK_NETTO3_ABSATZ_SA,
	EK_NETTO4_ABSATZ_SA,
	EK_NETTO4_ABSATZ_SA_EINSTANDSPREIS,
	LOGKOSTENZUSCHLAG,
	UMSATZ_AF_NON_LOYALTY,
	UMSATZ_AF_LOYALTY,
	UMSATZ_AF_LOYALTY_EXKL_SCHWARZ_MEDIA_U_BONRABATT_BBY,
	UMSATZ_AF_NON_LOYALTY_EXKL_SCHWARZ_MEDIA_U_BONRABATT_BBY,
	UMSATZ_AF_EXKL_SCHWARZ_MEDIA_U_BONRABATT_BBY,
	UMSATZ_AF_LOYALTY_SCHWARZ_MEDIA,
	UMSATZ_SA_NON_LOYALTY,
	UMSATZ_SA_LOYALTY,
	UMSATZ_BBY_NON_LOYALTY,
	UMSATZ_BBY_LOYALTY,
	UMSATZ_KDN_BBY_LOYALTY,
	UMSATZ_KDP_BBY_LOYALTY,
	UMSATZ_BONRABATT_BBY_NON_LOYALTY,
	UMSATZ_BONRABATT_BBY_LOYALTY,
	UMSATZ_BONRABATT_BBY,
	VK_MENGE_AF_NON_LOYALTY,
	VK_MENGE_AF_LOYALTY,
	VK_MENGE_AF_LOYALTY_EXKL_SCHWARZ_MEDIA_U_BONRABATT_BBY,
	VK_MENGE_AF_NON_LOYALTY_EXKL_SCHWARZ_MEDIA_U_BONRABATT_BBY,
	VK_MENGE_AF_EXKL_SCHWARZ_MEDIA_U_BONRABATT_BBY,
	VK_MENGE_AF_LOYALTY_SCHWARZ_MEDIA,
	VK_MENGE_SA_NON_LOYALTY,
	VK_MENGE_SA_LOYALTY,
	VK_MENGE_BBY_NON_LOYALTY,
	VK_MENGE_BBY_LOYALTY,
	VK_MENGE_KDN_BBY_LOYALTY,
	VK_MENGE_KDP_BBY_LOYALTY,
	VK_MENGE_BONRABATT_BBY_NON_LOYALTY,
	VK_MENGE_BONRABATT_BBY_LOYALTY,
	VK_MENGE_BONRABATT_BBY,
	EK_GLD_ABSATZ,
	EK_GLD_ABSATZ_AF,
	EK_GLD_ABSATZ_SA,
	EK_MEPOL,
	EK_MEPOL_AF,
	EK_MEPOL_SA,
	BONUSBASIS,
	BONUSBASIS_AF,
	BONUSBASIS_SA,
	PV_AKTION_SA_LOYALTY,
	PV_AKTION_SA_LOYALTY_BBY,
	PV_AKTION_SA_LOYALTY_KDN_BBY,
	PV_AKTION_SA_LOYALTY_KDP_BBY,
	PV_AKTION_SA_NON_LOYALTY,
	PV_AKTION_SA_NON_LOYALTY_BBY,
	PV_BBY_LOYALTY,
	PV_BBY_NON_LOYALTY,
	PV_KDN_BBY_LOYALTY,
	PV_KDP_BBY_LOYALTY,
	PV_BONRABATT_BBY_NON_LOYALTY,
	PV_BONRABATT_BBY_LOYALTY,
	PV_BONRABATT_BBY,
	WERBEABSCHRIFT_PV,
	WERBEABSCHRIFT_WERBENACHVERMARKTUNG_MANUELL,
	WERBEABSCHRIFT_AKTIONSANPASSUNG_FILIALE,
	WERBEABSCHRIFT_REST
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
SELECT
v03.kjmo,
v02.zek_id,
v01.mandant_id,
v01.nb_id,
v01.wup_id,
CAST(0 AS NUMBER(38,5)) AS bewart_id,
CAST(0 AS NUMBER(38,5)) AS bewart_det_id,
CAST('' AS VARCHAR(8)) AS posten_id_per,
CAST('' AS VARCHAR(8)) AS posten_kz_per,
CAST(0 AS NUMBER(38,5)) AS umsatz_mwst_betrag,
CAST(0 AS NUMBER(38,5)) AS umsatz_netto,
CAST(0 AS NUMBER(38,5)) AS vk_menge,
CAST(0 AS NUMBER(38,5)) AS ek_brutto_absatz,
CAST(0 AS NUMBER(38,5)) AS ek_netto_absatz,
CAST(0 AS NUMBER(38,5)) AS ek_nettobnk_absatz,
CAST(0 AS NUMBER(38,5)) AS ek_netto2_absatz,
CAST(0 AS NUMBER(38,5)) AS ek_netto3_absatz,
/*- Definition Fachbereich EK n.4 (KMO) = EK MEP (DE)*/
CAST(0 AS NUMBER(38,5)) AS ek_netto4_absatz,
CAST(0 AS NUMBER(38,5)) AS ek_netto4_absatz_einstandspreis,
/*AF*/
CAST(0 AS NUMBER(38,5)) AS umsatz_mwst_betrag_af,
CAST(0 AS NUMBER(38,5)) AS umsatz_netto_af,
CAST(0 AS NUMBER(38,5)) AS vk_menge_af,
CAST(0 AS NUMBER(38,5)) AS ek_brutto_absatz_af,
CAST(0 AS NUMBER(38,5)) AS ek_netto_absatz_af,
CAST(0 AS NUMBER(38,5)) AS ek_nettobnk_absatz_af,
CAST(0 AS NUMBER(38,5)) AS ek_netto2_absatz_af,
CAST(0 AS NUMBER(38,5)) AS ek_netto3_absatz_af,
/*- Definition Fachbereich EK n.4 (KMO) = EK MEP (DE)*/
CAST(0 AS NUMBER(38,5)) AS ek_netto4_absatz_af,
CAST(0 AS NUMBER(38,5)) AS ek_netto4_absatz_af_einstandspreis,
/*SA*/
CAST(0 AS NUMBER(38,5)) AS umsatz_mwst_betrag_sa,
CAST(0 AS NUMBER(38,5)) AS umsatz_netto_sa,
CAST(0 AS NUMBER(38,5)) AS vk_menge_sa,
CAST(0 AS NUMBER(38,5)) AS ek_brutto_absatz_sa,
CAST(0 AS NUMBER(38,5)) AS ek_netto_absatz_sa,
CAST(0 AS NUMBER(38,5)) AS ek_nettobnk_absatz_sa,
CAST(0 AS NUMBER(38,5)) AS ek_netto2_absatz_sa,
CAST(0 AS NUMBER(38,5)) AS ek_netto3_absatz_sa,
/*- Definition Fachbereich EK n.4 (KMO) = EK MEP (DE)*/
CAST(0 AS NUMBER(38,5)) AS ek_netto4_absatz_sa,
CAST(0 AS NUMBER(38,5)) AS ek_netto4_absatz_sa_einstandspreis,
/* nur für DE*/
CAST(0 AS NUMBER(38,5)) AS logkostenzuschlag,
CAST(0 AS NUMBER(38,5)) AS umsatz_af_non_loyalty,
CAST(0 AS NUMBER(38,5)) AS umsatz_af_loyalty,
CAST(0 AS NUMBER(38,5)) AS umsatz_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
CAST(0 AS NUMBER(38,5)) AS umsatz_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
CAST(0 AS NUMBER(38,5)) AS umsatz_af_exkl_schwarz_media_u_bonrabatt_bby,
CAST(0 AS NUMBER(38,5)) AS umsatz_af_loyalty_schwarz_media,
CAST(0 AS NUMBER(38,5)) AS umsatz_sa_non_loyalty,
CAST(0 AS NUMBER(38,5)) AS umsatz_sa_loyalty,
CAST(0 AS NUMBER(38,5)) AS umsatz_bby_non_loyalty,
CAST(0 AS NUMBER(38,5)) AS umsatz_bby_loyalty,
CAST(0 AS NUMBER(38,5)) AS umsatz_kdn_bby_loyalty,
CAST(0 AS NUMBER(38,5)) AS umsatz_kdp_bby_loyalty,
CAST(0 AS NUMBER(38,5)) AS umsatz_bonrabatt_bby_non_loyalty,
CAST(0 AS NUMBER(38,5)) AS umsatz_bonrabatt_bby_loyalty,
CAST(0 AS NUMBER(38,5)) AS umsatz_bonrabatt_bby,
CAST(0 AS NUMBER(38,5)) AS vk_menge_af_non_loyalty,
CAST(0 AS NUMBER(38,5)) AS vk_menge_af_loyalty,
CAST(0 AS NUMBER(38,5)) AS vk_menge_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
CAST(0 AS NUMBER(38,5)) AS vk_menge_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
CAST(0 AS NUMBER(38,5)) AS vk_menge_af_exkl_schwarz_media_u_bonrabatt_bby,
CAST(0 AS NUMBER(38,5)) AS vk_menge_af_loyalty_schwarz_media,
CAST(0 AS NUMBER(38,5)) AS vk_menge_sa_non_loyalty,
CAST(0 AS NUMBER(38,5)) AS vk_menge_sa_loyalty,
CAST(0 AS NUMBER(38,5)) AS vk_menge_bby_non_loyalty,
CAST(0 AS NUMBER(38,5)) AS vk_menge_bby_loyalty,
CAST(0 AS NUMBER(38,5)) AS vk_menge_kdn_bby_loyalty,
CAST(0 AS NUMBER(38,5)) AS vk_menge_kdp_bby_loyalty,
CAST(0 AS NUMBER(38,5)) AS vk_menge_bonrabatt_bby_non_loyalty,
CAST(0 AS NUMBER(38,5)) AS vk_menge_bonrabatt_bby_loyalty,
CAST(0 AS NUMBER(38,5)) AS vk_menge_bonrabatt_bby
--AP0052094, SPEC0065401
,CAST(0 AS NUMBER(38,5)) AS ek_gld_absatz
,CAST(0 AS NUMBER(38,5)) AS ek_gld_absatz_af
,CAST(0 AS NUMBER(38,5)) AS ek_gld_absatz_sa,
-- AP0143687: FWU
CAST(0 AS NUMBER(38,5)) AS ek_mepol,
CAST(0 AS NUMBER(38,5)) AS ek_mepol_af,
CAST(0 AS NUMBER(38,5)) AS ek_mepol_sa,
CAST(0 AS NUMBER(38,5)) AS bonusbasis,
CAST(0 AS NUMBER(38,5)) AS bonusbasis_af,
CAST(0 AS NUMBER(38,5)) AS bonusbasis_sa,

--PV metrics
SUM(CASE WHEN v01.wv_grund_id = 2 THEN v01.abschriftbetrag_netto ELSE 0 END) AS pv_aktion_sa_loyalty,
CAST(0 AS NUMBER(38,5)) AS pv_aktion_sa_loyalty_bby,
CAST(0 AS NUMBER(38,5)) AS pv_aktion_sa_loyalty_kdn_bby,
CAST(0 AS NUMBER(38,5)) AS pv_aktion_sa_loyalty_kdp_bby,
SUM(CASE WHEN v01.wv_grund_id = 0 THEN v01.abschriftbetrag_netto ELSE 0 END) AS pv_aktion_sa_non_loyalty,
CAST(0 AS NUMBER(38,5)) AS pv_aktion_sa_non_loyalty_bby,
-- Splittung PV 
-- -> ab 01.04.2022 neue Logik davor alte Logik  
-- INC8719387 Erweiterung CASE Logik um dat für die 2. CASE Bedingung 22.05.2024 / ssch1303
SUM(CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (52, 53, 54) 
         THEN v01.abschriftbetrag_netto
         WHEN v01.dat <  '2022-04-01' AND v01.wv_grund_id IN (52, 53, 54, 55)
         THEN v01.abschriftbetrag_netto 
         ELSE 0 END) AS pv_bby_loyalty,
SUM(CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (56, 57, 58) 
         THEN v01.abschriftbetrag_netto 
         WHEN v01.dat <  '2022-04-01' AND v01.wv_grund_id IN (56, 57, 58, 59)  
         THEN v01.abschriftbetrag_netto 
         ELSE 0 END) AS pv_bby_non_loyalty,
SUM(CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (60, 61, 62) 
         THEN v01.abschriftbetrag_netto
         WHEN v01.dat <  '2022-04-01' AND v01.wv_grund_id IN (60, 61, 62, 63)
         THEN v01.abschriftbetrag_netto ELSE 0 END) AS pv_kdn_bby_loyalty,
SUM(CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (64, 65, 66) 
         THEN v01.abschriftbetrag_netto
         WHEN v01.dat <  '2022-04-01' AND v01.wv_grund_id IN (64, 65, 66, 67) 
         THEN v01.abschriftbetrag_netto ELSE 0 END) AS pv_kdp_bby_loyalty,
  
SUM(CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (59)  
         THEN v01.abschriftbetrag_netto 
         ELSE 0 END) AS pv_bonrabatt_bby_non_loyalty,
SUM(CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (55,63,67) 
         THEN v01.abschriftbetrag_netto 
         ELSE 0 END)AS pv_bonrabatt_bby_loyalty,
pv_bonrabatt_bby_non_loyalty + pv_bonrabatt_bby_loyalty AS pv_bonrabatt_bby

-- DE Werbeabschriften AP0213409/SPEC0247905 sschuecke 16.09.2024

,pv_aktion_sa_loyalty + pv_aktion_sa_loyalty_bby + pv_aktion_sa_loyalty_kdn_bby     
                      + pv_aktion_sa_loyalty_kdp_bby + pv_aktion_sa_non_loyalty
                      + pv_aktion_sa_non_loyalty_bby + pv_bby_loyalty + pv_bby_non_loyalty
                      + pv_kdn_bby_loyalty + pv_kdp_bby_loyalty + pv_bonrabatt_bby
					  AS werbeabschrift_pv
,SUM(CASE WHEN v01.wv_grund_id IN (48,49) THEN v01.abschriftbetrag_netto END) AS werbeabschrift_werbenachvermarktung_manuell
,SUM(CASE WHEN v01.wv_grund_id IN (20,21,23,50,70) THEN v01.abschriftbetrag_netto END) AS werbeabschrift_aktionsanpassung_filiale
,SUM(v01.abschriftbetrag_netto) - (werbeabschrift_pv + werbeabschrift_werbenachvermarktung_manuell + werbeabschrift_aktionsanpassung_filiale) AS werbeabschrift_rest

FROM dbp_view.v_marktabschriften_1 v01

INNER JOIN dbp_view.v_art_1 v02
ON v01.mandant_id = v02.mandant_id 
AND v01.art_id  = v02.art_id

INNER JOIN dbp_view.v_tag_1 v03
ON v01.dat = v03.dat

WHERE v01.mandant_id = 1
AND v01.abschriftart_id = -1

-- AP0213409/SPEC0247905 sschuecke 16.09.2024
-- AND v01.wv_grund_id IN (2, 0, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67)

GROUP BY 
v03.kjmo,
v02.zek_id,
v01.mandant_id,
v01.nb_id,
v01.wup_id
;