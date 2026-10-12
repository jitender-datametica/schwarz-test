create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_AIS_INT.TBL_MV_ARTBEW_2(
	DAT,
	ART_ID,
	MANDANT_ID,
	GP_ID,
	NB_ID,
	WUP_ID,
	BEWART_ID,
	BEWART_DET_ID,
	BQ_FINDUNG_ID,
	BEZUGSWEG_ID,
	AKTION_ID,
	POSTEN_ID_PER,
	POSTEN_KZ_PER,
	WRG_2,
	HERST_ID,
	WUP_BEREINIGT_FG,
	WUP_BEREINIGT_FG_VJ,
	WUP_BEREINIGT_FG_VJ_WO,
	MWST_ID,
	UMSATZ_MWST_BETRAG,
	UMSATZ_NETTO,
	VK_MENGE,
	VK_MENGE_NORM,
	EK_BRUTTO_ABSATZ,
	EK_NETTO_ABSATZ,
	EK_NETTOBNK_ABSATZ,
	EK_NETTO2_ABSATZ,
	EK_NETTO3_ABSATZ,
	EK_NETTO4_ABSATZ,
	EK_NETTO4_ABSATZ_EINSTANDSPREIS,
	EK_GLD_ABSATZ,
	UMSATZ_MWST_BETRAG_AF,
	UMSATZ_NETTO_AF,
	VK_MENGE_AF,
	VK_MENGE_AF_NORM,
	EK_BRUTTO_ABSATZ_AF,
	EK_NETTO_ABSATZ_AF,
	EK_NETTOBNK_ABSATZ_AF,
	EK_NETTO2_ABSATZ_AF,
	EK_NETTO3_ABSATZ_AF,
	EK_NETTO4_ABSATZ_AF,
	EK_NETTO4_ABSATZ_AF_EINSTANDSPREIS,
	EK_GLD_ABSATZ_AF,
	UMSATZ_MWST_BETRAG_SA,
	UMSATZ_NETTO_SA,
	VK_MENGE_SA,
	VK_MENGE_SA_NORM,
	EK_BRUTTO_ABSATZ_SA,
	EK_NETTO_ABSATZ_SA,
	EK_NETTOBNK_ABSATZ_SA,
	EK_NETTO2_ABSATZ_SA,
	EK_NETTO3_ABSATZ_SA,
	EK_NETTO4_ABSATZ_SA,
	EK_NETTO4_ABSATZ_SA_EINSTANDSPREIS,
	EK_GLD_ABSATZ_SA,
	EAN_KASSE,
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
	BONUSBASIS,
	BONUSBASIS_AF,
	BONUSBASIS_SA,
	EK_MEPOL,
	EK_MEPOL_AF,
	EK_MEPOL_SA,
	WERBEABSCHRIFT_PV,
	WERBEABSCHRIFT_WERBENACHVERMARKTUNG_MANUELL,
	WERBEABSCHRIFT_AKTIONSANPASSUNG_FILIALE,
	WERBEABSCHRIFT_REST,
	AKTIONSART_LISTE_ID,
	AKTION_TYP_LISTE_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_AIS_INT
 as

WITH t_wup_bereinigt AS(

    SELECT  
        v01.dat, 
        v02.mandant_id,
        v02.wup_id,
        
        CASE WHEN (v01.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v01.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_akt,
        CASE WHEN (v04.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v04.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_vj_wo,
        CASE WHEN v01.dat LIKE '%-02-29' 
            THEN wup_bereinigt_fg_vj_wo
        
        WHEN  (v03.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v03.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) 
            THEN 1 
        ELSE 0 END AS wup_bereinigt_fg_vj
    FROM dbp_view.v_tag_2 v01
    JOIN dbp_view.v_wup_2 v02
        ON (v01.dat >= COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung))
    LEFT JOIN dbp_view.v_tag_2 v03
        ON (v01.dat = v03.dat_vj_kt)
    LEFT JOIN dbp_view.v_tag_2 v04
        ON (v01.dat = v04.dat_vj)
    WHERE v01.dat BETWEEN '2019-01-01' AND CURRENT_DATE()+7
    AND ((v02.nb_id = 0
    AND v02.mandant_id <> 1) OR (v02.mandant_id>= 2 AND v02.wup_id = 0))
)
-- AP0286829, Erweiterung >= 2022-04-01: pv_kdp_bby_loy um 73, 74, 75  UND  pv_bonrabatt_bby_loy um 76 / sschuecke 29.01.2026
SELECT
  v01.dat
, v01.art_id
, v01.mandant_id
, COALESCE(v02.gp_id,-1) AS gp_id
, v01.nb_id
, v01.wup_id
, CAST(0 AS NUMBER(38,0)) AS bewart_id
, CAST(0 AS NUMBER(38,0)) AS bewart_det_id
, CAST(0 AS NUMBER(38,0)) AS bq_findung_id
, CAST(0 AS NUMBER(38,0)) AS bezugsweg_id
, CAST('' AS VARCHAR(80)) AS aktion_id
, CAST('' AS VARCHAR(8)) AS posten_id_per
, CAST('' AS VARCHAR(8)) AS posten_kz_per
, CAST('EUR' AS VARCHAR(12)) AS wrg_2
, CAST(0 AS NUMBER(38,0)) AS herst_id
,v05.wup_bereinigt_fg_akt AS wup_bereinigt_fg
,v05.wup_bereinigt_fg_vj
,v05.wup_bereinigt_fg_vj_wo
, CAST(0 AS NUMBER(38,0)) AS mwst_id
, CAST(0 AS NUMBER(38,5)) AS umsatz_mwst_betrag
, CAST(0 AS NUMBER(38,5)) AS umsatz_netto
, CAST(0 AS NUMBER(38,5)) AS vk_menge
, CAST(0 AS NUMBER(38,5)) AS vk_menge_norm
, CAST(0 AS NUMBER(38,5)) AS ek_brutto_absatz
, CAST(0 AS NUMBER(38,5)) AS ek_netto_absatz
, CAST(0 AS NUMBER(38,5)) AS ek_nettobnk_absatz
, CAST(0 AS NUMBER(38,5)) AS ek_netto2_absatz
, CAST(0 AS NUMBER(38,5)) AS ek_netto3_absatz
, CAST(0 AS NUMBER(38,5)) AS ek_netto4_absatz
, CAST(0 AS NUMBER(38,5)) AS ek_netto4_absatz_einstandspreis
, CAST(0 AS NUMBER(38,5)) AS ek_gld_absatz

, CAST(0 AS NUMBER(38,5)) AS umsatz_mwst_betrag_af
, CAST(0 AS NUMBER(38,5)) AS umsatz_netto_af
, CAST(0 AS NUMBER(38,5)) AS vk_menge_af
, CAST(0 AS NUMBER(38,5)) AS vk_menge_af_norm
, CAST(0 AS NUMBER(38,5)) AS ek_brutto_absatz_af
, CAST(0 AS NUMBER(38,5)) AS ek_netto_absatz
, CAST(0 AS NUMBER(38,5)) AS ek_nettobnk_absatz_af
, CAST(0 AS NUMBER(38,5)) AS ek_netto2_absatz_af
, CAST(0 AS NUMBER(38,5)) AS ek_netto3_absatz_af
, CAST(0 AS NUMBER(38,5)) AS ek_netto4_absatz_af
, CAST(0 AS NUMBER(38,5)) AS ek_netto4_absatz_af_einstandspreis
, CAST(0 AS NUMBER(38,5)) AS ek_gld_absatz_af


, CAST(0 AS NUMBER(38,5)) AS umsatz_mwst_betrag_sa
, CAST(0 AS NUMBER(38,5)) AS umsatz_netto_sa
, CAST(0 AS NUMBER(38,5)) AS vk_menge_sa
, CAST(0 AS NUMBER(38,5)) AS vk_menge_sa_norm
, CAST(0 AS NUMBER(38,5)) AS ek_brutto_absatz_sa
, CAST(0 AS NUMBER(38,5)) AS ek_netto_absatz
, CAST(0 AS NUMBER(38,5)) AS ek_nettobnk_absatz_sa
, CAST(0 AS NUMBER(38,5)) AS ek_netto2_absatz_sa
, CAST(0 AS NUMBER(38,5)) AS ek_netto3_absatz_sa
, CAST(0 AS NUMBER(38,5)) AS ek_netto4_absatz_sa
, CAST(0 AS NUMBER(38,5)) AS ek_netto4_absatz_sa_einstandspreis
, CAST(0 AS NUMBER(38,5)) AS ek_gld_absatz_sa
-- NSR5601507 Anpassung Datentyp/Länge ean_kasse analog DBP_DATA.ARBEW wegen Nachkommastellen / sschuecke 01.10.2025
, CAST(0 AS NUMBER(26,0)) AS ean_kasse
, CAST(0 AS NUMBER(38,5)) AS logkostenzuschlag

, CAST(0 AS NUMBER(38,5)) AS umsatz_af_non_loyalty
, CAST(0 AS NUMBER(38,5)) AS umsatz_af_loyalty
, CAST(0 AS NUMBER(38,5)) AS umsatz_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby
, CAST(0 AS NUMBER(38,5)) AS umsatz_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby
, CAST(0 AS NUMBER(38,5)) AS umsatz_af_exkl_schwarz_media_u_bonrabatt_bby
, CAST(0 AS NUMBER(38,5)) AS umsatz_af_loyalty_schwarz_media
, CAST(0 AS NUMBER(38,5)) AS umsatz_sa_non_loyalty
, CAST(0 AS NUMBER(38,5)) AS umsatz_sa_loyalty
, CAST(0 AS NUMBER(38,5)) AS umsatz_bby_non_loyalty
, CAST(0 AS NUMBER(38,5)) AS umsatz_bby_loyalty
, CAST(0 AS NUMBER(38,5)) AS umsatz_kdn_bby_loyalty
, CAST(0 AS NUMBER(38,5)) AS umsatz_kdp_bby_loyalty
, CAST(0 AS NUMBER(38,5)) AS umsatz_bonrabatt_bby_non_loyalty
, CAST(0 AS NUMBER(38,5)) AS umsatz_bonrabatt_bby_loyalty
, CAST(0 AS NUMBER(38,5)) AS umsatz_bonrabatt

, CAST(0 AS NUMBER(38,5)) AS vk_menge_af_non_loyalty
, CAST(0 AS NUMBER(38,5)) AS vk_menge_af_loyalty
, CAST(0 AS NUMBER(38,5)) AS vk_menge_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby
, CAST(0 AS NUMBER(38,5)) AS vk_menge_af_non_exkl_schwarz_media_u_bonrabatt_bby
, CAST(0 AS NUMBER(38,5)) AS vk_menge_af_exkl_schwarz_media_u_bonrabatt_bby
, CAST(0 AS NUMBER(38,5)) AS vk_menge_af_loyalty_schwarz_media
, CAST(0 AS NUMBER(38,5)) AS vk_menge_sa_non_loyalty
, CAST(0 AS NUMBER(38,5)) AS vk_menge_sa_loyalty
, CAST(0 AS NUMBER(38,5)) AS vk_menge_bby_non_loyalty
, CAST(0 AS NUMBER(38,5)) AS vk_menge_bby_loyalty
, CAST(0 AS NUMBER(38,5)) AS vk_menge_kdn_bby_loyalty
, CAST(0 AS NUMBER(38,5)) AS vk_menge_kdp_bby_loyalty
, CAST(0 AS NUMBER(38,5)) AS vk_menge_bonrabatt_bby_non_loyalty
, CAST(0 AS NUMBER(38,5)) AS vk_menge_bonrabatt_bby_loyalty
, CAST(0 AS NUMBER(38,5)) AS vk_menge_bonrabatt 

, CASE WHEN v01.wv_grund_id = 2 THEN v01.abschriftbetrag_netto ELSE 0 END AS pv_aktion_sa_loyalty
, CAST(0 AS NUMBER(38,5)) AS pv_aktion_sa_loyalty_bby
, CAST(0 AS NUMBER(38,5)) AS pv_aktion_sa_loyalty_kdn_bby
, CAST(0 AS NUMBER(38,5)) AS pv_aktion_sa_loyalty_kdp_bby
, CASE WHEN v01.wv_grund_id = 0 THEN v01.abschriftbetrag_netto ELSE 0 END AS pv_aktion_sa_non_loyalty
, CAST(0 AS NUMBER(38,5)) AS pv_aktion_sa_non_loyalty_bby



, CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (52, 53, 54) 
       THEN v01.abschriftbetrag_netto
       WHEN v01.dat <  '2022-04-01' AND v01.wv_grund_id IN (52, 53, 54, 55)
       THEN v01.abschriftbetrag_netto 
       ELSE 0 END AS pv_bby_loyalty
, CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (56, 57, 58) 
       THEN v01.abschriftbetrag_netto 
       WHEN v01.dat <  '2022-04-01' AND v01.wv_grund_id IN (56, 57, 58, 59)  
       THEN v01.abschriftbetrag_netto 
       ELSE 0 END AS pv_bby_non_loyalty
, CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (60, 61, 62) 
       THEN v01.abschriftbetrag_netto
       WHEN v01.dat <  '2022-04-01' AND v01.wv_grund_id IN (60, 61, 62, 63)
       THEN v01.abschriftbetrag_netto ELSE 0 END AS pv_kdn_bby_loyalty
, CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (64, 65, 66, 73, 74, 75) 
       THEN v01.abschriftbetrag_netto
       WHEN v01.dat <  '2022-04-01' AND v01.wv_grund_id IN (64, 65, 66, 67) 
       THEN v01.abschriftbetrag_netto ELSE 0 END AS pv_kdp_bby_loyalty
    
, CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (59)  
       THEN v01.abschriftbetrag_netto 
       ELSE 0 END AS pv_bonrabatt_bby_non_loyalty
, CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (55,63,67,76) 
       THEN v01.abschriftbetrag_netto 
       ELSE 0 END AS pv_bonrabatt_bby_loyalty
, pv_bonrabatt_bby_non_loyalty + pv_bonrabatt_bby_loyalty AS pv_bonrabatt_bby


, CAST(0 AS NUMBER(38,5)) AS bonusbasis
, CAST(0 AS NUMBER(38,5)) AS bonusbasis_af
, CAST(0 AS NUMBER(38,5)) AS bonusbasis_sa
, CAST(0 AS NUMBER(38,5)) AS ek_mepol
, CAST(0 AS NUMBER(38,5)) AS ek_mepol_af
, CAST(0 AS NUMBER(38,5)) AS ek_mepol_sa


,pv_aktion_sa_loyalty + pv_aktion_sa_loyalty_bby + pv_aktion_sa_loyalty_kdn_bby     
                      + pv_aktion_sa_loyalty_kdp_bby + pv_aktion_sa_non_loyalty
                      + pv_aktion_sa_non_loyalty_bby + pv_bby_loyalty + pv_bby_non_loyalty
                      + pv_kdn_bby_loyalty + pv_kdp_bby_loyalty + pv_bonrabatt_bby
					  AS werbeabschrift_pv
,CASE WHEN v01.wv_grund_id IN (48,49) THEN v01.abschriftbetrag_netto END AS werbeabschrift_werbenachvermarktung_manuell
,CASE WHEN v01.wv_grund_id IN (20,21,23,50,70) THEN v01.abschriftbetrag_netto END AS werbeabschrift_aktionsanpassung_filiale
,v01.abschriftbetrag_netto - (werbeabschrift_pv + werbeabschrift_werbenachvermarktung_manuell + werbeabschrift_aktionsanpassung_filiale) AS werbeabschrift_rest
, CAST('' AS VARCHAR(80)) AS aktionsart_liste_id 
, CASE WHEN v01.wv_grund_id IN (60, 61, 62, 63) AND v01.abschriftart_id = -1  THEN 'KDN'
       WHEN v01.wv_grund_id IN (64, 65, 66, 67) AND v01.abschriftart_id = -1 THEN 'KDP'    
       WHEN  v01.wv_grund_id IN (73, 74, 75, 76) AND v01.abschriftart_id = -1 THEN 'KDX'
       ELSE CAST('' AS VARCHAR(80)) END AS aktion_typ_liste_id 

FROM DBP_DATA.MARKTABSCHRIFTEN_2 v01

LEFT JOIN
(SELECT
art_id
,gp_id
,wup_id
,dat_von
,dat_bis
FROM DBP_DATA.ART_GP_NM_ZU_PER_2
WHERE  mandant_id = 1
) v02

ON     v01.art_id = v02.art_id
AND v01.wup_id = v02.wup_id
AND v01.dat BETWEEN v02.dat_von
AND v02.dat_bis

LEFT JOIN t_wup_bereinigt v05
ON v01.dat = v05.dat
AND v01.mandant_id = v05.mandant_id 
AND v01.wup_id = v05.wup_id 

WHERE v01.mandant_id = 1
AND v01.abschriftart_id = -1
;
