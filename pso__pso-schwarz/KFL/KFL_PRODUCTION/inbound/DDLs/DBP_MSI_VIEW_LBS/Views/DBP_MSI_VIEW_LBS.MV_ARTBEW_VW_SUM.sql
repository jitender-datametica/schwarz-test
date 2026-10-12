create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LBS.MV_ARTBEW_VW_SUM(
	DAT,
	ART_ID,
	MANDANT_ID,
	GP_ID,
	HERST_ID,
	VW_ID,
	BEWART_ID,
	BEZUGSWEG_ID,
	EAN_KASSE,
	POSTEN_ID_PER,
	POSTEN_KZ_PER,
	UMSATZ_MWST_BETRAG,
	UMSATZ_NETTO,
	VK_MENGE,
	VK_MENGE_NORM,
	EK_NETTO2_ABSATZ,
	EK_NETTO3_ABSATZ,
	EK_NETTO4_ABSATZ,
	UMSATZ_MWST_BETRAG_AF,
	UMSATZ_NETTO_AF,
	VK_MENGE_AF,
	VK_MENGE_AF_NORM,
	EK_NETTO2_ABSATZ_AF,
	EK_NETTO3_ABSATZ_AF,
	EK_NETTO4_ABSATZ_AF,
	UMSATZ_MWST_BETRAG_SA,
	UMSATZ_NETTO_SA,
	VK_MENGE_SA,
	VK_MENGE_SA_NORM,
	EK_NETTO2_ABSATZ_SA,
	EK_NETTO3_ABSATZ_SA,
	EK_NETTO4_ABSATZ_SA,
	EK_BRUTTO_ABSATZ,
	EK_BRUTTO_ABSATZ_AF,
	EK_BRUTTO_ABSATZ_SA,
	EK_GLD_ABSATZ,
	EK_GLD_ABSATZ_AF,
	EK_GLD_ABSATZ_SA,
	EK_NETTOBNK_ABSATZ,
	EK_NETTOBNK_ABSATZ_AF,
	EK_NETTOBNK_ABSATZ_SA,
	EK_NETTO_ABSATZ,
	EK_NETTO_ABSATZ_AF,
	EK_NETTO_ABSATZ_SA,
	LOGKOSTENZUSCHLAG,
	LOGKOSTENZUSCHLAG_AF,
	LOGKOSTENZUSCHLAG_SA,
	EK_MEPOL,
	EK_MEPOL_AF,
	EK_MEPOL_SA,
	BONUSBASIS,
	BONUSBASIS_AF,
	BONUSBASIS_SA
) as
SELECT 
    v01.dat,
    v01.art_id,
    v01.mandant_id,
    v01.gp_id,
    v01.herst_id,
    v01.vw_id,
    v01.bewart_id,
    v01.bezugsweg_id,
    (CASE WHEN v01.ean_kasse BETWEEN 100000 AND 999999 THEN  v01.ean_kasse * 10000000 
    ELSE v01.ean_kasse END ) AS ean_kasse,
    CAST(CASE WHEN v01.bewart_id = 1001 AND v04.posten_id NOT IN ('PN', 'PF', 'SP', '1') THEN 'SO' ELSE 'PN' END AS VARCHAR(2)) AS posten_id_per,
    CASE
        WHEN v04.POSTEN_ID NOT IN ('PN', 'PF', 'SP','1') THEN 'SO'
        ELSE 'PN'
        END :: CHAR(2) AS POSTEN_KZ_PER,
    CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMBER(38,5))
	ELSE CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) END AS umsatz_mwst_betrag,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
	ELSE CAST(v01.umsatz_netto AS NUMBER(38,5)) END AS umsatz_netto,
    CAST(v01.menge AS NUMBER(38,5)) AS vk_menge,

    
    
    CASE
    WHEN v01.mandant_id = 1 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'G'     THEN  menge * (v05.faktor_nettoinhalt / 1000)
    WHEN v01.mandant_id = 1 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'KG'    THEN  menge *  v05.faktor_nettoinhalt
    WHEN v01.mandant_id = 1 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'ML'    THEN  menge * (v05.faktor_nettoinhalt / 1000)
    WHEN v01.mandant_id = 1 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'L'     THEN  menge *  v05.faktor_nettoinhalt
    
    WHEN v01.mandant_id > 1 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'G'    THEN  menge * (v05.inhalt_menge / 1000)
    WHEN v01.mandant_id > 1 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'KG'   THEN  menge *  v05.inhalt_menge
    WHEN v01.mandant_id > 1 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'ML'   THEN  menge * (v05.inhalt_menge / 1000)
    WHEN v01.mandant_id > 1 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'L'    THEN  menge *  v05.inhalt_menge
    
    WHEN v05.basismenge_einh_id = 'KG' THEN menge
    ELSE 0 END AS vk_menge_norm,

	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_ek_nettonetto_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.ek_nettonetto * v01.umrechnungskurs_hist AS NUMBER(38,5))
	ELSE CAST(v01.ek_nettonetto AS NUMBER(38,5)) END AS ek_netto2_absatz,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_ek_mep_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.ek_mep * v01.umrechnungskurs_hist AS NUMBER(38,5))
	ELSE CAST (v01.ek_mep AS NUMBER(38,5)) END AS ek_netto3_absatz,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_einstandspreis_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.ek_mep * v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 THEN CAST(v01.ek_mep AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.mandant_id = 1 THEN CAST(v01.ek_mep AS NUMBER(38,5))
	ELSE CAST(v01.einstandspreis AS NUMBER(38,5)) END AS ek_netto4_absatz,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) END AS umsatz_mwst_betrag_af,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END AS umsatz_netto_af,
    CASE
        WHEN v01.bewart_id IN(1001, 1010) THEN CAST(v01.menge AS NUMBER(38,5))
    END vk_menge_af,

    
    
    CASE
    WHEN v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'G'     THEN  menge * (v05.faktor_nettoinhalt / 1000)
    WHEN v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'KG'    THEN  menge *  v05.faktor_nettoinhalt
    WHEN v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'ML'    THEN  menge * (v05.faktor_nettoinhalt / 1000)
    WHEN v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'L'     THEN  menge *  v05.faktor_nettoinhalt
    
    WHEN v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'G'    THEN  menge * (v05.inhalt_menge / 1000)
    WHEN v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'KG'   THEN  menge *  v05.inhalt_menge
    WHEN v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'ML'   THEN  menge * (v05.inhalt_menge / 1000)
    WHEN v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'L'    THEN  menge *  v05.inhalt_menge
    
    WHEN v01.bewart_id IN(1001,1010) AND v05.basismenge_einh_id = 'KG' THEN menge
    ELSE 0 END AS vk_menge_af_norm,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_ek_nettonetto_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_nettonetto * v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_nettonetto AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_nettonetto AS NUMBER(38,5)) END AS ek_netto2_absatz_af,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_ek_mep_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_mep * v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_mep AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_mep AS NUMBER(38,5)) END AS ek_netto3_absatz_af,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_einstandspreis_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_mep * v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_mep AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_mep AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.einstandspreis AS NUMBER(38,5)) END AS ek_netto4_absatz_af,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) END AS umsatz_mwst_betrag_sa,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END AS umsatz_netto_sa,
    CASE
        WHEN v01.bewart_id = 1002 THEN CAST(v01.menge AS NUMBER(38,5))
    END vk_menge_sa,

    
    
    CASE
    WHEN v01.mandant_id = 1 AND v01.bewart_id = 1002 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'G'     THEN  menge * (v05.faktor_nettoinhalt / 1000)
    WHEN v01.mandant_id = 1 AND v01.bewart_id = 1002 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'KG'    THEN  menge *  v05.faktor_nettoinhalt
    WHEN v01.mandant_id = 1 AND v01.bewart_id = 1002 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'ML'    THEN  menge * (v05.faktor_nettoinhalt / 1000)
    WHEN v01.mandant_id = 1 AND v01.bewart_id = 1002 AND v05.basismenge_einh_id = 'ST' AND v05.einh_id = 'L'     THEN  menge *  v05.faktor_nettoinhalt
    
    WHEN v01.mandant_id > 1 AND v01.bewart_id = 1002 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'G'    THEN  menge * (v05.inhalt_menge / 1000)
    WHEN v01.mandant_id > 1 AND v01.bewart_id = 1002 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'KG'   THEN  menge *  v05.inhalt_menge
    WHEN v01.mandant_id > 1 AND v01.bewart_id = 1002 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'ML'   THEN  menge * (v05.inhalt_menge / 1000)
    WHEN v01.mandant_id > 1 AND v01.bewart_id = 1002 AND v05.basismenge_einh_id = 'ST' AND v05.inhalt_menge_einh_id = 'L'    THEN  menge *  v05.inhalt_menge
    
    WHEN v01.bewart_id = 1002 AND v05.basismenge_einh_id = 'KG' THEN menge
    ELSE 0 END AS vk_menge_sa_norm,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_ek_nettonetto_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_nettonetto *v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_nettonetto AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_nettonetto AS NUMBER(38,5)) END AS ek_netto2_absatz_sa,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_ek_mep_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep *v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep AS NUMBER(38,5)) END AS ek_netto3_absatz_sa,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_einstandspreis_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep *v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.einstandspreis AS NUMBER(38,5)) END AS ek_netto4_absatz_sa,
		
		CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_ek_brutto_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.ek_brutto * v01.umrechnungskurs_hist AS NUMBER(38,5))
	ELSE CAST(v01.ek_brutto AS NUMBER(38,5)) END AS ek_brutto_absatz,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_ek_brutto_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_brutto * v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_brutto AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_brutto AS NUMBER(38,5)) END AS ek_brutto_absatz_af,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_ek_brutto_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_brutto *v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_brutto AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_brutto AS NUMBER(38,5)) END AS ek_brutto_absatz_sa,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_ek_gld_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.ek_gld * v01.umrechnungskurs_hist AS NUMBER(38,5))
	ELSE CAST(v01.ek_gld AS NUMBER(38,5)) END ek_gld_absatz,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_ek_gld_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_gld * v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_gld AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_gld AS NUMBER(38,5)) END ek_gld_absatz_af,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_ek_gld_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_gld * v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_gld AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_gld AS NUMBER(38,5)) END ek_gld_absatz_sa,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_ek_netto_bnk_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.ek_netto_bnk * v01.umrechnungskurs_hist AS NUMBER(38,5))
	ELSE CAST(v01.ek_netto_bnk AS NUMBER(38,5)) END AS ek_nettobnk_absatz,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_ek_netto_bnk_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_netto_bnk * v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_netto_bnk AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_netto_bnk AS NUMBER(38,5)) END AS ek_nettobnk_absatz_af,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_ek_netto_bnk_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_netto_bnk *v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_netto_bnk AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_netto_bnk AS NUMBER(38,5)) END AS ek_nettobnk_absatz_sa,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_ek_netto_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.ek_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
	ELSE CAST(v01.ek_netto AS NUMBER(38,5)) END AS ek_netto_absatz,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_ek_netto_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_netto AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_netto AS NUMBER(38,5)) END AS ek_netto_absatz_af,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_ek_netto_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_netto *v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_netto AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_netto AS NUMBER(38,5)) END AS ek_netto_absatz_sa,
	
	CASE WHEN v01.mandant_id = 1 THEN v01.logkostenzuschlag END logkostenzuschlag,
	CASE WHEN v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN v01.logkostenzuschlag END logkostenzuschlag_AF,
    CASE WHEN v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN v01.logkostenzuschlag END logkostenzuschlag_SA,
		
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
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id IN (1001,1010) THEN CAST(v01.bonusbasis_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id IN (1001,1010) THEN CAST(v01.bonusbasis * v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN (1001,1010) THEN CAST(v01.bonusbasis AS NUMBER(38,5)) END bonusbasis_af,
	CASE
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id = 1002 THEN CAST(v01.bonusbasis_konz AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.bonusbasis * v01.umrechnungskurs_hist AS NUMBER(38,5))
	WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.bonusbasis AS NUMBER(38,5)) END bonusbasis_sa,

    FROM DBP_DATA.ARTBEW_VW_SUM v01
    
    CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v02 
    
    LEFT JOIN DBP_DATA.ART_PER v04
    ON v01.art_id = v04.art_id
    AND v01.mandant_id = v04.mandant_id
    AND v01.dat BETWEEN v04.dat_von-1 AND v04.dat_bis-1

    
    JOIN DBP_DATA.ART v05
    ON v01.mandant_id = v05.mandant_id
    AND v01.art_id = v05.art_id

    
    WHERE NOT (v01.mandant_id = 5 AND v01.art_id = 206731500)
	
	AND NOT (v01.mandant_id = 2 AND v01.art_id = 208124500)
	AND NOT (v01.mandant_id = 3 AND v01.art_id = 208113690)
	AND NOT (v01.mandant_id = 6 AND v01.art_id = 208131570)
	AND NOT (v01.mandant_id IN (4,7) AND v01.art_id = 208114740)
	AND NOT (v01.mandant_id = 8 AND v01.art_id = 208131640);
