CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_BVV_IKS_2(
	MANDANT_ID,
	PROJEKT_ID,
	RPM_HIERARCHIE_ID,
	IN_PROJEKT_ID,
	PSP_ID,
	LAND_ID,
	WUP_ID,
	WUP_STANDORT,
	PROJEKT_NR,
	RPM_PROJEKT_TYP_ID,
	TESTMARKT_FG,
	IN_LIEF_ID,
	RPM_STATUS_ID,
	RPM_PHASE_ID,
	RPM_PHASE_BEZ,
	WRG_ID_RPM,
	IMS_PROJEKT_TYP_ID,
	IN_PROJEKT_ID_CHAR,
	PSP_ID_CHAR,
	PSP_END_NR,
	WG_PSP_END_NR,
	IN_WG_ID,
	NORMAL_BVV_LEIST_ID,
	BVV_LEIST_ID,
	WRG_ID,
	WRG_TYP_ID,
	FAKTOR,
	KURS_2,
	AUSBLEND,
	MENGE_BESCH_BEST,
	BETRAG_BESCH_BEST,
	BETRAG_BESCH_BEST_NT,
	BETRAG_OBLIGO,
	BETRAG_OBLIGO_NT,
	BETRAG_OBLIGO_PLAN,
	BETRAG_IST_KOSTEN,
	BETRAG_IST_KOSTEN_NEU,
	BETRAG_BKZ,
	BETRAG_INFRA,
	BETRAG_RUECKST,
	BETRAG_IST_ORST_OINFRA,
	INFRA_RUECK_BETRAG_NEU,
	BETRAG_IST_ORST_OINFRA_NEU,
	BETRAG_IST_KOSTEN_NT,
	PSP_BAUKOSTEN_ZU_AKT,
	BETRAG_KOSTEN_PROGNOSE,
	ROWNUMBER,
	BETRAG_MMK_PROGNOSE,
	BETRAG_ZEA_PROGNOSE,
	BETRAG_HOCHRECHNUNG,
	PSP_KOSTEN_PROGNOSE,
	PSP_ZEA_PROGNOSE,
	PSP_MMK_PROGNOSE,
	PSP_C1_25,
	PSP_C2_26,
	PSP_A1_02,
	PROJEKT_B2_22,
	PSP_C3_27,
	PSP_C4_28,
	PSP_B4_24,
	PROJEKT_B3_23,
	PSP_C5_34,
	PSP_C6_29,
	PSP_C7_32,
	PSP_C6_38,
	PSP_C2_37,
	BKZ_A1_02,
	BKZ_B4_24,
	PSP_AKT_PROGNOSE,
	KOSTEN_PROGNOSE_VERSION_ID,
	DAT_KOSTEN_PROGNOSE_VERSION,
	AKT_BUDGET_DAT,
	BKZ_OBLIGO,
	BETRAG_HOCHRECHNUNG_OHNE_BKZ,
	PSP_KONDITIONSWERT_2,
	PSP_BETRAG_KONDITIONSWERT_GEBUCHT,
	PSP_BETRAG_KONDITIONSWERT_UNGEBUCHT,
	BKZ_BETRAG_KONDITIONSWERT_GEBUCHT,
	BKZ_BETRAG_KONDITIONSWERT_UNGEBUCHT
) AS
SELECT
    sub00.mandant_id,
    sub00.projekt_id,
    sub00.rpm_hierarchie_id,
    sub00.in_projekt_id,
    sub00.psp_id,
    sub00.land_id,
    sub00.wup_id,
    sub00.wup_standort,
    sub00.projekt_nr,
    sub00.rpm_projekt_typ_id,
    sub00.testmarkt_fg,
    
    CASE WHEN (COALESCE( sub00.lief_best , sub00.lief_ist_kosten, sub00.lief_obligo)) IS NULL THEN -1 ELSE (COALESCE( sub00.lief_best , sub00.lief_ist_kosten, sub00.lief_obligo)) END  AS in_lief_id, 
    sub00.rpm_status_id,
    sub00.rpm_phase_id,
    sub00.rpm_phase_bez,
    sub00.wrg_id_rpm,
    sub00.ims_projekt_typ_id,
    sub00.in_projekt_id_char,
    sub00.psp_id_char,
    sub00.psp_end_nr,
    
    CASE WHEN bvv.bvv_leist_id IS NOT NULL
        THEN 0 ELSE 1 END AS wg_psp_end_nr,
    sub00.in_wg_id,
    bvv.bvv_leist_id AS normal_bvv_leist_id ,

    COALESCE(normal_bvv_leist_id, ('99' ||sub00.psp_end_nr)::NUMBER(38,0))  AS bvv_leist_id,
    
    v99.wrg_id AS wrg_id,
    v99.wrg_typ_id,
    kurs.FAKTOR,
    kurs.kurs_2,
    
    CASE
        WHEN sub00.psp_end_nr IN (3, 4, 5, 6, 7) THEN 1
        WHEN sub00.psp_end_nr = 2
        OR (
            sub00.psp_end_nr = 1
            AND sub00.in_wg_id = '-1'
        ) THEN 0
        ELSE 1
    END AS AUSBLEND, 
    
    sub00.menge_besch_best * FAKTOR AS menge_besch_best,
    ROUND(sub00.betrag_besch_best * FAKTOR, 4) AS betrag_besch_best,
    ROUND(sub00.betrag_besch_best_NT * FAKTOR, 4) AS betrag_besch_best_NT,
    sub00.betrag_obligo * FAKTOR AS betrag_obligo,
    sub00.betrag_obligo_NT * FAKTOR AS betrag_obligo_NT,
    sub00.betrag_obligo_plan * FAKTOR AS betrag_obligo_plan,
    
    sub00.betrag_ist_kosten * FAKTOR AS betrag_ist_kosten,
    
    sub00.betrag_ist_kosten_neu      * FAKTOR AS betrag_ist_kosten_neu,
    sub00.betrag_bkz      * FAKTOR AS betrag_bkz,
    sub00.betrag_infra    * FAKTOR AS betrag_infra,
    sub00.betrag_rueckst  * FAKTOR AS betrag_rueckst,
    sub00.betrag_ist_oRST_oINFRA * FAKTOR AS betrag_ist_oRST_oINFRA,
    
    
    sub00.infra_rueck_betrag_neu * FAKTOR AS infra_rueck_betrag_neu,
    sub00.betrag_ist_oRST_oINFRA_neu * FAKTOR AS betrag_ist_oRST_oINFRA_neu,
    
    sub00.betrag_ist_kosten_NT * FAKTOR AS betrag_ist_kosten_NT,
    
    Coalesce(
        psp_baukosten_34,
        psp_baukosten_28,
        psp_baukosten_27,
        psp_baukosten_26,
        psp_baukosten_24
    ) * FAKTOR AS psp_baukosten_zu_akt, 
    (ZEROIFNULL(sub00.betrag_kosten_prognose)) * FAKTOR AS betrag_kosten_prognose,
    
    
    
    Row_Number() OVER (PARTITION BY sub00.mandant_id,
        sub00.projekt_id,
        sub00.rpm_hierarchie_id,
        sub00.in_projekt_id,
        sub00.psp_id,
        sub00.land_id,
        sub00.wup_id,
        sub00.wup_standort,
        sub00.projekt_nr,
        sub00.psp_end_nr,
        sub00.in_wg_id,
        v99.wrg_typ_id,
        bvv.bvv_leist_id
    ORDER BY sub00.psp_id,v99.wrg_typ_id,bvv.bvv_leist_id) AS RowNumber,
    
    sub00.betrag_mmk_prognose * FAKTOR AS betrag_mmk_prognose,
    sub00.betrag_zea_prognose * FAKTOR AS betrag_zea_prognose,
    (
        ZEROIFNULL(sub00.betrag_ist_kosten) + ZEROIFNULL(sub00.betrag_obligo) + ZEROIFNULL(sub00.betrag_mmk_prognose) + ZEROIFNULL(sub00.betrag_zea_prognose)
    ) * FAKTOR AS betrag_hochrechnung,
    psp_kosten_prognose * FAKTOR AS psp_kosten_prognose,
    psp_zea_prognose * FAKTOR AS psp_zea_prognose,
    psp_MMK_prognose * FAKTOR AS psp_MMK_prognose,
    psp_C1_25 * FAKTOR AS psp_C1_25,
    psp_C2_26 * FAKTOR AS psp_C2_26,
    psp_A1_02 * FAKTOR AS psp_A1_02,
    projekt_B2_22 * FAKTOR AS projekt_B2_22,
    psp_C3_27 * FAKTOR AS psp_C3_27,
    psp_C4_28 * FAKTOR AS psp_C4_28,
    psp_B4_24 * FAKTOR AS psp_B4_24,
    projekt_B3_23 * FAKTOR AS projekt_B3_23,
    psp_C5_34 * FAKTOR AS psp_C5_34,
    psp_C6_29 * FAKTOR AS psp_C6_29,
    psp_C7_32 * FAKTOR AS psp_C7_32,
    psp_C6_38 * FAKTOR AS psp_C6_38,
    psp_C2_37 * FAKTOR AS psp_C2_37,
    bkz_A1_02 * FAKTOR AS bkz_A1_02,
    bkz_B4_24 * FAKTOR AS bkz_B4_24,
    Coalesce(
        psp_C5_34,
        psp_C6_38,
        psp_C4_28,
        psp_C3_27,
        psp_C2_26
    ) * FAKTOR AS psp_akt_prognose,
    ikpp.kosten_prognose_version_id,
    ikpp.dat_kosten_prognose_version,
    akt_budget_dat, 
    
    (CASE WHEN (sub00.bkz_B4_24 * FAKTOR) IS NOT NULL 
    THEN  (sub00.bkz_B4_24 * FAKTOR) 
    ELSE (sub00.bkz_A1_02 * FAKTOR)  
    END) -  (( CASE WHEN sub00.betrag_bkz IS NULL  THEN 0 ELSE   sub00.betrag_bkz END)    * FAKTOR) AS bkz_obligo, 
    
    (
        ZEROIFNULL(sub00.betrag_ist_kosten) + ZEROIFNULL(sub00.betrag_obligo) + ZEROIFNULL(sub00.betrag_mmk_prognose) + ZEROIFNULL(sub00.betrag_zea_prognose) - ZEROIFNULL(bkz_obligo) - ZEROIFNULL(betrag_bkz)
    ) * FAKTOR AS betrag_hochrechnung_ohne_BKZ,
    
    SUM(
        CASE
            WHEN sub00.psp_end_nr IN (1, 2) THEN pkw.betrag_konditionswert_gebucht
        END::DECIMAL(18, 4)
    ) AS psp_konditionswert_2,
    SUM(
        CASE
            WHEN sub00.psp_end_nr IN (1, 2, 3) THEN pkw.betrag_konditionswert_gebucht
        END::DECIMAL(18, 4)
    ) AS psp_betrag_konditionswert_gebucht,
    SUM(
        CASE
            WHEN sub00.psp_end_nr IN (1, 2, 3, 4) THEN pkw.betrag_konditionswert_ungebucht
        END::DECIMAL(18, 4)
    ) AS psp_betrag_konditionswert_ungebucht,
    SUM(
        CASE
            WHEN sub00.psp_end_nr IN (1, 2, 3)
            AND pkw.konditionsart_id IN (1060, 1110, 1120, 1320, 3110, 3310, 8060, 8320) THEN pkw.betrag_konditionswert_gebucht
        END::DECIMAL(18, 4)
    ) AS bkz_betrag_konditionswert_gebucht,
    SUM(
        CASE
            WHEN sub00.psp_end_nr IN (1, 2, 3)
            AND pkw.konditionsart_id IN (1060, 1110, 1120, 1320, 3110, 3310, 8060, 8320) THEN pkw.betrag_konditionswert_ungebucht
        END::DECIMAL(18, 4)
    ) AS bkz_betrag_konditionswert_ungebucht
