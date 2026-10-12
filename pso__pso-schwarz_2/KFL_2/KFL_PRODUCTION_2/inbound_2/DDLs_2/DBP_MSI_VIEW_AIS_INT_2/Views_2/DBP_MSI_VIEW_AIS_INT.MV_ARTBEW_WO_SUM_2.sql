create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_AIS_INT.MV_ARTBEW_WO_SUM_2(
	KJWO_KL,
	ART_ID,
	MANDANT_ID,
	GP_ID,
	HERST_ID,
	NB_ID,
	WUP_ID,
	BEWART_ID,
	BEWART_DET_ID,
	POSTEN_ID_PER,
	POSTEN_KZ_PER,
	BEZUGSWEG_ID,
	AKTION_ID,
	WUP_BEREINIGT_FG,
	WUP_BEREINIGT_FG_VJ,
	WUP_BEREINIGT_FG_VJ_WO,
	EAN_KASSE,
	UMSATZ_MWST_BETRAG,
	UMSATZ_NETTO,
	VK_MENGE,
	VK_MENGE_NORM,
	EK_NETTO2_ABSATZ,
	EK_NETTO4_ABSATZ,
	EK_NETTO4_ABSATZ_EINSTANDSPREIS,
	UMSATZ_MWST_BETRAG_AF,
	UMSATZ_NETTO_AF,
	VK_MENGE_AF,
	VK_MENGE_AF_NORM,
	EK_NETTO2_ABSATZ_AF,
	EK_NETTO4_ABSATZ_AF,
	EK_NETTO4_ABSATZ_AF_EINSTANDSPREIS,
	UMSATZ_MWST_BETRAG_SA,
	UMSATZ_NETTO_SA,
	VK_MENGE_SA,
	VK_MENGE_SA_NORM,
	EK_NETTO2_ABSATZ_SA,
	EK_NETTO4_ABSATZ_SA,
	EK_NETTO4_ABSATZ_SA_EINSTANDSPREIS,
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
	EK_BRUTTO_ABSATZ,
	EK_BRUTTO_ABSATZ_AF,
	EK_BRUTTO_ABSATZ_SA,
	EK_GLD_ABSATZ,
	EK_GLD_ABSATZ_AF,
	EK_GLD_ABSATZ_SA,
	EK_NETTO3_ABSATZ,
	EK_NETTO3_ABSATZ_AF,
	EK_NETTO3_ABSATZ_SA,
	EK_NETTOBNK_ABSATZ,
	EK_NETTOBNK_ABSATZ_AF,
	EK_NETTOBNK_ABSATZ_SA,
	EK_NETTO_ABSATZ,
	EK_NETTO_ABSATZ_AF,
	EK_NETTO_ABSATZ_SA,
	LOGKOSTENZUSCHLAG,
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
	WERBEABSCHRIFT_REST,
	AKTIONSART_LISTE_ID,
	AKTION_TYP_LISTE_ID
) as



WITH t_wup_bereinigt AS(
    SELECT DISTINCT 
        v01.KJWO_KL, 
        v02.mandant_id,
        v02.wup_id,
        
        CASE WHEN (v01.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v01.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_akt,
        CASE WHEN (v04.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v04.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_vj_wo,
        CASE WHEN v01.dat LIKE '%-02-29' 
            THEN wup_bereinigt_fg_vj_wo
        
        WHEN  (v03.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v03.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) 
            THEN 1 
        ELSE 0 END AS wup_bereinigt_fg_vj
    FROM DBP_DATA.TAG_2 v01
     JOIN DBP_DATA.WUP_2 v02
        ON (v01.dat >= COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung))
    LEFT JOIN DBP_DATA.TAG_2 v03
        ON (v01.dat = v03.dat_vj_kt)
    LEFT JOIN DBP_DATA.TAG_2 v04
        ON (v01.dat = v04.dat_vj)
    WHERE v01.dat BETWEEN '2019-01-01' AND CURRENT_DATE()+7
        AND v02.nb_id = 0
)




SELECT
v01.kjwo_kl,
v01.art_id,
v01.mandant_id,
v01.gp_id,
v01.herst_id,
v01.nb_id,
v01.wup_id,
v01.bewart_id,
v01.bewart_det_id,
CAST(CASE WHEN v01.bewart_id = 1001 AND v01.posten_id NOT IN ('PN', 'PF', 'SP', '1') THEN 'SO' ELSE 'PN' END AS VARCHAR(2)) AS posten_id_per,
CASE WHEN v01.posten_id NOT IN ('PN', 'PF', 'SP','1') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS posten_kz_per,
v01.bezugsweg_id,

COALESCE (v01.standard_aktion_id, v01.aktion_id, '0') AS aktion_id,
v03.wup_bereinigt_fg_akt AS wup_bereinigt_fg,
v03.wup_bereinigt_fg_vj,
v03.wup_bereinigt_fg_vj_wo,
(CASE WHEN v01.ean_kasse BETWEEN 100000 AND 999999 THEN  v01.ean_kasse * 10000000 
 ELSE v01.ean_kasse END ) AS ean_kasse,

CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMBER(38,5))
ELSE CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) END umsatz_mwst_betrag,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
ELSE CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_netto,
CAST(v01.menge AS NUMBER(38,5)) AS vk_menge,



