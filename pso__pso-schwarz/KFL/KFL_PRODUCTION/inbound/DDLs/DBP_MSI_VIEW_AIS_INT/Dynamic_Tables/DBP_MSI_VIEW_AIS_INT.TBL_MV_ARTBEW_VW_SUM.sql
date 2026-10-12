create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_AIS_INT.TBL_MV_ARTBEW_VW_SUM(
	DAT,
	ART_ID,
	MANDANT_ID,
	GP_ID,
	HERST_ID,
	VW_ID,
	BEWART_ID,
	BEZUGSWEG_ID,
	EAN_KASSE,
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
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_AIS_INT
 as
    SELECT 
    -- AP0286829, Erweiterung >= 2022-04-01: pv_kdp_bby_loy um 73, 74, 75  UND  pv_bonrabatt_bby_loy um 76 / sschuecke 29.01.2026
    v01.dat,
    v01.art_id,
    v01.mandant_id,
    COALESCE(v02.gp_id,-1) AS gp_id,
    CAST(0 AS NUMBER(38,5)) AS herst_id,
    v03.vw_id,
    CAST(0 AS NUMBER(38,5)) AS bewart_id,
    CAST(0 AS NUMBER(38,5)) AS bezugsweg_id,
    CAST(0 AS NUMBER(38,5)) AS ean_kasse,
    CAST(0 AS NUMBER(38,5)) AS umsatz_mwst_betrag,
    CAST(0 AS NUMBER(38,5)) AS umsatz_netto,
    CAST(0 AS NUMBER(38,5)) AS vk_menge,
    CAST(0 AS NUMBER(38,5)) AS vk_menge_norm,
    CAST(0 AS NUMBER(38,5)) AS ek_netto2_absatz,
    CAST(0 AS NUMBER(38,5)) AS ek_netto3_absatz,
    CAST(0 AS NUMBER(38,5)) AS ek_netto4_absatz, 
    --AF
    CAST(0 AS NUMBER(38,5)) AS umsatz_mwst_betrag_af,
    CAST(0 AS NUMBER(38,5)) AS umsatz_netto_af,
    CAST(0 AS NUMBER(38,5)) AS vk_menge_af,
    CAST(0 AS NUMBER(38,5)) AS vk_menge_af_norm,
    CAST(0 AS NUMBER(38,5)) AS ek_netto2_absatz_af,
    CAST(0 AS NUMBER(38,5)) AS ek_netto3_absatz_af,
    CAST(0 AS NUMBER(38,5)) AS ek_netto4_absatz_af,
    --SA
    CAST(0 AS NUMBER(38,5)) AS umsatz_mwst_betrag_sa,
    CAST(0 AS NUMBER(38,5)) AS umsatz_netto_sa,
    CAST(0 AS NUMBER(38,5)) AS vk_menge_sa,
    CAST(0 AS NUMBER(38,5)) AS vk_menge_sa_norm,
    CAST(0 AS NUMBER(38,5)) AS ek_netto2_absatz_sa,
    CAST(0 AS NUMBER(38,5)) AS ek_netto3_absatz_sa,
    CAST(0 AS NUMBER(38,5)) AS ek_netto4_absatz_sa,
    --AP0052094, SPEC0065401
    CAST(0 AS NUMBER(38,5)) AS ek_brutto_absatz,
    CAST(0 AS NUMBER(38,5)) AS ek_brutto_absatz_af,
    CAST(0 AS NUMBER(38,5)) AS ek_brutto_absatz_sa,
    CAST(0 AS NUMBER(38,5)) AS ek_gld_absatz,
    CAST(0 AS NUMBER(38,5)) AS ek_gld_absatz_af,
    CAST(0 AS NUMBER(38,5)) AS ek_gld_absatz_sa,
    CAST(0 AS NUMBER(38,5)) AS ek_nettobnk_absatz,
    CAST(0 AS NUMBER(38,5)) AS ek_nettobnk_absatz_af,
    CAST(0 AS NUMBER(38,5)) AS ek_nettobnk_absatz_sa,
    CAST(0 AS NUMBER(38,5)) AS ek_netto_absatz,
    CAST(0 AS NUMBER(38,5)) AS ek_netto_absatz_af,
    CAST(0 AS NUMBER(38,5)) AS ek_netto_absatz_sa,
    CAST(0 AS NUMBER(38,5)) AS logkostenzuschlag
    --AP0143687: FWU
    ,CAST(0 AS NUMBER(38,5)) AS ek_mepol
    ,CAST(0 AS NUMBER(38,5)) AS ek_mepol_af
    ,CAST(0 AS NUMBER(38,5)) AS ek_mepol_sa
    
    ,CAST(0 AS NUMBER(38,5)) AS bonusbasis
    ,CAST(0 AS NUMBER(38,5)) AS bonusbasis_af
    ,CAST(0 AS NUMBER(38,5)) AS bonusbasis_sa,
    --PV metrics
    SUM(CASE WHEN v01.wv_grund_id = 2 THEN v01.abschriftbetrag_netto ELSE 0 END) AS pv_aktion_sa_loyalty,
    CAST(0 AS NUMBER(38,5)) AS pv_aktion_sa_loyalty_bby,
    CAST(0 AS NUMBER(38,5)) AS pv_aktion_sa_loyalty_kdn_bby,
    CAST(0 AS NUMBER(38,5)) AS pv_aktion_sa_loyalty_kdp_bby,
    SUM(CASE WHEN v01.wv_grund_id = 0 THEN v01.abschriftbetrag_netto ELSE 0 END) AS pv_aktion_sa_non_loyalty,
    CAST(0 AS NUMBER(38,5)) AS pv_aktion_sa_non_loyalty_bby,
    -- Splittung PV 
    -- -> ab 01.04.2022 neue Logik davor alte Logik  
    SUM(CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (52, 53, 54) 
      THEN v01.abschriftbetrag_netto
    WHEN v01.wv_grund_id IN (52, 53, 54, 55)
      THEN v01.abschriftbetrag_netto 
      ELSE 0 END) AS pv_bby_loyalty,
    SUM(CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (56, 57, 58) 
      THEN v01.abschriftbetrag_netto 
    WHEN v01.wv_grund_id IN (56, 57, 58, 59)  
      THEN v01.abschriftbetrag_netto 
      ELSE 0 END) AS pv_bby_non_loyalty,
    SUM(CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (60, 61, 62) 
      THEN v01.abschriftbetrag_netto
    WHEN v01.wv_grund_id IN (60, 61, 62, 63)
      THEN v01.abschriftbetrag_netto ELSE 0 END) AS pv_kdn_bby_loyalty,
    SUM(CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (64, 65, 66, 73, 74, 75) 
      THEN v01.abschriftbetrag_netto
    WHEN v01.wv_grund_id IN (64, 65, 66, 67) 
      THEN v01.abschriftbetrag_netto ELSE 0 END) AS pv_kdp_bby_loyalty,
      
    SUM(CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (59)  
      THEN v01.abschriftbetrag_netto 
      ELSE 0 END) AS pv_bonrabatt_bby_non_loyalty,
    SUM(CASE WHEN v01.dat >= '2022-04-01' AND v01.wv_grund_id IN (55,63,67,76) 
      THEN v01.abschriftbetrag_netto 
      ELSE 0 END)AS pv_bonrabatt_bby_loyalty,
    pv_bonrabatt_bby_non_loyalty + pv_bonrabatt_bby_loyalty AS pv_bonrabatt_bby,
	
	-- AP0213409/SPEC0247905 sschuecke 16.09.2024
	pv_aktion_sa_loyalty + pv_aktion_sa_loyalty_bby + pv_aktion_sa_loyalty_kdn_bby     
                      + pv_aktion_sa_loyalty_kdp_bby + pv_aktion_sa_non_loyalty
                      + pv_aktion_sa_non_loyalty_bby + pv_bby_loyalty + pv_bby_non_loyalty
                      + pv_kdn_bby_loyalty + pv_kdp_bby_loyalty + pv_bonrabatt_bby
					  AS werbeabschrift_pv
,SUM(CASE WHEN v01.wv_grund_id IN (48,49) THEN v01.abschriftbetrag_netto END) AS werbeabschrift_werbenachvermarktung_manuell
,SUM(CASE WHEN v01.wv_grund_id IN (20,21,23,50,70) THEN v01.abschriftbetrag_netto END) AS werbeabschrift_aktionsanpassung_filiale
,SUM(v01.abschriftbetrag_netto) - (werbeabschrift_pv + werbeabschrift_werbenachvermarktung_manuell + werbeabschrift_aktionsanpassung_filiale) AS werbeabschrift_rest

    FROM DBP_DATA.MARKTABSCHRIFTEN v01

    LEFT JOIN
    (SELECT
    art_id
    ,gp_id
    ,wup_id
    ,dat_von
    ,dat_bis
    FROM DBP_DATA.ART_GP_NM_ZU_PER
    WHERE  mandant_id = 1
    ) v02
    ON     v01.art_id = v02.art_id
    AND v01.wup_id = v02.wup_id
    AND v01.dat BETWEEN v02.dat_von AND v02.dat_bis

    INNER JOIN DBP_DATA.WUP v03
    ON v01.mandant_id = v03.mandant_id
    AND v01.wup_id = v03.wup_id
    AND v01.nb_id = v03.nb_id
    

    WHERE v01.mandant_id = 1
    AND v01.abschriftart_id = -1
	
	-- AP0213409/SPEC0247905 sschuecke 16.09.2024
    -- AND v01.wv_grund_id IN (2, 0, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67)
    
    GROUP BY 
    v01.dat,
    v01.art_id,
    v01.mandant_id,
    v02.gp_id,
    v03.vw_id
    ;
