create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_WBS_PMR_ANGEBOT_AKTION_ART_WUP_ZU_1(
	MANDANT_ID,
	MUTTER_WB_ID,
	IN_GRUPPE_FG,
	ANZ_ART_IN_GRUPPE,
	ART_ID,
	AKTION_ID,
	WUP_ID,
	NB_ID,
	DAT_VON,
	DAT_BIS,
	KJWO_VON,
	AKTION_DAUER,
	FG,
	MENGE,
	ABSATZ_AF_N_LOYALTY_SCHM_BBY,
	ABSATZ_AF_LOYALTY_SCHM_BBY,
	ABSATZ_AF_N_LOYALTY_BBY,
	ABSATZ_AF_LOYALTY_BBY,
	ABSATZ_SA_N_LOYALTY,
	ABSATZ_SA_LOYALTY,
	ABSATZ_SA_N_LOYALTY_BBY,
	ABSATZ_SA_LOYALTY_BBY,
	ABSATZ_SA_LOYALTY_KK_BBY,
	ABSATZ_SA_LOYALTY_KK_C_BBY,
	SALES_FG,
	ZEITRAUM_KORRIGIERTE_MENGE,
	VK_AKTION_BRUTTO,
	VK_VOR_AKTION_BRUTTO,
	WRG_ID,
	ANGEBOT_ID,
	BONUSKAUF_GESCHAEFTSVORFALL_ID,
	BONUSKAUF_ANREIZTYP,
	PREIS_NIEDRIGSTER,
	PREIS_NIEDRIGSTER_DIFF_PERC,
	OPV_PROSPEKT_FG,
	OPV_MARKT_FG,
	STIMMUNG_FG,
	PREISHAMMER_FG,
	GONDELKOPF_FG,
	EK_ART_ID_REF,
	GK_FG,
	BONUSKAUF_FG,
	MULTI_OFFER_ID_FG,
	NUR_ONLINE_FG,
	KUNDENKARTE_PERSONALISIERT_FG,
	STILLE_AKTION_FG,
	STILLE_AKTION_MIT_MENGE_FG,
	TV_FG,
	TITELSEITE_FG,
	RUECKSEITE_FG
) as



                    
WITH all_aktion AS (
    SELECT 
        a_art_w.mandant_id,
        a_art_w.art_id,
        a_art_w.aktion_id,
        'not pmr' AS fg,
        wup_id,
        nb_id,
        a_art_w.vk_aktion_brutto,
        a_art_w.vk_vor_aktion_brutto,
        a_art_w.wrg_id
    FROM dbp_view.v_aktion_art_wup_zu_1 a_art_w
    WHERE NOT EXISTS (
        SELECT 1 
        FROM dbp_view.v_pmr_angebot_art_wup_zu_1 a_art_w_pmr
        WHERE a_art_w.mandant_id = a_art_w_pmr.mandant_id
            AND a_art_w.art_id = a_art_w_pmr.art_id
            AND a_art_w.aktion_id = a_art_w_pmr.aktion_id
            AND a_art_w.wup_id = a_art_w_pmr.wup_id
    )
    AND grund_sperrung IS NULL
    AND COALESCE(geloescht_sap_fg, 0) <> 1
    UNION ALL
    SELECT 
        a_art_w_pmr.mandant_id,
        a_art_w_pmr.art_id,
        a_art_w_pmr.aktion_id,
        'pmr' AS fg,
        wup_id,
        nb_id,
        a_art_w_pmr.preis_aktion,
        a_art_w_pmr.preis_normal,
        a_art_w_pmr.wrg_id
    FROM dbp_view.v_pmr_angebot_art_wup_zu_1 a_art_w_pmr
),
ab AS (
    SELECT 
        all_aktion.aktion_id, 
        ab.mandant_id,  
        ab.wup_id, 
        ab.art_id, 
        SUM(menge) AS menge,
        SUM(CASE WHEN bewart_det_id = 100110 THEN menge ELSE 0 END) AS absatz_af_n_loyalty_schM_BBY,
        SUM(CASE WHEN bewart_det_id = 100111 THEN menge ELSE 0 END) AS absatz_af_loyalty_schM_BBY, 
        SUM(CASE WHEN bewart_det_id = 100130 THEN menge ELSE 0 END) AS absatz_af_n_loyalty_BBY, 
        SUM(CASE WHEN bewart_det_id = 100131 THEN menge ELSE 0 END) AS absatz_af_loyalty_BBY,
        SUM(CASE WHEN bewart_det_id = 100210 THEN menge ELSE 0 END) AS absatz_sa_n_loyalty, 
        SUM(CASE WHEN bewart_det_id = 100211 THEN menge ELSE 0 END) AS absatz_sa_loyalty,       
        SUM(CASE WHEN bewart_det_id = 100220 THEN menge ELSE 0 END) AS absatz_sa_n_loyalty_BBY, 
        SUM(CASE WHEN bewart_det_id = 100221 THEN menge ELSE 0 END) AS absatz_sa_loyalty_BBY,  
        SUM(CASE WHEN bewart_det_id = 100231 THEN menge ELSE 0 END) AS absatz_sa_loyalty_KK_BBY,       
        SUM(CASE WHEN bewart_det_id = 100241 THEN menge ELSE 0 END) AS absatz_sa_loyalty_KK_C_BBY
    FROM all_aktion 
    JOIN dbp_view.v_aktion_1 a
        ON all_aktion.mandant_id = a.mandant_id
        AND all_aktion.aktion_id = a.aktion_id
    JOIN dbp_view.v_artbew_1 ab
        ON all_aktion.mandant_id = ab.mandant_id
        AND all_aktion.wup_id = ab.wup_id
        AND all_aktion.art_id = ab.art_id
        AND ab.dat BETWEEN a.dat_von AND a.dat_bis
    JOIN dbp_data.tag_1 t
        ON a.dat_von = t.dat
        
    WHERE akt_kj BETWEEN -2 AND 0
    GROUP BY all_aktion.aktion_id, ab.mandant_id, ab.wup_id, ab.art_id
)
    SELECT 
        all_aktion.mandant_id,
        a_per.mutter_wb_id,
        CASE WHEN a_per.mutter_wb_id IS NOT NULL THEN 1 ELSE 0 END AS in_gruppe_fg_,
        CASE WHEN in_gruppe_fg_ = 1 THEN COUNT(DISTINCT all_aktion.art_id) 
            OVER (PARTITION BY all_aktion.mandant_id, all_aktion.wup_id, a.dat_von, a.dat_bis, a_per.mutter_wb_id)
            ELSE NULL END AS anz_art_in_gruppe,
        all_aktion.art_id,
        all_aktion.aktion_id,
        v05.aktuell_wup_id wup_id,
        all_aktion.nb_id,
        a.dat_von,
        a.dat_bis,
        t.kjwo AS kjwo_von,
        DATEDIFF(DAY, a.dat_von, a.dat_bis) + 1 AS aktion_dauer,
        fg,
        ab_agg.menge,
        ab_agg.absatz_af_n_loyalty_schM_BBY,
        ab_agg.absatz_af_loyalty_schM_BBY, 
        ab_agg.absatz_af_n_loyalty_BBY, 
        ab_agg.absatz_af_loyalty_BBY,
        ab_agg.absatz_sa_n_loyalty, 
        ab_agg.absatz_sa_loyalty,       
        ab_agg.absatz_sa_n_loyalty_BBY, 
        ab_agg.absatz_sa_loyalty_BBY,  
        ab_agg.absatz_sa_loyalty_KK_BBY,       
        ab_agg.absatz_sa_loyalty_KK_C_BBY,
        ab_agg.sales_fg,
        wbs_aa_per.zeitraum_korrigierte_menge,
        all_aktion.vk_aktion_brutto,
        all_aktion.vk_vor_aktion_brutto,
        all_aktion.wrg_id,
        COALESCE(pmr_a.angebot_id, '-1') AS angebot_id,
        COALESCE(LPAD(CAST(pmr_a.bonuskauf_geschaeftsvorfall_id AS STRING), 2, '0'),'-1') AS bonuskauf_geschaeftsvorfall_id,
      	COALESCE(pmr_a.bonuskauf_anreiztyp, 'n/a') AS bonuskauf_anreiztyp,
        pmr_a.preis_niedrigster,
        pmr_a.preis_niedrigster_diff_perc,
        pmr_a.opv_prospekt_fg,
        pmr_a.opv_markt_fg,
        pmr_a.stimmung_fg,
        pmr_a.preishammer_fg,
        pmr_a.gondelkopf_fg,
        pmr_a.ek_art_id_ref,
        COALESCE(wbs_aa_per.gk_fg, -1) AS gk_fg,
        COALESCE(pmr_a.bonuskauf_fg, CASE WHEN COALESCE(lb.aktion_id, 0) = 0 THEN 0 ELSE 1 END) AS bonuskauf_fg,
        CASE WHEN COALESCE(COUNT(DISTINCT pmr_a.angebot_id) OVER (PARTITION BY all_aktion.mandant_id, all_aktion.wup_id, all_aktion.art_id, a.dat_von, a.dat_bis), 0)> 1 THEN 1 ELSE 0 END AS multi_offer_id_fg, 
        pmr_a_werf_agg.nur_online_fg,
        pmr_a_werf_agg.kundenkarte_personalisiert_fg,
        pmr_a_werf_agg.stille_aktion_fg,
        pmr_a_werf_agg.stille_aktion_mit_menge_fg,
        pmr_a_werf_agg.tv_fg,
        pmr_a_werf_agg.titelseite_fg,
        pmr_a_werf_agg.rueckseite_fg,
      
      
       
       
    FROM all_aktion
    INNER JOIN dbp_view.v_wup_1 v05
        ON v05.mandant_id = all_aktion.mandant_id
        AND v05.wup_id = all_aktion.wup_id
        AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))
    JOIN dbp_view.v_aktion_1 a
        ON all_aktion.mandant_id = a.mandant_id
        AND all_aktion.aktion_id = a.aktion_id
    JOIN dbp_view.v_tag_1 t
        ON a.dat_von = t.dat
    LEFT JOIN (
        SELECT aktion_id, wup_id, art_id, mandant_id,
        MAX(CASE WHEN menge > 0 THEN 1 ELSE 0 END) AS sales_fg,
        SUM(menge) AS menge,
        SUM(absatz_af_n_loyalty_schM_BBY) AS absatz_af_n_loyalty_schM_BBY,
        SUM(absatz_af_loyalty_schM_BBY) AS absatz_af_loyalty_schM_BBY, 
        SUM(absatz_af_n_loyalty_BBY) AS absatz_af_n_loyalty_BBY, 
        SUM(absatz_af_loyalty_BBY) AS absatz_af_loyalty_BBY,
        SUM(absatz_sa_n_loyalty) AS absatz_sa_n_loyalty, 
        SUM(absatz_sa_loyalty) AS absatz_sa_loyalty,       
        SUM(absatz_sa_n_loyalty_BBY) AS absatz_sa_n_loyalty_BBY, 
        SUM(absatz_sa_loyalty_BBY) AS absatz_sa_loyalty_BBY,  
        SUM(absatz_sa_loyalty_KK_BBY) AS absatz_sa_loyalty_KK_BBY,       
        SUM(absatz_sa_loyalty_KK_C_BBY) AS absatz_sa_loyalty_KK_C_BBY
        FROM ab 
        GROUP BY aktion_id, wup_id, art_id, mandant_id
    ) ab_agg
        ON all_aktion.mandant_id = ab_agg.mandant_id
        AND all_aktion.wup_id = ab_agg.wup_id
        AND all_aktion.art_id = ab_agg.art_id
        AND all_aktion.aktion_id = ab_agg.aktion_id
    LEFT JOIN (SELECT DISTINCT aktion_id, mandant_id FROM dbp_view.v_l_bonuskauf_1) lb
        ON all_aktion.mandant_id = lb.mandant_id
        AND all_aktion.aktion_id = lb.aktion_id
    LEFT JOIN dbp_view.v_art_per_1 a_per
        ON all_aktion.art_id = a_per.art_id
        AND all_aktion.mandant_id = a_per.mandant_id
        AND (a_per.dat_bis BETWEEN a.dat_von AND a.dat_bis OR a_per.dat_bis = '9999-12-31')
    LEFT JOIN dbp_view.v_wbs_art_aktion_per_1 wbs_aa_per
        ON all_aktion.mandant_id = wbs_aa_per.mandant_id
        AND all_aktion.aktion_id = wbs_aa_per.aktion_id
        AND a.dat_von = wbs_aa_per.dat_von
        AND all_aktion.art_id = wbs_aa_per.art_id
        AND all_aktion.wup_id = wbs_aa_per.wup_id
    LEFT JOIN dbp_view.v_pmr_angebot_art_wup_zu_1 pmr_a
        ON all_aktion.mandant_id = pmr_a.mandant_id
        AND all_aktion.aktion_id = pmr_a.aktion_id
        AND all_aktion.wup_id = pmr_a.wup_id
        AND all_aktion.art_id = pmr_a.art_id
    LEFT JOIN (
        SELECT 
            pmr_a_werf.mandant_id, 
            pmr_a_werf.angebot_id,
            MAX(COALESCE(
                CASE 
                    WHEN pmr_a_werf.werbemittel_art_id = '0900' AND pmr_a_werf.werbemittel_id IN (11,21,31) THEN 1
                    WHEN pmr_a_werf.werbemittel_art_id IN ('0992','0993') AND pmr_a_werf.werbemittel_id IN (10,20,30) THEN 1
                    ELSE 0 
                END, -1)) AS nur_online_fg,
            MAX(COALESCE(
                CASE
                    WHEN pmr_a_werf.werbemittel_art_id = '0999' AND pmr_a_werf.werbemittel_id = 90 THEN 1
                    ELSE 0 
                END, -1)) AS kundenkarte_personalisiert_fg,
            MAX(COALESCE(
                CASE
                    WHEN pmr_a_werf.werbemittel_art_id = '0920' AND pmr_a_werf.werbemittel_id = 40 THEN 1
                    ELSE 0 
                END, -1)) AS stille_aktion_fg,
            MAX(COALESCE(
                CASE
                    WHEN pmr_a_werf.werbemittel_art_id = '0920' AND pmr_a_werf.werbemittel_id = 50 THEN 1
                    ELSE 0 
                END, -1)) AS stille_aktion_mit_menge_fg,
            MAX(COALESCE(
                CASE
                    WHEN pmr_a_werf.werbemittel_art_id = '0200' AND pmr_a_werf.werbemittel_id IN (20) THEN 1
                    ELSE 0 
                END, -1)) AS tv_fg,
            MAX(COALESCE(
                CASE
                    WHEN pmr_a_werf.werbemittel_art_id = '0900' AND pmr_a_werf.werbemittel_id IN (10) THEN 1
                    ELSE 0 
                END, -1)) AS titelseite_fg,
            MAX(COALESCE(
                CASE
                    WHEN pmr_a_werf.werbemittel_art_id = '0900' AND pmr_a_werf.werbemittel_id IN (20) THEN 1
                    ELSE 0 
                END, -1)) AS rueckseite_fg
        FROM dbp_view.v_pmr_angebot_werbemittel_werbeflaeche_zu_1 pmr_a_werf
        GROUP BY pmr_a_werf.mandant_id, pmr_a_werf.angebot_id
    ) pmr_a_werf_agg
        ON pmr_a.mandant_id = pmr_a_werf_agg.mandant_id
        AND pmr_a.angebot_id = pmr_a_werf_agg.angebot_id
   
    
       
    WHERE akt_kj BETWEEN -2 AND 0 
        AND a.dat_von <= CURRENT_DATE;