CASE
WHEN v01.mandant_id = 1 AND v04.basismenge_einh_id = 'ST' AND v04.einh_id = 'G'     THEN  menge * (v04.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v04.basismenge_einh_id = 'ST' AND v04.einh_id = 'KG'    THEN  menge *  v04.faktor_nettoinhalt
WHEN v01.mandant_id = 1 AND v04.basismenge_einh_id = 'ST' AND v04.einh_id = 'ML'    THEN  menge * (v04.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v04.basismenge_einh_id = 'ST' AND v04.einh_id = 'L'     THEN  menge *  v04.faktor_nettoinhalt

WHEN v01.mandant_id > 1 AND v04.basismenge_einh_id = 'ST' AND v04.inhalt_menge_einh_id = 'G'    THEN  menge * (v04.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v04.basismenge_einh_id = 'ST' AND v04.inhalt_menge_einh_id = 'KG'   THEN  menge *  v04.inhalt_menge
WHEN v01.mandant_id > 1 AND v04.basismenge_einh_id = 'ST' AND v04.inhalt_menge_einh_id = 'ML'   THEN  menge * (v04.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v04.basismenge_einh_id = 'ST' AND v04.inhalt_menge_einh_id = 'L'    THEN  menge *  v04.inhalt_menge

WHEN v04.basismenge_einh_id = 'KG' THEN menge
ELSE 0 END AS vk_menge_norm,

CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_ek_nettonetto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.ek_nettonetto * v01.umrechnungskurs_hist AS NUMBER(38,5))
ELSE CAST(v01.ek_nettonetto AS NUMBER(38,5)) END ek_netto2_absatz,

CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_einstandspreis_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.ek_mep * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 THEN CAST(v01.ek_mep AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.mandant_id = 1 THEN CAST(v01.ek_mep AS NUMBER(38,5)) 
ELSE CAST(v01.einstandspreis AS NUMBER(38,5)) END ek_netto4_absatz,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_einstandspreis_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.einstandspreis * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 THEN CAST(v01.einstandspreis AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.mandant_id = 1 THEN CAST(v01.einstandspreis AS NUMBER(38,5)) 
ELSE CAST(v01.einstandspreis AS NUMBER(38,5)) END ek_netto4_absatz_einstandspreis,

CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) END umsatz_mwst_betrag_af,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_netto_af,
CASE
WHEN v01.bewart_id IN(1001,1010) THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_af,



CASE
WHEN v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) AND v04.basismenge_einh_id = 'ST' AND v04.einh_id = 'G'     THEN  menge * (v04.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) AND v04.basismenge_einh_id = 'ST' AND v04.einh_id = 'KG'    THEN  menge *  v04.faktor_nettoinhalt
WHEN v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) AND v04.basismenge_einh_id = 'ST' AND v04.einh_id = 'ML'    THEN  menge * (v04.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) AND v04.basismenge_einh_id = 'ST' AND v04.einh_id = 'L'     THEN  menge *  v04.faktor_nettoinhalt

WHEN v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) AND v04.basismenge_einh_id = 'ST' AND v04.inhalt_menge_einh_id = 'G'    THEN  menge * (v04.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) AND v04.basismenge_einh_id = 'ST' AND v04.inhalt_menge_einh_id = 'KG'   THEN  menge *  v04.inhalt_menge
WHEN v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) AND v04.basismenge_einh_id = 'ST' AND v04.inhalt_menge_einh_id = 'ML'   THEN  menge * (v04.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) AND v04.basismenge_einh_id = 'ST' AND v04.inhalt_menge_einh_id = 'L'    THEN  menge *  v04.inhalt_menge