FROM
    (
        
        SELECT
            sub02.land_id,
            sub02.mandant_id,
            sub02.wup_id,
            sub02.wup_standort,
            sub02.projekt_nr,
            sub02.projekt_id,
            sub02.rpm_projekt_typ_id,
            sub02.rpm_hierarchie_id,
            sub02.testmarkt_fg,
            
            sub02.lief_ist_kosten, 
            sub02.lief_obligo,  
            sub02.lief_best, 
            
            sub02.rpm_status_id,
            sub02.rpm_phase_id,
            sub02.rpm_phase_bez,
            sub02.wrg_id_rpm,
            sub02.ims_projekt_typ_id,
            sub02.in_projekt_id_char,
            sub02.in_projekt_id,
            sub02.psp_id_char,
            sub02.psp_id,
            sub02.psp_end_nr,
            sub02.in_wg_id,
            
            menge_besch_best,
            betrag_besch_best,
            betrag_besch_best_NT,
            betrag_obligo,
            betrag_obligo_NT,
            betrag_obligo_plan,
            
            betrag_ist_kosten,
            
            betrag_ist_kosten_neu,
            betrag_bkz,
            betrag_infra,
            betrag_rueckst,
            betrag_ist_oRST_oINFRA,
            
            
            infra_rueck_betrag_neu,
            betrag_ist_oRST_oINFRA_neu,
            
            betrag_ist_kosten_NT,
            
            ikp.betrag_kosten_prognose,
            ikp.betrag_mmk_prognose,
            ikp.betrag_zea_prognose,
            
            psp_C1_25,
            psp_C2_26,
            psp_A1_02,
            projekt_B2_22,
            psp_C3_27,
            psp_C4_28,
            psp_B4_24,
            projekt_B3_23,
            psp_C5_34,
            psp_C6_29,
            psp_C7_32,
            psp_C6_38,
            psp_C2_37,
            bkz_A1_02,
            bkz_B4_24,
            NULL AS psp_baukosten_24,
            NULL AS psp_baukosten_26,
            NULL AS psp_baukosten_27,
            NULL AS psp_baukosten_28,
            NULL AS psp_baukosten_34,
            NULL AS psp_baukosten_zu_akt,
            psp_kosten_prognose,
            psp_zea_prognose,
            psp_MMK_prognose,
            akt_budget_dat
        FROM
            (
                SELECT
                    sub01.land_id,
                    sub01.mandant_id,
                    sub01.wup_id,
                    sub01.wup_standort,
                    sub01.projekt_nr,
                    sub01.projekt_id,
                    sub01.rpm_projekt_typ_id,
                    sub01.rpm_hierarchie_id,
                    sub01.testmarkt_fg,
                    
                    sub01.lief_ist_kosten,
                    sub01.lief_obligo,
                    sub01.lief_best,
                    
                    sub01.rpm_status_id,
                    sub01.rpm_phase_id,
                    sub01.rpm_phase_bez,
                    sub01.wrg_id_rpm,
                    sub01.ims_projekt_typ_id,
                    sub01.in_projekt_id_char,
                    sub01.in_projekt_id,
                    sub01.psp_id_char,
                    sub01.psp_id, 
                    CASE
                        WHEN sub01.ims_projekt_typ_id = 'B' THEN 3
                        ELSE sub01.psp_end_nr
                    END AS psp_end_nr, 
                    CASE
                        WHEN sub01.ims_projekt_typ_id = 'B' THEN '-1'
                        ELSE sub01.in_wg_id
                    END AS in_wg_id, 
                    SUM(sub01.menge_best_bme) AS menge_besch_best,
                    SUM(sub01.betrag_besch_best) AS betrag_besch_best,
                    SUM(sub01.betrag_besch_best_NT) AS betrag_besch_best_NT,
                    SUM(sub01.betrag_obligo) AS betrag_obligo,
                    SUM(sub01.betrag_obligo_NT) AS betrag_obligo_NT,
                    SUM(sub01.betrag_obligo_plan) AS betrag_obligo_plan,
                    SUM(sub01.betrag_ist_kosten) AS betrag_ist_kosten,
                    
                    SUM(sub01.betrag_bkz)     AS  betrag_bkz,
                    SUM(sub01.betrag_ist_kosten_neu)     AS  betrag_ist_kosten_neu,
                    SUM(sub01.betrag_infra  )   AS  betrag_infra,
                    SUM(sub01.betrag_rueckst  ) AS  betrag_rueckst,
                    SUM(sub01.betrag_ist_oRST_oINFRA) AS betrag_ist_oRST_oINFRA,
                    
                    
                    SUM(sub01.infra_rueck_betrag_neu) AS infra_rueck_betrag_neu,
                    SUM(sub01.betrag_ist_oRST_oINFRA_neu) AS betrag_ist_oRST_oINFRA_neu,
                    
                    SUM(sub01.betrag_ist_kosten_NT) AS betrag_ist_kosten_NT,
                    SUM(psp_C1_25) AS psp_C1_25,
                    SUM(psp_C2_26) AS psp_C2_26,
                    SUM(psp_A1_02) AS psp_A1_02,
                    SUM(projekt_B2_22) AS projekt_B2_22,
                    SUM(psp_C3_27) AS psp_C3_27,
                    SUM(psp_C4_28) AS psp_C4_28,
                    SUM(psp_B4_24) AS psp_B4_24,
                    SUM(projekt_B3_23) AS projekt_B3_23,
                    SUM(psp_C5_34) AS psp_C5_34,
                    SUM(psp_C6_29) AS psp_C6_29,
                    SUM(psp_C7_32) AS psp_C7_32,
                    SUM(psp_C6_38) AS psp_C6_38,
                    SUM(psp_C2_37) AS psp_C2_37,
                    SUM(bkz_A1_02) AS bkz_A1_02,
                    SUM(bkz_B4_24) AS bkz_B4_24,
                    SUM(psp_kosten_prognose) AS psp_kosten_prognose,
                    SUM(betrag_zea_prognose) AS psp_zea_prognose,
                    SUM(betrag_MMK_prognose) AS psp_MMK_prognose,
                    MAX(akt_budget_dat) AS akt_budget_dat
                FROM
                    (
                        SELECT
                            psp.land_id,
                            psp.mandant_id,
                            psp.wup_id,
                            psp.wup_standort,
                            psp.projekt_nr,
                            psp.projekt_id,
                            psp.rpm_projekt_typ_id,
                            psp.rpm_hierarchie_id,
                            psp.testmarkt_fg,
                            psp.rpm_status_id,
                            psp.rpm_phase_id,
                            psp.rpm_phase_bez,
                            psp.wrg_id_rpm,
                            psp.ims_projekt_typ_id,
                            psp.in_projekt_id_char,
                            psp.in_projekt_id,
                            psp.psp_id_char,
                            psp.psp_id,
                            psp.psp_end_nr,
                            
                            fakt.lief_ist_kosten, 
                            fakt.lief_obligo, 
                            fakt.lief_best, 
                            
                            fakt.in_wg_id,
                            fakt.menge_best_bme,
                            fakt.betrag_besch_best,
                            fakt.betrag_besch_best_NT,
                            fakt.betrag_obligo,
                            fakt.betrag_obligo_NT,
                            fakt.betrag_obligo_plan,
                            fakt.betrag_ist_kosten,
                            
                            fakt.betrag_ist_kosten_neu,
                            fakt.betrag_bkz,
                            fakt.betrag_infra,
                            fakt.betrag_rueckst,
                            fakt.betrag_ist_oRST_oINFRA,
                            
                            
                            fakt.infra_rueck_betrag_neu,
                            fakt.betrag_ist_oRST_oINFRA_neu,
                            
                            fakt.betrag_ist_kosten_NT,
                            psp_C1_25,
                            psp_C2_26,
                            psp_A1_02,
                            projekt_B2_22,
                            psp_C3_27,
                            psp_C4_28,
                            psp_B4_24,
                            projekt_B3_23,
                            psp_C5_34,
                            psp_C6_29,
                            psp_C7_32,
                            psp_C6_38,
                            psp_C2_37,
                            bkz_A1_02,
                            bkz_B4_24,
                            psp_kosten_prognose,
                            betrag_zea_prognose,
                            betrag_MMK_prognose,
                            akt_budget_dat
                        FROM
                            (
                                
                                SELECT
                                    cpro.land_id,
                                    ipsp.mandant_id,
                                    COALESCE(wup.aktuell_wup_id, rpm.wup_id) AS wup_id,
                                    rpm.wup_standort,
                                    cpro.cpr_ext_id AS projekt_nr,
                                    cpro.projekt_id,
                                    rpm.rpm_projekt_typ_id,
                                    rpm.rpm_hierarchie_id,
                                    rpm.testmarkt_fg,
                                    rpm.rpm_status_id,
                                    rpm.rpm_phase_id,
                                    rpsz.rpm_phase_bez,
                                    rpm.wrg_id AS wrg_id_rpm,
                                    ipro.ims_projekt_typ_id,
                                    ipro.in_projekt_id_char,
                                    ipro.in_projekt_id,
                                    ipsp.psp_id_char,
                                    ipsp.psp_id,
                                    ipsp.psp_end_nr
                                FROM
                                    dbp_view.v_in_psp_element_2 ipsp
                                    JOIN dbp_view.v_in_projekt_2 ipro ON ipro.mandant_id = ipsp.mandant_id
                                    AND ipro.in_projekt_id = ipsp.in_projekt_id
                                    AND ipro.ims_projekt_typ_id IN ('E', 'G', 'B') 
                                    JOIN dbp_view.v_cpr_projekt_per_2 cpro ON cpro.cpr_ext_id = ipro.projekt_ext_id
                                    AND cpro.dat_bis = '9999-12-31'
                                    JOIN dbp_view.v_rpm_element_per_2 rpm ON rpm.projekt_id = cpro.cpr_ext_id
                                    AND rpm.dat_bis = '9999-12-31'
                                    JOIN dbp_view.v_rpm_phase_spr_zu_2 rpsz ON rpsz.rpm_phase_id = rpm.rpm_phase_id
                                    AND rpsz.rpm_projekt_typ_id = rpm.rpm_projekt_typ_id
                                    AND rpsz.spr_id = 22
                                    LEFT JOIN dbp_view.v_wup_2 wup_2 ON rpm.wup_id = wup.wup_id  
                                    AND rpm.mandant_id = wup.mandant_id 
                                GROUP BY
                                    cpro.land_id,
                                    ipsp.mandant_id,
                                    COALESCE(wup.aktuell_wup_id, rpm.wup_id),
                                    rpm.wup_standort,
                                    projekt_nr,
                                    cpro.projekt_id,
                                    rpm.rpm_projekt_typ_id,
                                    rpm.rpm_hierarchie_id,
                                    rpm.testmarkt_fg,
                                    rpm.rpm_status_id,
                                    rpm.rpm_phase_id,
                                    rpsz.rpm_phase_bez,
                                    wrg_id_rpm,
                                    ipro.ims_projekt_typ_id,
                                    ipro.in_projekt_id_char,
                                    ipro.in_projekt_id,
                                    ipsp.psp_id_char,
                                    ipsp.psp_id,
                                    ipsp.psp_end_nr
                            ) psp
                            LEFT JOIN ( 
                                
                                SELECT
                                    ibbk.psp_id,
                                    ibbk.mandant_id,
                                    COALESCE(in_wg_id, '-1') AS in_wg_id,
                                    ibbk.best_beleg_id,
                                    ibbk.best_beleg_pos_id,
                                    ibbk.kontierung_pos_id, 
                                    ibbd.unterposition_typ_id,
                                    ikd.bestell_text,
                                    
                                    ikd.lief_ist_kosten, 
                                    op.lief_obligo,  
                                    ibb.in_lief_id AS lief_best, 
                                    
                                    ibbd.menge_best_bme,
                                    ibbd.betrag_pos_netto_best_wrg * (
                                        CASE
                                            WHEN ibbd.retourenpos_fg = 1 THEN -1
                                            ELSE 1
                                        END
                                    ) AS betrag_besch_best,
                                    CASE
                                        WHEN unterposition_typ_id = 'N' THEN betrag_besch_best * 1.00
                                        ELSE betrag_besch_best * 0.00
                                    END AS betrag_besch_best_NT,
                                    op.betrag AS betrag_obligo,
                                    CASE
                                        WHEN unterposition_typ_id = 'N' THEN op.betrag * 1.00
                                        ELSE op.betrag * 0.00
                                    END AS betrag_obligo_NT,
                                    op.betrag_plan AS betrag_obligo_plan,
                                    ikd.anzahl,
                                    ikd.betrag AS betrag_ist_kosten,
                                    
                                    ikd.betrag_neu AS betrag_ist_kosten_neu,
                                    ikd.BKZ_Betrag AS betrag_bkz,
                                    ikd.INFRA_Betrag AS betrag_infra,
                                    ikd.RUECKST_Betrag AS betrag_rueckst,
                                    
                                    ikd.betrag - ZEROIFNULL(ikd.INFRA_Betrag) - ZEROIFNULL(ikd.RUECKST_Betrag) AS betrag_ist_oRST_oINFRA,
                                    
                                    
                                    ikd.infra_rueck_betrag_neu,
                                    ikd.betrag - ZEROIFNULL(ikd.infra_rueck_betrag_neu) AS betrag_ist_oRST_oINFRA_neu,
                                    
                                    CASE
                                        WHEN unterposition_typ_id = 'N' THEN betrag_ist_kosten * 1.00
                                        ELSE betrag_ist_kosten * 0.00
                                    END AS betrag_ist_kosten_NT,
                                    
                                    CAST(NULL AS DECIMAL(18, 4)) AS psp_C1_25,
                                    CAST (NULL AS DECIMAL(18, 4)) AS psp_C2_26,
                                    CAST (NULL AS DECIMAL(18, 4)) AS psp_A1_02,
                                    CAST (NULL AS DECIMAL(18, 4)) AS projekt_B2_22,
                                    CAST (NULL AS DECIMAL(18, 4)) AS psp_C3_27,
                                    CAST (NULL AS DECIMAL(18, 4)) AS psp_C4_28,
                                    CAST (NULL AS DECIMAL(18, 4)) AS psp_B4_24,
                                    CAST (NULL AS DECIMAL(18, 4)) AS projekt_B3_23,
                                    CAST (NULL AS DECIMAL(18, 4)) AS psp_C5_34,
                                    CAST (NULL AS DECIMAL(18, 4)) AS psp_C6_29,
                                    CAST (NULL AS DECIMAL(18, 4)) AS psp_C7_32,
                                    CAST (NULL AS DECIMAL(18, 4)) AS psp_C6_38,
                                    CAST (NULL AS DECIMAL(18, 4)) AS psp_C2_37,
                                    CAST (NULL AS DECIMAL(18, 4)) AS bkz_A1_02,
                                    CAST (NULL AS DECIMAL(18, 4)) AS bkz_B4_24,
                                    CAST (NULL AS DECIMAL(18, 4)) AS psp_kosten_prognose,
                                    CAST (NULL AS DECIMAL(18, 4)) AS betrag_zea_prognose,
                                    CAST (NULL AS DECIMAL(18, 4)) AS betrag_MMK_prognose,
                                    CAST(NULL AS DATE) AS akt_budget_dat
                                FROM
                                    (
                                        SELECT
                                            psp_id,
                                            mandant_id,
                                            best_beleg_id,
                                            best_beleg_pos_id,
                                            kontierung_pos_id
                                        FROM
                                            dbp_view.v_IN_besch_best_kontierung_2
                                    ) ibbk
                                    LEFT JOIN (
                                        
                                        SELECT
                                            ikd1.mandant_id,
                                            ikd1.in_lief_id AS lief_ist_kosten, 
                                            CASE
                                                WHEN ikd1.best_beleg_id = -1
                                                OR ikd1.best_beleg_id IS NULL THEN ibb.best_beleg_id
                                                ELSE ikd1.best_beleg_id
                                            END best_beleg_id,
                                            CASE
                                                WHEN ikd1.best_beleg_pos_id = 0 THEN ibb.best_beleg_pos_id
                                                ELSE ikd1.best_beleg_pos_id
                                            END best_beleg_pos_id,
                                            ikd1.psp_id,
                                            MAX(ikd1.bestell_text) bestell_text,
                                            SUM(ikd1.betrag) betrag,
                                            
                                            SUM(ikd1.betrag) - SUM ( CASE 
                                                                        WHEN ikd1.kostenart_id = '0000092300' 
                                                                        OR (ikd1.kostenart_id = '0000710170' AND ikd1.gegenkonto_id IN ('0000991907','0000710170','2000505972','0000750070') )   
                                                                        OR ikd1.kostenart_id = '0000750014' 
                                                                        OR ikd1.kostenart_id = '0000228000' --AP0264520_neue Kostenart_2
                                                                        THEN ikd1.betrag 
                                                                        ELSE 0 
                                                                        END  ) AS betrag_neu,
                                            SUM ( CASE 
                                                    WHEN ikd1.kostenart_id = '0000092300' 
                                                    OR (ikd1.kostenart_id = '0000710170' AND ikd1.gegenkonto_id IN ('0000991907','0000710170','2000505972','0000750070') )  
                                                    OR ikd1.kostenart_id = '0000750014' 
                                                    OR ikd1.kostenart_id = '0000228000' --AP0264520_neue Kostenart_2
                                                        THEN ikd1.betrag ELSE NULL END  ) AS BKZ_Betrag,
                                            SUM ( CASE 
                                                    WHEN ikd1.kostenart_id LIKE '%550100' THEN ikd1.betrag ELSE NULL END  ) AS INFRA_Betrag,
                                            SUM ( CASE 
                                                    WHEN (ikd1.kostenart_id = '0000514320')
                                                    OR (ikd1.kostenart_id = '0000514000' AND ikd1.gegenkonto_id IN ('0000097150','0000097800'))   
                                                    OR (ikd1.kostenart_id = '0000244900')
                                                    THEN ikd1.betrag 
                                                    ELSE NULL END  ) AS RUECKST_Betrag,
                                            
                                            
                                            
                                            SUM ( CASE 
                                                    WHEN ikd1.gegenkonto_id IN ('0000097500','0000097702','0000097150','0000097800','0000097602','0000097600','0000097610','0000099700','0000095610')
                                                    THEN ikd1.betrag
                                                    ELSE NULL END 
                                            ) AS infra_rueck_betrag_neu,
                                            
                                            COUNT(*) anzahl
                                        FROM
                                            dbp_view.v_ist_kosten_det_2 ikd1
                                            LEFT JOIN (
                                                SELECT
                                                    mandant_id,
                                                    folge_beleg_id,
                                                    dat_buch,
                                                    MAX(best_beleg_id) best_beleg_id,
                                                    MAX(best_beleg_pos_id) best_beleg_pos_id
                                                FROM
                                                    dbp_view.v_in_best_belegfluss_2
                                                GROUP BY
                                                    1,
                                                    2,
                                                    3
                                            ) ibb ON ikd1.ref_beleg_id = ibb.folge_beleg_id
                                            AND ikd1.dat_buch = ibb.dat_buch
                                            AND ikd1.mandant_id = ibb.mandant_id
                                        WHERE
                                            LTRIM(TRIM(COLLATE(ikd1.kostenart_id, '')), '0') NOT IN (
                                                '912000',
                                                '979002',
                                                'H912000',
                                                'H979002',
                                                '880100',
                                                '940003',
                                                '991907'
                                            )
                                            AND ikd1.hb2_fg = 1
                                            AND (
                                                CASE
                                                    WHEN ikd1.best_beleg_id = -1 THEN ibb.best_beleg_id
                                                    WHEN ikd1.best_beleg_id IS NULL THEN ibb.best_beleg_id
                                                    ELSE ikd1.best_beleg_id
                                                END,
                                                CASE
                                                    WHEN ikd1.best_beleg_pos_id = 0 THEN ibb.best_beleg_pos_id
                                                    ELSE ikd1.best_beleg_pos_id
                                                END,
                                                ikd1.mandant_id
                                            ) IN (
                                                SELECT
                                                    best_beleg_id,
                                                    best_beleg_pos_id,
                                                    mandant_id
                                                FROM
                                                    dbp_view.v_in_besch_best_kontierung_2
                                            )
                                        GROUP BY
                                            1,
                                            2,
                                            3,
                                            4,
                                            5
                                    ) ikd ON ikd.mandant_id = ibbk.mandant_id
                                    AND ikd.best_beleg_id = ibbk.best_beleg_id
                                    AND ikd.best_beleg_pos_id = ibbk.best_beleg_pos_id
                                    AND ikd.psp_id = ibbk.psp_id
                                    LEFT JOIN (
                                        
                                        SELECT
                                            *
                                        FROM
                                            dbp_view.v_in_besch_best_det_2
                                    ) ibbd ON ibbd.mandant_id = ibbk.mandant_id
                                    AND ibbd.best_beleg_id = ibbk.best_beleg_id
                                    AND ibbd.best_beleg_pos_id = ibbk.best_beleg_pos_id
                                    AND ibbd.loesch_id = '' 
                                    LEFT JOIN (
                                        
                                        SELECT
                                            mandant_id,
                                            krk_id,
                                            psp_id,
                                            kostenart_id,
                                            obligo_version_id,
                                            obligo_wrg_typ_id,
                                            gj,
                                            buchungsperiode_id,
                                            ref_beleg_id,
                                            ref_beleg_pos_id,
                                            ref_termin_pos_id,
                                            ref_kontierung_id,
                                            ref_objektart_id,
                                            in_lief_id AS lief_obligo,
                                            ref_beleg_typ_id,
                                            auftrag_id,
                                            dat_bis,
                                            loesch_id,
                                            wrg_id,
                                            menge_einh_id,
                                            buchungskreis_id,
                                            in_art_id,
                                            anlage_id,
                                            anlage_sub_id,
                                            kostenstelle_id,
                                            sparte_id,
                                            berichts_position_invest_id,
                                            berichts_position_it_id,
                                            psp_id_char_alt,
                                            bestell_text,
                                            bedarf_nr,
                                            SUM(betrag) betrag,
                                            SUM(menge) menge,
                                            SUM(betrag_plan) betrag_plan
                                        FROM
                                            dbp_view.v_obligo_per_2
                                        GROUP BY
                                            mandant_id,
                                            krk_id,
                                            psp_id,
                                            kostenart_id,
                                            obligo_version_id,
                                            obligo_wrg_typ_id,
                                            gj,
                                            buchungsperiode_id,
                                            ref_beleg_id,
                                            ref_beleg_pos_id,
                                            ref_termin_pos_id,
                                            ref_kontierung_id,
                                            ref_objektart_id,
                                            in_lief_id,
                                            ref_beleg_typ_id,
                                            auftrag_id,
                                            dat_bis,
                                            loesch_id,
                                            wrg_id,
                                            menge_einh_id,
                                            buchungskreis_id,
                                            in_art_id,
                                            anlage_id,
                                            anlage_sub_id,
                                            kostenstelle_id,
                                            sparte_id,
                                            berichts_position_invest_id,
                                            berichts_position_it_id,
                                            psp_id_char_alt,
                                            bestell_text,
                                            bedarf_nr
                                    ) op ON op.mandant_id = ibbd.mandant_id
                                    AND op.ref_beleg_id = ibbd.best_beleg_id
                                    AND op.ref_beleg_pos_id = ibbd.best_beleg_pos_id
                                    AND op.psp_id = ibbk.psp_id
                                    AND op.dat_bis = '9999-12-31' 
                                    AND CASE
                                        WHEN op.loesch_id = '' THEN 0
                                        ELSE op.loesch_id
                                    END = 0 
                                    
                                    
                                    LEFT JOIN dbp_view.v_in_besch_best_2 ibb
                                        ON  ibb.mandant_id = ibbd.mandant_id
                                        AND ibb.best_beleg_id = ibbd.best_beleg_id
                                    
                                GROUP BY
                                    ibbk.psp_id,
                                    ibbk.mandant_id,
                                    in_wg_id,
                                    ibbk.best_beleg_id,
                                    ibbk.best_beleg_pos_id,
                                    ibbk.kontierung_pos_id,
                                    ibbd.unterposition_typ_id,
                                    ikd.bestell_text,
                                    ibbd.menge_best_bme,
                                    betrag_besch_best,
                                    betrag_besch_best_NT,
                                    betrag_obligo,
                                    betrag_obligo_NT,
                                    betrag_obligo_plan,
                                    ikd.anzahl,
                                    
                                    ikd.lief_ist_kosten,
                                    op.lief_obligo,
                                    ibb.in_lief_id,
                                    
                                    betrag_ist_kosten,
                                    
                                    betrag_ist_kosten_neu,
                                    betrag_bkz,
                                    betrag_infra,
                                    betrag_rueckst,
                                    
                                    
                                    infra_rueck_betrag_neu,
                                    
                                    betrag_ist_kosten_NT,
                                    psp_C1_25,
                                    psp_C2_26,
                                    psp_A1_02,
                                    projekt_B2_22,
                                    psp_C3_27,
                                    psp_C4_28,
                                    psp_B4_24,
                                    projekt_B3_23,
                                    psp_C5_34,
                                    psp_C6_29,
                                    psp_C7_32,
                                    psp_C6_38,
                                    psp_C2_37,
                                    bkz_A1_02,
                                    bkz_B4_24,
                                    psp_kosten_prognose
                                UNION
                                ALL 
                                SELECT
                                    ipsp.psp_id,
                                    ipsp.mandant_id,
                                    '-1' AS in_wg_id,
                                    0 best_beleg_id,
                                    0 best_beleg_pos_id,
                                    0 kontierung_pos_id,
                                    '' AS unterposition_typ_id,
                                    ikd.bestell_text AS bestell_text,
                                    
                                    NULL AS lief_ist_kosten, 
                                    NULL AS lief_obligo, 
                                    NULL AS lief_best, 
                                    
                                    NULL AS menge_best_bme,
                                    NULL AS betrag_besch_best,
                                    NULL AS betrag_besch_best_NT,
                                    NULL AS betrag_obligo,
                                    NULL AS betrag_obligo_NT,
                                    NULL AS betrag_obligo_plan,
                                    ikd.anzahl,
                                    ikd.betrag AS betrag_ist_kosten,
                                    
                                    ikd.betrag_neu AS betrag_ist_kosten_neu,
                                    ikd.BKZ_Betrag AS betrag_bkz,
                                    ikd.INFRA_Betrag AS betrag_infra,
                                    ikd.RUECKST_Betrag AS betrag_rueckst,
                                    
                                    ikd.betrag - ZEROIFNULL(ikd.INFRA_Betrag) - ZEROIFNULL(ikd.RUECKST_Betrag) AS betrag_ist_oRST_oINFRA,
                                    
                                    
                                    ikd.infra_rueck_betrag_neu,
                                    ikd.betrag - ZEROIFNULL(ikd.infra_rueck_betrag_neu) AS betrag_ist_oRST_oINFRA_neu,
                                    
                                    ikd.betrag * 0::DECIMAL(18, 4) AS betrag_ist_kosten_NT,
                                    
                                    psp_C1_25,
                                    psp_C2_26,
                                    psp_A1_02,
                                    projekt_B2_22,
                                    psp_C3_27,
                                    psp_C4_28,
                                    psp_B4_24,
                                    projekt_B3_23,
                                    psp_C5_34,
                                    psp_C6_29,
                                    psp_C7_32,
                                    psp_C6_38,
                                    psp_C2_37,
                                    bkz_A1_02,
                                    bkz_B4_24,
                                    psp_kosten_prognose,
                                    betrag_zea_prognose,
                                    betrag_MMK_prognose,
                                    akt_budget_dat
                                FROM
                                    dbp_view.v_in_psp_element_2 ipsp
                                    JOIN dbp_view.v_in_projekt_2 ipro ON ipro.mandant_id = ipsp.mandant_id
                                    AND ipro.in_projekt_id = ipsp.in_projekt_id
                                    AND ipro.ims_projekt_typ_id IN ('E', 'G', 'B') 
                                    JOIN dbp_view.v_cpr_projekt_per_2 cpro ON cpro.cpr_ext_id = ipro.projekt_ext_id
                                    AND cpro.dat_bis = '9999-12-31'
                                    JOIN dbp_view.v_rpm_element_per_2 rpm ON rpm.projekt_id = cpro.cpr_ext_id
                                    AND rpm.dat_bis = '9999-12-31'
                                    LEFT JOIN (
                                        
                                        SELECT
                                            DISTINCT psp_id,
                                            mandant_id,
                                            '-' beleg_bez,
                                            '-' bestell_text,
                                            SUM(betrag) betrag,
                                            
                                            SUM(betrag) - SUM ( CASE 
                                                                        WHEN kostenart_id = '0000092300' 
                                                                        OR (kostenart_id = '0000710170' AND gegenkonto_id IN ('0000991907','0000710170','2000505972','0000750070') )   
                                                                        OR kostenart_id = '0000750014' 
                                                                        OR kostenart_id = '0000228000' --AP0264520_neue Kostenart_2
                                                                        THEN betrag 
                                                                        ELSE 0 
                                                                        END  ) AS betrag_neu,
                                            SUM ( CASE 
                                                    WHEN kostenart_id = '0000092300' 
                                                    OR ( kostenart_id = '0000710170' AND gegenkonto_id IN ('0000991907','0000710170','2000505972','0000750070') )  
                                                    OR kostenart_id = '0000750014'
                                                    OR kostenart_id = '0000228000' --AP0264520_neue Kostenart_2  
                                                        THEN betrag ELSE NULL END  ) AS BKZ_Betrag,
                                            SUM ( CASE 
                                                    WHEN kostenart_id LIKE '%550100' THEN betrag ELSE NULL END  ) AS INFRA_Betrag,
                                            SUM ( CASE 
                                                    WHEN (kostenart_id = '0000514320')
                                                    OR (kostenart_id = '0000514000' AND gegenkonto_id IN ('0000097150','0000097800'))   
                                                    OR (kostenart_id = '0000244900' )
                                                    THEN betrag 
                                                    ELSE NULL END  ) AS RUECKST_Betrag,
                                            
                                            
                                            SUM ( CASE 
                                                    WHEN gegenkonto_id IN ('0000097500','0000097702','0000097150','0000097800','0000097602','0000097600','0000097610','0000099700','0000095610')
                                                    THEN betrag
                                                    ELSE NULL END 
                                            ) AS infra_rueck_betrag_neu,
                                            
                                            COUNT(*) anzahl
                                        FROM
                                            dbp_view.v_ist_kosten_det_2
                                        WHERE
                                            (mandant_id, beleg_id, beleg_pos_id) NOT IN (
                                                SELECT
                                                    ikd.mandant_id,
                                                    beleg_id,
                                                    beleg_pos_id
                                                FROM
                                                    dbp_view.v_ist_kosten_det_2 ikd
                                                    LEFT JOIN (
                                                        SELECT
                                                            mandant_id,
                                                            folge_beleg_id,
                                                            dat_buch,
                                                            MAX(best_beleg_id) best_beleg_id,
                                                            MAX(best_beleg_pos_id) best_beleg_pos_id
                                                        FROM
                                                            dbp_view.v_in_best_belegfluss_2
                                                        GROUP BY
                                                            1,
                                                            2,
                                                            3
                                                    ) ibb ON ikd.ref_beleg_id = ibb.folge_beleg_id
                                                    AND ikd.dat_buch = ibb.dat_buch
                                                    AND ikd.mandant_id = ibb.mandant_id
                                                WHERE
                                                    LTRIM(TRIM(COLLATE(ikd.kostenart_id, '')), '0') NOT IN (
                                                        '912000',
                                                        '979002',
                                                        'H912000',
                                                        'H979002',
                                                        '880100',
                                                        '940003',
                                                        '991907'
                                                    )
                                                    AND ikd.hb2_fg = 1
                                                    AND (
                                                        CASE
                                                            WHEN ikd.best_beleg_id = -1 THEN ibb.best_beleg_id
                                                            WHEN ikd.best_beleg_id IS NULL THEN ibb.best_beleg_id
                                                            ELSE ikd.best_beleg_id
                                                        END,
                                                        CASE
                                                            WHEN ikd.best_beleg_pos_id = 0 THEN ibb.best_beleg_pos_id
                                                            ELSE ikd.best_beleg_pos_id
                                                        END,
                                                        ikd.mandant_id
                                                    ) IN (
                                                        SELECT
                                                            best_beleg_id,
                                                            best_beleg_pos_id,
                                                            mandant_id
                                                        FROM
                                                            dbp_view.v_in_besch_best_kontierung_2
                                                    )
                                            )
                                            AND LTRIM(TRIM(COLLATE(kostenart_id, '')), '0') NOT IN (
                                                '912000',
                                                '979002',
                                                'H912000',
                                                'H979002',
                                                '880100',
                                                '940003',
                                                '991907'
                                            )
                                            AND hb2_fg = 1
                                        GROUP BY
                                            1,
                                            2
                                      
                                    ) ikd ON ikd.psp_id = ipsp.psp_id
                                    AND ikd.mandant_id = ipsp.mandant_id
                                    LEFT JOIN (
                                        
                                        SELECT
                                            mandant_id,
                                            rpm_hierarchie_id,
                                            psp_end_nr,
                                            wrg_id,
                                            Sum(psp_C1_25) AS psp_C1_25,
                                            Sum(psp_C2_26) AS psp_C2_26,
                                            Sum(psp_A1_02) AS psp_A1_02,
                                            Sum(projekt_B2_22) AS projekt_B2_22,
                                            Sum(psp_C3_27) AS psp_C3_27,
                                            Sum(psp_C4_28) AS psp_C4_28,
                                            Sum(psp_B4_24) AS psp_B4_24,
                                            Sum(projekt_B3_23) AS projekt_B3_23,
                                            Sum(psp_C5_34) AS psp_C5_34,
                                            Sum(psp_C6_29) AS psp_C6_29,
                                            Sum(psp_C7_32) AS psp_C7_32,
                                            Sum(psp_C6_38) AS psp_C6_38,
                                            Sum(psp_C2_37) AS psp_C2_37,
                                            Sum(bkz_A1_02) AS bkz_A1_02,
                                            Sum(bkz_B4_24) AS bkz_B4_24,
                                            Sum(psp_kosten_prognose) AS psp_kosten_prognose,
                                            Sum(betrag_zea_prognose) AS betrag_zea_prognose,
                                            Sum(betrag_MMK_prognose) AS betrag_MMK_prognose,
                                            Max(akt_budget_dat) AS akt_budget_dat
                                        FROM
                                            (
                                                
                                                SELECT
                                                    rpm.mandant_id,
                                                    rpm.rpm_hierarchie_id,
                                                    rpm.rpm_projekt_typ_id,
                                                    rpm.rpm_phase_id,
                                                    rpm.rpm_status_id,
                                                    rfp.dat_start,
                                                    rfp.dat_von,
                                                    rfp.dat_bis,
                                                    rpm.projekt_id AS projekt_nr,
                                                    rfk.fin_kategorie_id,
                                                    rfg.fin_gruppe_id,
                                                    rfp.rpm_plantyp_id,
                                                    CASE
                                                        
                                                        WHEN rfg.fin_gruppe_id IN ('FK0110_FG0110', 'FK0170_FG0110', 'FK0180_FG0110') THEN 1 
                                                        WHEN rfg.fin_gruppe_id IN ('FK0110_FG0120', 'FK0170_FG0120', 'FK0180_FG0120') THEN 2 
                                                        WHEN rfg.fin_gruppe_id IN ('FK0120_FG0110') THEN 3 
                                                        WHEN rfg.fin_gruppe_id IN ('FK0120_FG0120') THEN 4 
                                                        WHEN rfg.fin_gruppe_id IN ('FK0130_FG0110') THEN 5 
                                                        WHEN rfg.fin_gruppe_id IN ('FK0130_FG0120') THEN 6 
                                                        WHEN rfg.fin_gruppe_id IN ('FK0130_FG0130') THEN 7 
                                                        
                                                        WHEN rfg.fin_gruppe_id IN ('FK0160_FG0120') THEN 3 
                                                        WHEN rfg.fin_gruppe_id IN ('FK0120_FG0130') THEN 3 
                                                        ELSE -1 
                                                    END::BYTEINT AS psp_end_nr,
                                                    CASE
                                                        
                                                        WHEN rfg.fin_gruppe_id IN (
                                                            'FK0110_FG0110',
                                                            'FK0110_FG0120',
                                                            'FK0170_FG0110',
                                                            'FK0180_FG0110',
                                                            'FK0170_FG0120',
                                                            'FK0180_FG0120'
                                                        ) THEN 1 
                                                        WHEN rfg.fin_gruppe_id IN (
                                                            'FK0120_FG0110',
                                                            'FK0120_FG0120',
                                                            'FK0130_FG0110',
                                                            'FK0130_FG0120',
                                                            'FK0130_FG0130'
                                                        ) THEN 2 
                                                        WHEN rfg.fin_gruppe_id IN ('FK0120_FG0130') THEN 9 
                                                        WHEN rfg.fin_gruppe_id IN ('FK0160_FG0120') THEN 3 
                                                        ELSE -1
                                                    END::BYTEINT AS fin_fg,
                                                    rfp.wrg_id,
                                                    rfp.betrag,
                                                    
                                                    CASE
                                                        WHEN rfg.fin_gruppe_id IN ('FK0170_FG0110', 'FK0170_FG0120')
                                                        AND psp_end_nr IN(1, 2) THEN rfp.betrag
                                                    END AS betrag_zea_prognose,
                                                    CASE
                                                        WHEN rfg.fin_gruppe_id IN ('FK0180_FG0110', 'FK0180_FG0120')
                                                        AND psp_end_nr IN(1, 2) THEN rfp.betrag
                                                    END AS betrag_MMK_prognose,
                                                    
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (25)
                                                        AND fin_fg = 2 THEN rfp.betrag
                                                    END AS psp_C1_25, 
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (26)
                                                        AND fin_fg = 2 THEN rfp.betrag
                                                    END AS psp_C2_26, 
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (2)
                                                        AND fin_fg IN (1, 2, 9) THEN rfp.betrag
                                                    END AS psp_A1_02, 
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (22)
                                                        AND fin_fg = 3 THEN rfp.betrag
                                                    END AS projekt_B2_22, 
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (27)
                                                        AND fin_fg = 2 THEN rfp.betrag
                                                    END AS psp_C3_27, 
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (28)
                                                        AND fin_fg = 2 THEN rfp.betrag
                                                    END AS psp_C4_28, 
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (24)
                                                        AND fin_fg IN (1, 2, 9) THEN rfp.betrag
                                                    END AS psp_B4_24, 
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (23)
                                                        AND fin_fg = 3 THEN rfp.betrag
                                                    END AS projekt_B3_23, 
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (34)
                                                        AND fin_fg = 2 THEN rfp.betrag
                                                    END AS psp_C5_34, 
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (29)
                                                        AND fin_fg = 2 THEN rfp.betrag
                                                    END AS psp_C6_29, 
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (32)
                                                        AND fin_fg = 2 THEN rfp.betrag
                                                    END AS psp_C7_32, 
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (2)
                                                        AND fin_fg IN (9) THEN rfp.betrag
                                                    END AS bkz_A1_02, 
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (24)
                                                        AND fin_fg IN (9) THEN rfp.betrag
                                                    END AS bkz_B4_24, 
                                                    
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (38)
                                                        AND fin_fg = 2 THEN rfp.betrag
                                                    END AS psp_C6_38, 
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (37)
                                                        AND fin_fg = 2 THEN rfp.betrag
                                                    END AS psp_C2_37, 
                                                    
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (22)
                                                        AND fin_fg = 3 THEN rfk.fin_kat_version_id
                                                    END AS wkb_ver_id, 
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (22)
                                                        AND fin_fg = 3 THEN rfk.fin_kat_version_dat
                                                    END::DATE AS wkb_ver_dat, 
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (24)
                                                        AND rfg.fin_gruppe_id NOT IN ('FK0120_FG0130') THEN rfk.fin_kat_version_id
                                                    END AS ea_ver_id, 
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (24)
                                                        AND rfg.fin_gruppe_id NOT IN ('FK0120_FG0130') THEN rfk.fin_kat_version_dat
                                                    END::DATE AS ea_ver_dat, 
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (24)
                                                        AND rfg.fin_gruppe_id IN ('FK0110_FG0110', 'FK0110_FG0120') THEN rfp.betrag
                                                    END AS psp_kosten_prognose, 
                                                    
                                                    
                                                    CASE
                                                        WHEN rfp.rpm_plantyp_id IN (24) THEN rfk.fin_kat_version_dat
                                                        ELSE NULL
                                                    END AS akt_budget_dat
                                                FROM
                                                    dbp_view.v_rpm_element_per_2 rpm
                                                    JOIN dbp_view.v_rpm_fin_kategorie_2 rfk ON rfk.rpm_hierarchie_id = rpm.rpm_hierarchie_id
                                                    JOIN dbp_view.v_rpm_fin_gruppe_2 rfg ON rfg.fin_kat_hierarchie_id = rfk.fin_kat_hierarchie_id
                                                    JOIN dbp_view.v_rpm_fin_plan_2 rfp ON rfp.fin_gruppe_hierarchie_id = rfg.fin_gruppe_hierarchie_id
                                                    AND rfp.dat_bis = '9999-12-31'
                                                    AND rfp.rpm_plantyp_id IN (2, 22, 23, 24, 25, 26, 27, 28, 29, 32, 34, 35, 36, 37, 38) 
                                                    AND rfp.betrag <> 0 
                                                WHERE
                                                    rpm.rpm_status_id <> -1 
                                                    AND rpm.dat_bis = '9999-12-31'
                                            ) sub04
                                        GROUP BY
                                            sub04.mandant_id,
                                            sub04.rpm_hierarchie_id,
                                            sub04.psp_end_nr,
                                            sub04.wrg_id
                                    ) ppm ON ppm.rpm_hierarchie_id = rpm.rpm_hierarchie_id
                                    AND ppm.mandant_id = rpm.mandant_id
                                    AND ppm.psp_end_nr = ipsp.psp_end_nr
                            ) fakt ON psp.psp_id = fakt.psp_id
                            AND psp.mandant_id = fakt.mandant_id
                    ) sub01
                GROUP BY
                    sub01.land_id,
                    sub01.mandant_id,
                    sub01.wup_id,
                    sub01.wup_standort,
                    sub01.projekt_nr,
                    sub01.projekt_id,
                    sub01.rpm_projekt_typ_id,
                    sub01.rpm_hierarchie_id,
                    sub01.testmarkt_fg,
                    
                    sub01.lief_ist_kosten,
                    sub01.lief_obligo,
                    sub01.lief_best,
                    
                    sub01.rpm_status_id,
                    sub01.rpm_phase_id,
                    sub01.rpm_phase_bez,
                    sub01.wrg_id_rpm,
                    sub01.ims_projekt_typ_id,
                    sub01.in_projekt_id_char,
                    sub01.in_projekt_id,
                    sub01.psp_id_char,
                    sub01.psp_id,
                    psp_end_nr,
                    in_wg_id
            ) sub02
            LEFT JOIN (
                
                SELECT
                    mandant_id,
                    in_projekt_id,
                    psp_id,
                    in_wg_id,
                    betrag_kosten_prognose,
                    betrag_mmk_prognose,
                    betrag_zea_prognose,
                    wrg_id
                FROM
                    dbp_view.v_in_kosten_prognose_2
            ) ikp ON ikp.mandant_id = sub02.mandant_id
            AND ikp.psp_id = sub02.psp_id
            AND ikp.in_wg_id = sub02.in_wg_id
        UNION
        ALL 
        SELECT
            psp.land_id,
            psp.mandant_id,
            psp.wup_id,
            psp.wup_standort,
            psp.projekt_nr,
            psp.projekt_id,
            psp.rpm_projekt_typ_id,
            psp.rpm_hierarchie_id,
            psp.testmarkt_fg,
             
            NULL AS lief_ist_kosten, 
            NULL  AS lief_obligo,  
            NULL AS lief_best, 
            
            psp.rpm_status_id,
            psp.rpm_phase_id,
            psp.rpm_phase_bez,
            psp.wrg_id_rpm,
            psp.ims_projekt_typ_id,
            psp.in_projekt_id_char,
            psp.in_projekt_id,
            psp.psp_id_char,
            psp.psp_id,
            psp.psp_end_nr,
            ikp.in_wg_id,
            
            NULL AS menge_besch_best,
            NULL AS betrag_besch_best,
            NULL AS betrag_besch_best_NT,
            NULL AS betrag_obligo,
            NULL AS betrag_obligo_NT,
            NULL AS betrag_obligo_plan,
            NULL AS betrag_ist_kosten,
            
            NULL AS betrag_ist_kosten_neu,
            NULL AS betrag_bkz,
            NULL AS betrag_infra,
            NULL AS betrag_rueckst,
            NULL AS betrag_ist_oRST_oINFRA,
            
            
            NULL AS infra_rueck_betrag_neu,
            NULL AS betrag_ist_oRST_oINFRA_neu,
            
            NULL AS betrag_ist_kosten_NT,
            
            SUM(ikp.betrag_kosten_prognose) AS betrag_kosten_prognose,
            SUM(ikp.betrag_mmk_prognose) AS betrag_mmk_prognose,
            SUM(ikp.betrag_zea_prognose) AS betrag_zea_prognose,
            
            NULL AS psp_baukosten_24,
            NULL AS psp_baukosten_26,
            NULL AS psp_baukosten_27,
            NULL AS psp_baukosten_28,
            NULL AS psp_baukosten_34,
            NULL AS psp_baukosten_zu_akt,
            NULL AS psp_kosten_prognose,
            NULL AS psp_zea_prognose,
            NULL AS psp_MMK_prognose,
            NULL AS akt_budget_dat,
            NULL AS psp_C1_25,
            NULL AS psp_C2_26,
            NULL AS psp_A1_02,
            NULL AS projekt_B2_22,
            NULL AS psp_C3_27,
            NULL AS psp_C4_28,
            NULL AS psp_B4_24,
            NULL AS projekt_B3_23,
            NULL AS psp_C5_34,
            NULL AS psp_C6_29,
            NULL AS psp_C7_32,
            NULL AS psp_C6_38,
            NULL AS psp_C2_37,
            NULL AS bkz_A1_02,
            NULL AS bkz_B4_24
        FROM
            (
                
                SELECT
                    cpro.land_id,
                    ipsp.mandant_id,
                    COALESCE(wup.aktuell_wup_id, rpm.wup_id) AS wup_id,
                    rpm.wup_standort,
                    cpro.cpr_ext_id AS projekt_nr,
                    cpro.projekt_id,
                    rpm.rpm_projekt_typ_id,
                    rpm.rpm_hierarchie_id,
                    rpm.testmarkt_fg,
                    rpm.rpm_status_id,
                    rpm.rpm_phase_id,
                    rpsz.rpm_phase_bez,
                    rpm.wrg_id AS wrg_id_rpm,
                    ipro.ims_projekt_typ_id,
                    ipro.in_projekt_id_char,
                    ipro.in_projekt_id,
                    ipsp.psp_id_char,
                    ipsp.psp_id,
                    ipsp.psp_end_nr
                FROM
                    dbp_view.v_in_psp_element_2 ipsp
                    JOIN dbp_view.v_in_projekt_2 ipro ON ipro.mandant_id = ipsp.mandant_id
                    AND ipro.in_projekt_id = ipsp.in_projekt_id
                    AND ipro.ims_projekt_typ_id IN ('E', 'G', 'B') 
                    JOIN dbp_view.v_cpr_projekt_per_2 cpro ON cpro.cpr_ext_id = ipro.projekt_ext_id
                    AND cpro.dat_bis = '9999-12-31'
                    JOIN dbp_view.v_rpm_element_per_2 rpm ON rpm.projekt_id = cpro.cpr_ext_id
                    AND rpm.dat_bis = '9999-12-31'
                    JOIN dbp_view.v_rpm_phase_spr_zu_2 rpsz ON rpsz.rpm_phase_id = rpm.rpm_phase_id
                    AND rpsz.rpm_projekt_typ_id = rpm.rpm_projekt_typ_id
                    AND rpsz.spr_id = 22
                    LEFT JOIN dbp_view.v_wup_2 wup_2 ON rpm.wup_id = wup.wup_id
                    AND rpm.mandant_id = wup.mandant_id
            ) psp
            JOIN (
                
                SELECT
                    mandant_id,
                    in_projekt_id,
                    psp_id,
                    in_wg_id,
                    betrag_kosten_prognose,
                    betrag_mmk_prognose,
                    betrag_zea_prognose,
                    wrg_id
                FROM
                    dbp_view.v_in_kosten_prognose_2
                WHERE
                    in_wg_id <> '-1' 
                    AND (mandant_id, psp_id, in_wg_id) NOT IN (
                        SELECT
                            ibbk.mandant_id,
                            ibbk.psp_id,
                            ibbd.in_wg_id
                        FROM
                            dbp_view.v_in_besch_best_kontierung_2 ibbk
                            JOIN dbp_view.v_in_besch_best_det_2 ibbd ON ibbd.best_beleg_id = ibbk.best_beleg_id
                            AND ibbd.best_beleg_pos_id = ibbk.best_beleg_pos_id
                            AND ibbd.mandant_id = ibbk.mandant_id
                            AND ibbd.loesch_id = '' 
                            AND ibbk.psp_id > 0
                    )
            ) ikp ON ikp.psp_id = psp.psp_id
            AND ikp.mandant_id = psp.mandant_id 
        GROUP BY
            psp.land_id,
            psp.mandant_id,
            psp.wup_id,
            psp.wup_standort,
            psp.projekt_nr,
            psp.projekt_id,
            psp.rpm_projekt_typ_id,
            psp.rpm_hierarchie_id,
            psp.testmarkt_fg,
            
            lief_ist_kosten, 
            lief_obligo,  
            lief_best, 
            
            psp.rpm_status_id,
            psp.rpm_phase_id,
            psp.rpm_phase_bez,
            psp.wrg_id_rpm,
            psp.ims_projekt_typ_id,
            psp.in_projekt_id_char,
            psp.in_projekt_id,
            psp.psp_id_char,
            psp.psp_id,
            psp.psp_end_nr,
            ikp.in_wg_id,
            
            menge_besch_best,
            betrag_besch_best,
            betrag_besch_best_NT,
            betrag_obligo,
            betrag_obligo_NT,
            betrag_obligo_plan,
            betrag_ist_kosten,
            
            betrag_ist_kosten_neu,
            betrag_bkz,
            betrag_infra,
            betrag_rueckst,
            betrag_ist_oRST_oINFRA,
            
            
            infra_rueck_betrag_neu,
            betrag_ist_oRST_oINFRA_neu,
            
            betrag_ist_kosten_NT
    ) sub00
    LEFT JOIN (
        
        SELECT
            DISTINCT lpwz.mandant_id,
            lbl.psp_end_nr,
            lpwz.in_wg_id,
            lpwz.bvv_leist_id
            
        FROM
            dbp_view.v_leistung_psp_wg_zu_2 lpwz
            JOIN dbp_view.v_l_bvv_leistung_2 lbl ON lbl.bvv_leist_id = lpwz.bvv_leist_id
    ) bvv ON bvv.mandant_id = sub00.mandant_id
    AND bvv.psp_end_nr = sub00.psp_end_nr
    AND bvv.in_wg_id = sub00.in_wg_id
    LEFT JOIN dbp_view.v_in_kosten_prognose_2 ikpp ON ikpp.mandant_id = sub00.mandant_id
    AND ikpp.psp_id = sub00.psp_id
    AND ikpp.in_wg_id = sub00.in_wg_id
    JOIN dbp_view.v_mandant_wrg_typ_zu_2 v99 ON v99.mandant_id = sub00.mandant_id 
    LEFT JOIN (
        SELECT
            pkw2.mandant_id mandant_id,
            pkw2.psp_id psp_id,
            pkw2.wrg_id wrg_id,
            pkw2.konditionsart_id konditionsart_id,
            pkw2.wrg_typ_id,
            '-1' AS in_wg_id,
            
            SUM(pkw2.betrag_konditionswert_gebucht) AS betrag_konditionswert_gebucht,
            SUM(pkw2.betrag_konditionswert_ungebucht) AS betrag_konditionswert_ungebucht
        FROM
            (
                SELECT
                    DISTINCT pkw.mandant_id mandant_id,
                    pkw.psp_id psp_id,
                    kurs.nach_wrg_id wrg_id,
                    konditionsart_id konditionsart_id,
                    kurs.wrg_typ_id,
                    
                    CASE
                        WHEN pkw.wrg_id = kurs.wrg_id THEN betrag_konditionswert_gebucht
                        ELSE betrag_konditionswert_gebucht * FAKTOR
                    END AS betrag_konditionswert_gebucht,
                    CASE
                        WHEN pkw.wrg_id = kurs.wrg_id THEN betrag_konditionswert_ungebucht
                        ELSE betrag_konditionswert_ungebucht * FAKTOR
                    END AS betrag_konditionswert_ungebucht
                FROM
                    dbp_view.v_psp_konditionswert_2 pkw
                    LEFT JOIN dbp_view.v_mandant_wrg_typ_zu_2 v99 ON v99.mandant_id = pkw.mandant_id 
                    AND v99.wrg_id = pkw.wrg_id
                    JOIN dbp_msi_view_ios.mv_user_kurs_konditionswert_2 kurs_2 ON kurs.mandant_id = pkw.mandant_id
                    AND kurs.von_wrg_id = pkw.wrg_id
                

            ) pkw2 
        GROUP BY
            1,
            2,
            3,
            4,
            5
    ) pkw 
    ON pkw.mandant_id = sub00.mandant_id
    AND pkw.psp_id = sub00.psp_id
    AND pkw.in_wg_id = sub00.in_wg_id
    AND v99.wrg_id = pkw.wrg_id
    AND v99.wrg_typ_id = pkw.wrg_typ_id 
    
    JOIN dbp_msi_view_ios.mv_user_kurs_2 kurs_2 ON kurs.mandant_id = v99.mandant_id 
    AND kurs.wrg_typ_id = v99.wrg_typ_id
    AND kurs.wrg_id = v99.wrg_id
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42, 
    43,
    44,
    45, 
    46, 
    
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59,
    60,
    61,
    62,
    63,
    64,
    65,
    66,
    67,
    68,
    69,
    70,71,72,73,74;