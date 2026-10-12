CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_SHOPPER_ART_EBENE_1
   (
	ANZ_BON_AF,
	ANZ_BON_AKTION,
	ANZ_BON_SA,
	ANZ_CP_KAEUFER,
	ANZ_CP_KAEUFER_70_PROZENT,
	ANZ_KAEUFER_AF,
	ANZ_KAEUFER_SA,
	ANZ_MARKT_BASELINE_AF,
	ANZ_TAGE_BASELINE_AF,
	ANZ_TAGE_SA,
	ANZ_TAGE_WO1,
	ANZ_TAGE_WO2,
	ANZ_TAGE_WO3,
	ART_ID_WERBUNG,
	KL_ART_ID_LANG,
	DAT_BASELINE_BIS,
	DAT_BASELINE_VON,
	ERTRAG_BASELINE_AF,
	ERTRAG_SA,
	KAEUFER_PROZENT_BASELINE_AF,
	KAEUFER_PROZENT_SA,
	KJWO_WERBE_ENDE,
	MANDANT_ID,
	MENGE_BASELINE_AF,
	MENGE_SA,
	MENGE_WO1,
	MENGE_WO2,
	MENGE_WO3,
	UMS_AKTIVIERTER_NORMALPREIS,
	UMS_GESAMT_AF_MIT_WV,
	UMS_GESAMT_AUSSER_ARTIKEL,
	UMS_NETTO_BASELINE_AF,
	UMS_NETTO_SA,
	UMS_REST_BON_AF,
	UMS_REST_BON_GESAMT,
	VK_BRUTTO_AF_MITTEL,
	VK_BRUTTO_SA_MITTEL,
	VK_BRUTTO_SA_MAX,
	WRG_ID,
	ANZ_MARKT_SA,
	KPI_SCORE,
    WUP_ID,
    NB_ID
) AS
   -- SPEC0258466, prescherad, 09.07.2024, Neuanlage 
   SELECT						  
    SUM(CAST(v01.anz_bon_af AS BIGINT)) AS anz_bon_af
   ,SUM(v01.anz_bon_aktion) AS anz_bon_aktion
   ,SUM(v01.anz_bon_sa) AS anz_bon_sa
   ,SUM(v01.anz_cp_kaeufer) AS anz_cp_kaeufer
   ,SUM(v01.anz_cp_kaeufer_70_prozent) AS anz_cp_kaeufer_70_prozent
   ,SUM (v01.anz_kaeufer_af) AS anz_kaeufer_af
   ,SUM(v01.anz_kaeufer_sa) AS anz_kaeufer_sa
   ,SUM(v01.anz_markt_baseline_af) AS anz_markt_baseline_af
   ,SUM(v01.anz_tage_baseline_af) AS anz_tage_baseline_af
   ,SUM(v01.anz_tage_sa) AS anz_tage_sa
   ,SUM(v01.anz_tage_wo1) AS anz_tage_wo1
   ,SUM(v01.anz_tage_wo2) AS anz_tage_wo2
   ,SUM(v01.anz_tage_wo3) AS anz_tage_wo3
   ,v01.art_id_werbung		  
   ,TO_VARCHAR(v02.kl_art_id, 'FM00000000') AS kl_art_id_lang
   ,MAX(v01.dat_baseline_bis)
   ,MIN(v01.dat_baseline_von)
   ,CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN CAST (SUM(v01.ertrag_baseline_af) AS DECIMAL (18,4))
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN CAST (SUM(v01.ertrag_baseline_af) * MAX(v300.umrechnungskurs) AS DECIMAL (18,4))
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN CAST (SUM(v01.ertrag_baseline_af) * MAX(v400.umrechnungskurs) AS DECIMAL (18,4))
              END  AS DECIMAL (18,4)) ertrag_baseline_af
   ,CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN CAST (SUM(v01.ertrag_sa) AS DECIMAL (18,4))
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN CAST (SUM(v01.ertrag_sa) * MAX(v300.umrechnungskurs) AS DECIMAL (18,4))
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN CAST (SUM(v01.ertrag_sa) * MAX(v400.umrechnungskurs) AS DECIMAL (18,4))
              END  AS DECIMAL (18,4)) ertrag_sa
   ,100.00 * CASE WHEN SUM(v01.anz_kaeufer_af) = 0 THEN NULL ELSE SUM(v01.anz_kaeufer_af) END / CASE WHEN SUM(v01.anz_bon_af) = 0 THEN NULL ELSE SUM(v01.anz_bon_af) END AS kaeufer_prozent_baseline_af
   ,100.00 * CASE WHEN SUM(v01.anz_kaeufer_sa) = 0 THEN NULL ELSE SUM(v01.anz_kaeufer_sa) END / CASE WHEN SUM(v01.anz_bon_aktion) = 0 THEN NULL ELSE SUM(v01.anz_bon_aktion) END AS kaeufer_prozent_sa
   
   ,v01.kjwo_werbe_ende
   ,v01.mandant_id 
   ,SUM(v01.menge_baseline_af) AS menge_baseline_af
   ,SUM(v01.menge_sa) AS menge_sa
   ,SUM(v01.menge_wo1) AS menge_wo1
   ,SUM(v01.menge_wo2) AS menge_wo2
   ,SUM(v01.menge_wo3) AS menge_wo3
   ,CAST(CASE
    WHEN v200.wrg_typ_id  = 1 THEN CAST (CASE WHEN SUM(v01.ums_gesamt_af_mit_wv) = 0 THEN NULL ELSE SUM(v01.ums_gesamt_af_mit_wv) END / CASE WHEN SUM(v01.anz_tage_sa) = 0 THEN NULL ELSE SUM(v01.anz_tage_sa)          END AS DECIMAL (18,4))
    WHEN v200.wrg_typ_id  = 0 THEN CAST (CASE WHEN SUM(v01.ums_gesamt_af_mit_wv) = 0 THEN NULL ELSE SUM(v01.ums_gesamt_af_mit_wv) END / CASE WHEN SUM(v01.anz_tage_sa) = 0 THEN NULL ELSE SUM(v01.anz_tage_sa)          END AS DECIMAL (18,4))						   
    END  AS DECIMAL (18,4)) ums_aktivierter_normalpreis
   ,CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN CAST (SUM(v01.ums_gesamt_af_mit_wv) AS DECIMAL (18,4))
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN CAST (SUM(v01.ums_gesamt_af_mit_wv) * MAX(v300.umrechnungskurs) AS DECIMAL (18,4))
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN CAST (SUM(v01.ums_gesamt_af_mit_wv) * MAX(v400.umrechnungskurs) AS DECIMAL (18,4))
              END  AS DECIMAL (18,4)) ums_gesamt_af_mit_wv
   ,CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN CAST (SUM(v01.ums_gesamt_ausser_artikel) AS DECIMAL (18,4))
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN CAST (SUM(v01.ums_gesamt_ausser_artikel) * MAX(v300.umrechnungskurs) AS DECIMAL (18,4))
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN CAST (SUM(v01.ums_gesamt_ausser_artikel) * MAX(v400.umrechnungskurs) AS DECIMAL (18,4))
              END  AS DECIMAL (18,4)) ums_gesamt_ausser_artikel
   ,CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN CAST (SUM(v01.ums_netto_baseline_af) AS DECIMAL (18,4))
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN CAST (SUM(v01.ums_netto_baseline_af) * MAX(v300.umrechnungskurs) AS DECIMAL (18,4))
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN CAST (SUM(v01.ums_netto_baseline_af) * MAX(v400.umrechnungskurs) AS DECIMAL (18,4))
              END  AS DECIMAL (18,4)) ums_netto_baseline_af
   ,CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN CAST (SUM(v01.ums_netto_sa) AS DECIMAL (18,4))
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN CAST (SUM(v01.ums_netto_sa) * MAX(v300.umrechnungskurs) AS DECIMAL (18,4))
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN CAST (SUM(v01.ums_netto_sa) * MAX(v400.umrechnungskurs) AS DECIMAL (18,4))
              END  AS DECIMAL (18,4)) ums_netto_sa
   ,CAST(CASE
    WHEN v200.wrg_typ_id  = 1 THEN CAST (CASE WHEN SUM(v01.ums_gesamt_af_mit_wv) = 0 THEN NULL ELSE SUM(v01.ums_gesamt_af_mit_wv) END / CASE WHEN SUM(v01.anz_cp_kaeufer) = 0 THEN NULL ELSE                    
        SUM(v01.anz_cp_kaeufer) END AS DECIMAL (18,4))
    WHEN v200.wrg_typ_id  = 0 THEN CAST (CASE WHEN SUM(v01.ums_gesamt_af_mit_wv) = 0 THEN NULL ELSE SUM(v01.ums_gesamt_af_mit_wv) END / CASE WHEN SUM(v01.anz_cp_kaeufer) = 0 THEN NULL ELSE        
        SUM(v01.anz_cp_kaeufer) END AS DECIMAL (18,4))								  
    END  AS DECIMAL (18,4)) ums_rest_bon_af
   ,CAST(CASE
    WHEN v200.wrg_typ_id  = 1 THEN CAST (CASE WHEN SUM(v01.ums_gesamt_ausser_artikel) = 0 THEN NULL ELSE SUM(v01.ums_gesamt_ausser_artikel) END / CASE WHEN SUM(v01.anz_cp_kaeufer) = 0 THEN NULL ELSE  
        SUM(v01.anz_cp_kaeufer) END AS DECIMAL (18,4))										 											 
    WHEN v200.wrg_typ_id  = 0 THEN CAST (CASE WHEN SUM(v01.ums_gesamt_ausser_artikel) = 0 THEN NULL ELSE SUM(v01.ums_gesamt_ausser_artikel) END / CASE WHEN SUM(v01.anz_cp_kaeufer) = 0 THEN NULL ELSE 
        SUM(v01.anz_cp_kaeufer) END AS DECIMAL (18,4))
    END  AS DECIMAL (18,4)) ums_rest_bon_gesamt
   ,CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN CAST (SUM(v01.vk_brutto_af_mittel) AS DECIMAL (18,4))
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN CAST (SUM(v01.vk_brutto_af_mittel) * MAX(v300.umrechnungskurs) AS DECIMAL (18,4))
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN CAST (SUM(v01.vk_brutto_af_mittel) * MAX(v400.umrechnungskurs) AS DECIMAL (18,4))
              END  AS DECIMAL (18,4)) vk_brutto_af_mittel
   ,CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN CAST (SUM(v01.vk_brutto_sa_mittel) AS DECIMAL (18,4))
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN CAST (SUM(v01.vk_brutto_sa_mittel) * MAX(v300.umrechnungskurs) AS DECIMAL (18,4))
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN CAST (SUM(v01.vk_brutto_sa_mittel) * MAX(v400.umrechnungskurs) AS DECIMAL (18,4))
              END  AS DECIMAL (18,4)) vk_brutto_sa_mittel
   ,CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN CAST (SUM(v01.vk_brutto_sa_max) AS DECIMAL (18,4))
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN CAST (SUM(v01.vk_brutto_sa_max) * MAX(v300.umrechnungskurs) AS DECIMAL (18,4))
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN CAST (SUM(v01.vk_brutto_sa_max) * MAX(v400.umrechnungskurs) AS DECIMAL (18,4))
              END  AS DECIMAL (18,4)) vk_brutto_sa_max
   ,v01.wrg_id
   ,SUM(v01.anz_markt_sa) AS anz_markt_sa
   ,CASE
	WHEN SUM(v01.ertrag_sa)-SUM(v01.ertrag_baseline_af) > SUM(sc.ertrag_uplift_schwellwert) AND SUM(anz_kaeufer_sa)-SUM(v01.anz_kaeufer_af) > SUM(sc.kaeufer_uplift_schwellwert) THEN 3 
	WHEN SUM(v01.ertrag_sa)-SUM(v01.ertrag_baseline_af) > SUM(sc.ertrag_uplift_schwellwert) THEN 1 
	WHEN SUM(anz_kaeufer_sa-v01.anz_kaeufer_af) > SUM(sc.kaeufer_uplift_schwellwert) THEN 1 
    ELSE 0 END AS KPI_Score
   -- SPEC0303401 Erweiterung um Markt, um Auswertung mit PMR möglich zu machen / sschuecke 22.04.2025
   ,v01.wup_id
   ,v01.nb_id
   
   FROM dbp_data.shopper_1 v01
   INNER JOIN dbp_data.art_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.art_id_werbung = v02.art_id

   JOIN dbp_data.mandant_1 v100
   ON v01.mandant_id = v100.mandant_id
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200

   JOIN dbp_data.kurs_1 v300
   ON v300.dat_bis = '9999-12-31'
   AND v100.default_wrg = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'

   
   JOIN dbp_data.kurs_1 v400
   ON CURRENT_DATE BETWEEN v400.dat_von AND v400.dat_bis
   AND v100.default_wrg = v400.von_wrg_id
   AND v400.kurstyp_id = 3
   AND v400.nach_wrg_id ='EUR'

   --Tabellen zur Berechnung des KPI_Scores   
   JOIN dbp_data.art_wg_zu_per_1 wg
   ON wg.art_id = v01.art_id_werbung
   AND wg.mandant_id = v01.mandant_id
   AND wg.arthiertyp_id = 2
   AND wg.dat_bis = '9999-12-31'
   --as-is-Sicht!
   JOIN dbp_data.wg_per_1 abt_1
   ON abt.mandant_id = wg.mandant_id
   AND abt.wg_id = wg.wg_id
   AND abt.arthiertyp_id = wg.arthiertyp_id
   AND abt.dat_bis = '9999-12-31'
   --neue Tabelle, as-is-Sicht!
   JOIN dbp_data.shopper_score_schwellwerte_1 sc
   ON sc.mandant_id = wg.mandant_id
   AND sc.abt_id = abt.abt_id
   AND sc.arthiertyp_id = wg.arthiertyp_id
   AND sc.dat_bis = '9999-12-31'

   GROUP BY
    v01.aktion_thema_gruppe_id
   ,v01.art_id_werbung
   ,v02.kl_art_id
   ,v02.art_id
   ,v01.kjwo_werbe_ende
   ,v01.mandant_id
   ,v01.wrg_id
   ,v200.wrg_typ_id
   ,v200.berichtskurs_typ_id
   ,v01.wup_id
   ,v01.nb_id;