WHEN v01.bewart_id IN(1001,1010) AND v04.basismenge_einh_id = 'KG' THEN menge
ELSE 0 END AS vk_menge_af_norm,

CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_ek_nettonetto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_nettonetto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_nettonetto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_nettonetto AS NUMBER(38,5)) END ek_netto2_absatz_af,

CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_einstandspreis_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_mep * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_mep AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_mep AS NUMBER(38,5)) 
WHEN v02.wrg_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.einstandspreis AS NUMBER(38,5)) END ek_netto4_absatz_af,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_einstandspreis_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.einstandspreis * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.einstandspreis AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.einstandspreis AS NUMBER(38,5)) 
WHEN v02.wrg_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.einstandspreis AS NUMBER(38,5)) END ek_netto4_absatz_af_einstandspreis,

CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) END umsatz_mwst_betrag_sa,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_netto_sa,
CASE
WHEN v01.bewart_id = 1002 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_sa,



CASE
WHEN v01.mandant_id = 1 AND v01.bewart_id = 1002 AND v04.basismenge_einh_id = 'ST' AND v04.einh_id = 'G'     THEN  menge * (v04.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.bewart_id = 1002 AND v04.basismenge_einh_id = 'ST' AND v04.einh_id = 'KG'    THEN  menge *  v04.faktor_nettoinhalt
WHEN v01.mandant_id = 1 AND v01.bewart_id = 1002 AND v04.basismenge_einh_id = 'ST' AND v04.einh_id = 'ML'    THEN  menge * (v04.faktor_nettoinhalt / 1000)
WHEN v01.mandant_id = 1 AND v01.bewart_id = 1002 AND v04.basismenge_einh_id = 'ST' AND v04.einh_id = 'L'     THEN  menge *  v04.faktor_nettoinhalt

WHEN v01.mandant_id > 1 AND v01.bewart_id = 1002 AND v04.basismenge_einh_id = 'ST' AND v04.inhalt_menge_einh_id = 'G'    THEN  menge * (v04.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.bewart_id = 1002 AND v04.basismenge_einh_id = 'ST' AND v04.inhalt_menge_einh_id = 'KG'   THEN  menge *  v04.inhalt_menge
WHEN v01.mandant_id > 1 AND v01.bewart_id = 1002 AND v04.basismenge_einh_id = 'ST' AND v04.inhalt_menge_einh_id = 'ML'   THEN  menge * (v04.inhalt_menge / 1000)
WHEN v01.mandant_id > 1 AND v01.bewart_id = 1002 AND v04.basismenge_einh_id = 'ST' AND v04.inhalt_menge_einh_id = 'L'    THEN  menge *  v04.inhalt_menge

WHEN v01.bewart_id = 1002 AND v04.basismenge_einh_id = 'KG' THEN menge
ELSE 0 END AS vk_menge_sa_norm,

CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_ek_nettonetto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_nettonetto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_nettonetto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_nettonetto AS NUMBER(38,5)) END ek_netto2_absatz_sa,

CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_einstandspreis_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.einstandspreis AS NUMBER(38,5)) END ek_netto4_absatz_sa,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_einstandspreis_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.einstandspreis * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.einstandspreis AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.einstandspreis AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.einstandspreis AS NUMBER(38,5)) END ek_netto4_absatz_sa_einstandspreis,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_det_id IN (100110,100130) THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_det_id IN (100110,100130) THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_det_id IN (100110,100130) THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100110,100130) THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_af_non_loyalty,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_det_id IN (100111,100121,100131) THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_det_id IN (100111,100121,100131) THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_det_id IN (100111,100121,100131) THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100111,100121,100131) THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_af_loyalty,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100111 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100111 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_det_id = 100111 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100111 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
ELSE CAST(0 AS NUMBER(38,5)) END umsatz_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100110 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100110 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_det_id = 100110 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100110 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) 
ELSE CAST(0 AS NUMBER(38,5)) END umsatz_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
umsatz_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby + umsatz_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby AS umsatz_af_exkl_schwarz_media_u_bonrabatt_bby,

CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100121 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100121 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_det_id = 100121 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100121 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_af_loyalty_schwarz_media,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100210 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100210 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_det_id = 100210 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100210 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_sa_non_loyalty,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100211 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100211 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_det_id = 100211 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100211 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_sa_loyalty,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100220 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100220 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_det_id = 100220 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100220 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_bby_non_loyalty,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100221 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100221 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_det_id = 100221 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100221 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_bby_loyalty,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100231 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100231 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_det_id = 100231 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100231 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_kdn_bby_loyalty,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100241 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100241 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_det_id = 100241 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100241 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_kdp_bby_loyalty,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100130 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100130 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_det_id = 100130 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100130 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
ELSE CAST(0 AS NUMBER(38,5)) END umsatz_bonrabatt_bby_non_loyalty,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100131 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_det_id = 100131 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_det_id = 100131 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100131 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) 
ELSE CAST(0 AS NUMBER(38,5)) END umsatz_bonrabatt_bby_loyalty,
umsatz_bonrabatt_bby_loyalty + umsatz_bonrabatt_bby_non_loyalty AS  umsatz_bonrabatt_bby,
CASE
WHEN v01.bewart_det_id IN (100110,100130) THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_af_non_loyalty,
CASE
WHEN v01.bewart_det_id IN (100111,100121,100131) THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_af_loyalty,
CASE
WHEN v01.bewart_det_id = 100111 THEN CAST(v01.menge AS NUMBER(38,5))
ELSE CAST(0 AS NUMBER(38,5)) END vk_menge_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
CASE
WHEN v01.bewart_det_id = 100110 THEN CAST(v01.menge AS NUMBER(38,5))
ELSE CAST(0 AS NUMBER(38,5)) END vk_menge_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
vk_menge_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby + vk_menge_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby AS vk_menge_af_exkl_schwarz_media_u_bonrabatt_bby,
CASE
WHEN v01.bewart_det_id = 100121 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_af_loyalty_schwarz_media,
CASE
WHEN v01.bewart_det_id = 100210 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_sa_non_loyalty,
CASE
WHEN v01.bewart_det_id = 100211 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_sa_loyalty,
CASE
WHEN v01.bewart_det_id = 100220 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_bby_non_loyalty,
CASE
WHEN v01.bewart_det_id = 100221 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_bby_loyalty,
CASE
WHEN v01.bewart_det_id = 100231 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_kdn_bby_loyalty,
CASE
WHEN v01.bewart_det_id = 100241 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_kdp_bby_loyalty,
CASE
WHEN v01.bewart_det_id = 100130 THEN CAST(v01.menge AS NUMBER(38,5))
ELSE CAST(0 AS NUMBER(38,5)) END vk_menge_bonrabatt_bby_non_loyalty,
CASE
WHEN v01.bewart_det_id = 100131 THEN CAST(v01.menge AS NUMBER(38,5))
ELSE CAST(0 AS NUMBER(38,5)) END vk_menge_bonrabatt_bby_loyalty,
vk_menge_bonrabatt_bby_non_loyalty + vk_menge_bonrabatt_bby_loyalty AS vk_menge_bonrabatt_bby

,CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_ek_brutto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.ek_brutto * v01.umrechnungskurs_hist AS NUMBER(38,5))
ELSE CAST(v01.ek_brutto AS NUMBER(38,5)) END ek_brutto_absatz
,CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_ek_brutto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_brutto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_brutto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_brutto AS NUMBER(38,5)) END ek_brutto_absatz_af
,CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_ek_brutto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_brutto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_brutto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_brutto AS NUMBER(38,5)) END ek_brutto_absatz_sa
,CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_ek_gld_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.ek_gld * v01.umrechnungskurs_hist AS NUMBER(38,5))
ELSE CAST(v01.ek_gld AS NUMBER(38,5)) END ek_gld_absatz
,CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_ek_gld_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_gld * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_gld AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_gld AS NUMBER(38,5)) END ek_gld_absatz_af
,CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_ek_gld_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_gld * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_gld AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_gld AS NUMBER(38,5)) END ek_gld_absatz_sa
,CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_ek_mep_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.ek_mep * v01.umrechnungskurs_hist AS NUMBER(38,5))
ELSE CAST(v01.ek_mep AS NUMBER(38,5)) END ek_netto3_absatz
,CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_ek_mep_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_mep * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_mep AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_mep AS NUMBER(38,5)) END ek_netto3_absatz_af
,CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_ek_mep_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep AS NUMBER(38,5)) END ek_netto3_absatz_sa
,CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_ek_netto_bnk_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.ek_netto_bnk * v01.umrechnungskurs_hist AS NUMBER(38,5))
ELSE CAST(v01.ek_netto_bnk AS NUMBER(38,5)) END ek_nettobnk_absatz
,CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_ek_netto_bnk_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_netto_bnk * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_netto_bnk AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_netto_bnk AS NUMBER(38,5)) END ek_nettobnk_absatz_af
,CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_ek_netto_bnk_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_netto_bnk * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_netto_bnk AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_netto_bnk AS NUMBER(38,5)) END ek_nettobnk_absatz_sa
,CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_ek_netto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.ek_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
ELSE CAST(v01.ek_netto AS NUMBER(38,5)) END ek_netto_absatz
,CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_ek_netto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_netto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_netto AS NUMBER(38,5)) END ek_netto_absatz_af
,CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_ek_netto_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_netto AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_netto AS NUMBER(38,5)) END ek_netto_absatz_sa
,CASE
WHEN v01.mandant_id = 1 THEN v01.logkostenzuschlag END logkostenzuschlag,

CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.ek_mep_vor_fwu_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.ek_mep_vor_fwu * v01.umrechnungskurs_hist AS NUMBER(38,5))
ELSE CAST(v01.ek_mep_vor_fwu AS NUMBER(38,5)) END ek_mepol,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id IN (1001,1010) THEN CAST(v01.ek_mep_vor_fwu_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id IN (1001,1010) THEN CAST(v01.ek_mep_vor_fwu * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN (1001,1010) THEN CAST(v01.ek_mep_vor_fwu AS NUMBER(38,5)) END ek_mepol_af,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep_vor_fwu_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep_vor_fwu * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep_vor_fwu AS NUMBER(38,5)) END ek_mepol_sa,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.bonusbasis_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.bonusbasis * v01.umrechnungskurs_hist AS NUMBER(38,5))
ELSE CAST(v01.bonusbasis AS NUMBER(38,5)) END bonusbasis,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0  AND v01.bewart_id IN (1001,1010) THEN CAST(v01.bonusbasis_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1  AND v01.bewart_id IN (1001,1010) THEN CAST(v01.bonusbasis * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN (1001,1010) THEN CAST(v01.bonusbasis AS NUMBER(38,5)) END bonusbasis_af,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0  AND v01.bewart_id = 1002 THEN CAST(v01.bonusbasis_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1  AND v01.bewart_id = 1002 THEN CAST(v01.bonusbasis * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.bonusbasis AS NUMBER(38,5)) END ek_bonusbasis_sa,


CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id = 100211 THEN CAST(v01.pv_aktion_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id = 100211 THEN CAST(v01.pv_aktion * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100211 THEN CAST(v01.pv_aktion AS NUMBER(38,5)) END pv_aktion_sa_loyalty,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id IN (100221, 100211) THEN CAST(v01.pv_aktion_bby_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id IN (100221, 100211) THEN CAST(v01.pv_aktion_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100221, 100211) THEN CAST(v01.pv_aktion_bby AS NUMBER(38,5)) END pv_aktion_sa_loyalty_bby,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id IN (100231, 100221, 100211) THEN CAST(v01.pv_aktion_kdn_bby_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id IN (100231, 100221, 100211) THEN CAST(v01.pv_aktion_kdn_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100231, 100221, 100211) THEN CAST(v01.pv_aktion_kdn_bby AS NUMBER(38,5)) END pv_aktion_sa_loyalty_kdn_bby,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id IN (100241, 100231, 100221, 100211) THEN CAST(v01.pv_aktion_kdp_bby_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id IN (100241, 100231, 100221, 100211) THEN CAST(v01.pv_aktion_kdp_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100241, 100231, 100221, 100211) THEN CAST(v01.pv_aktion_kdp_bby AS NUMBER(38,5)) END pv_aktion_sa_loyalty_kdp_bby,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id = 100210 THEN CAST(v01.pv_aktion_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id = 100210 THEN CAST(v01.pv_aktion * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100210 THEN CAST(v01.pv_aktion AS NUMBER(38,5)) END pv_aktion_sa_non_loyalty,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id IN (100220, 100210) THEN CAST(v01.pv_aktion_bby_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id IN (100220, 100210) THEN CAST(v01.pv_aktion_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100220, 100210) THEN CAST(v01.pv_aktion_bby AS NUMBER(38,5)) END pv_aktion_sa_non_loyalty_bby,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id IN (100221,100231,100241) THEN CAST(v01.pv_bby_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id IN (100221,100231,100241) THEN CAST(v01.pv_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100221,100231,100241) THEN CAST(v01.pv_bby AS NUMBER(38,5)) END pv_bby_loyalty,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id = 100220 THEN CAST(v01.pv_bby_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id = 100220 THEN CAST(v01.pv_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100220 THEN CAST(v01.pv_bby AS NUMBER(38,5)) END pv_bby_non_loyalty,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id IN (100231, 100241) THEN CAST(v01.pv_kdn_bby_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id IN (100231, 100241) THEN CAST(v01.pv_kdn_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100231, 100241) THEN CAST(v01.pv_kdn_bby AS NUMBER(38,5)) END pv_kdn_bby_loyalty,
CASE 
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0  THEN CAST(v01.pv_kdp_bby_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.pv_kdp_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1  THEN CAST(v01.pv_kdp_bby AS NUMBER(38,5)) END pv_kdp_bby_loyalty,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id IN (100210,100220, 100130) THEN CAST(v01.pv_bonrabatt_bby_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id IN (100210,100220, 100130) THEN CAST(v01.pv_bonrabatt_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100210,100220, 100130) THEN CAST(v01.pv_bonrabatt_bby AS NUMBER(38,5)) 
ELSE CAST(0 AS NUMBER(38,5)) END pv_bonrabatt_bby_non_loyalty,
CASE
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id IN (100211, 100221, 100231, 100241,100131) THEN CAST(v01.pv_bonrabatt_bby_konz AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id IN (100211, 100221, 100231, 100241,100131) THEN CAST(v01.pv_bonrabatt_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100211, 100221, 100231, 100241,100131) THEN CAST(v01.pv_bonrabatt_bby AS NUMBER(38,5)) 
ELSE CAST(0 AS NUMBER(38,5)) END pv_bonrabatt_bby_loyalty,
pv_bonrabatt_bby_non_loyalty + pv_bonrabatt_bby_loyalty AS pv_bonrabatt_bby


,COALESCE(pv_aktion_sa_loyalty,0) + COALESCE(pv_aktion_sa_loyalty_bby,0) + COALESCE(pv_aktion_sa_loyalty_kdn_bby,0)     
                      + COALESCE(pv_aktion_sa_loyalty_kdp_bby,0) + COALESCE(pv_aktion_sa_non_loyalty,0)
                      + COALESCE(pv_aktion_sa_non_loyalty_bby,0) + COALESCE(pv_bby_loyalty,0) + COALESCE(pv_bby_non_loyalty,0)
                      + COALESCE(pv_kdn_bby_loyalty,0) + COALESCE(pv_kdp_bby_loyalty,0) + COALESCE(pv_bonrabatt_bby,0)
					  AS werbeabschrift_pv
,CAST (0 AS NUMBER(38,5)) AS werbeabschrift_werbenachvermarktung_manuell
,CAST (0 AS NUMBER(38,5)) AS werbeabschrift_aktionsanpassung_filiale
,CAST (0 AS NUMBER(38,5)) AS werbeabschrift_rest

,v01.aktionsart_liste_id AS aktionsart_liste_id 
,v01.aktion_typ_liste_id AS aktion_typ_liste_id

FROM DBP_DATA.ARTBEW_WO_SUM_2 v01

CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v02

LEFT JOIN t_wup_bereinigt v03
ON v01.KJWO_KL = v03.KJWO_KL 
AND v01.mandant_id = v03.mandant_id 
AND v01.wup_id = v03.wup_id


JOIN DBP_DATA.ART_2 v04
ON v01.mandant_id = v04.mandant_id
AND v01.art_id = v04.art_id


WHERE NOT (v01.mandant_id = 5 AND v01.art_id = 206731500)

   AND NOT (v01.mandant_id = 2 AND v01.art_id = 208124500)
   AND NOT (v01.mandant_id = 3 AND v01.art_id = 208113690)
   AND NOT (v01.mandant_id = 6 AND v01.art_id = 208131570)
   AND NOT (v01.mandant_id IN (4,7) AND v01.art_id = 208114740)
   AND NOT (v01.mandant_id = 8 AND v01.art_id = 208131640)



UNION ALL 

SELECT
KJWO_KL,
	ART_ID,
	MANDANT_ID,
	GP_ID,
	HERST_ID,
	NB_ID,
	WUP_ID,
	BEWART_ID,
	BEWART_DET_ID,
	POSTEN_ID_PER,
	POSTEN_KZ_PER,
	BEZUGSWEG_ID,
	AKTION_ID,
	WUP_BEREINIGT_FG,
	WUP_BEREINIGT_FG_VJ,
	WUP_BEREINIGT_FG_VJ_WO,
	EAN_KASSE,
	UMSATZ_MWST_BETRAG,
	UMSATZ_NETTO,
	VK_MENGE,
	VK_MENGE_NORM,
	EK_NETTO2_ABSATZ,
	EK_NETTO4_ABSATZ,
	EK_NETTO4_ABSATZ_EINSTANDSPREIS,
	UMSATZ_MWST_BETRAG_AF,
	UMSATZ_NETTO_AF,
	VK_MENGE_AF,
	VK_MENGE_AF_NORM,
	EK_NETTO2_ABSATZ_AF,
	EK_NETTO4_ABSATZ_AF,
	EK_NETTO4_ABSATZ_AF_EINSTANDSPREIS,
	UMSATZ_MWST_BETRAG_SA,
	UMSATZ_NETTO_SA,
	VK_MENGE_SA,
	VK_MENGE_SA_NORM,
	EK_NETTO2_ABSATZ_SA,
	EK_NETTO4_ABSATZ_SA,
	EK_NETTO4_ABSATZ_SA_EINSTANDSPREIS,
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
	EK_BRUTTO_ABSATZ,
	EK_BRUTTO_ABSATZ_AF,
	EK_BRUTTO_ABSATZ_SA,
	EK_GLD_ABSATZ,
	EK_GLD_ABSATZ_AF,
	EK_GLD_ABSATZ_SA,
	EK_NETTO3_ABSATZ,
	EK_NETTO3_ABSATZ_AF,
	EK_NETTO3_ABSATZ_SA,
	EK_NETTOBNK_ABSATZ,
	EK_NETTOBNK_ABSATZ_AF,
	EK_NETTOBNK_ABSATZ_SA,
	EK_NETTO_ABSATZ,
	EK_NETTO_ABSATZ_AF,
	EK_NETTO_ABSATZ_SA,
	LOGKOSTENZUSCHLAG,
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
	WERBEABSCHRIFT_REST,
	AKTIONSART_LISTE_ID,
    AKTION_TYP_LISTE_ID 

FROM DBP_MSI_VIEW_AIS_INT.TBL_MV_ARTBEW_WO_SUM_2 v01;
