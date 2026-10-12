
CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_BVV_BESCH_BEST_1(
	LAND_ID,
	MANDANT_ID,
	WUP_ID,
	WUP_STANDORT,
	PROJEKT_NR,
	PROJEKT_ID,
	RPM_PROJEKT_TYP_ID,
	RPM_HIERARCHIE_ID,
	TESTMARKT_FG,
	RPM_PHASE_ID,
	RPM_PHASE_BEZ,
	WRG_ID_RPM,
	IMS_PROJEKT_TYP_ID,
	IN_PROJEKT_ID_CHAR,
	IN_PROJEKT_ID,
	PSP_ID_CHAR,
	PSP_ID,
	PSP_END_NR,
	WG_PSP_END_NR,
	IN_LIEF_ID,
	IN_WG_ID,
	BVV_LEIST_ID,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	ENDRECH_FG,
	KONTIERUNG_POS_ID,
	UNTERPOSITION_TYP_ID,
	BESTELL_TEXT,
	MENGE_BEST_BME,
	KURS_1,
	WRG_ID,
	WRG_TYP_ID,
	FAKTOR,
	AUSBLEND,
	RANG,
	RANG2,
	PSP_BETRAG_KONDITIONSWERT_GEBUCHT,
	PSP_BETRAG_KONDITIONSWERT_UNGEBUCHT,
	PSP_BETRAG_KONDITIONSWERT,
	BETRAG_BESCH_BEST_0,
	BETRAG_BESCH_BEST_NT_0,
	BETRAG_OBLIGO_0,
	BETRAG_OBLIGO_NT_0,
	BETRAG_IST_KOSTEN_0,
	EINBEHALT_ABNAHME,
	EINBEHALT_SICHERHEIT,
	EINBEHALT_GEWAEHRLEISTUNG,
	EINBEHALT_VERTRAGSSTRAFE,
	EINBEHALT_RECHNUNGEN,
	EINBEHALT_SUBUNTERNEHMER,
	BETRAG_ABSCHLAG_01,
	BETRAG_ABSCHLAG_02,
	BETRAG_ABSCHLAG_03,
	BETRAG_ABSCHLAG_04,
	BETRAG_ABSCHLAG_05,
	BETRAG_ABSCHLAG_06,
	BETRAG_ABSCHLAG_07,
	BETRAG_ABSCHLAG_08,
	BETRAG_ABSCHLAG_09,
	BETRAG_ABSCHLAG_10,
	BETRAG_ABSCHLAG_1X,
	BVV_AKTE_ID,
	BVV_AKTE_BEZ,
	BVV_VERTRAG_NR,
	DAT_VERTRAG_BEGINN,
	EINKAEUFER_GRP_ID
) AS 
-- FAKT : Verknuepfung : cProject - RPM - PSP - Kontierung - Bestellung - IST Kosten
-- 2015-10-06 ssch0611 : Projekt 0533 intitial
-- 2015-11-27 ssch0611 : Review
-- 2016-01-04 kkai0912 : Akte, Lieferant eingebaut
-- 2016-02-15 ssch0611 : Filter/Where Betrag angepasst
-- 20160504 ssch0611 : Waehrungsumrechnung + selektives Ausblenden PSP-End-Nr 1/2, in_lief Join verschoben
-- 20160707 kkai0912: Ergänzung um Einkäufer ID
-- 20160719 ssch0611 : AUSGEBAUT:  selektives Ausblenden PSP-End-Nr 1/2
-- 20161221 tuts1605 : Split psp_konditionswert_1 in psp_konditionswert_gebucht & psp_konditionswert_ungebucht wurde eingebaut
-- 20170502 hmue2308: Fakten einbauen
-- 20170619 msar2108: Filterung IST-Kosten auf kostenart_id umgestellt, Referenz auf Bestellbeleg um dat_buch und mandant_id erweitert
-- 20170705 msar2108: Filterung IST-Kosten auf hb2_fg = 1
-- 20170804 kmor0912: Summenbildung für obligo
-- 20170815 msar2108: Join für IST-Kosten zur Bestellung um PSP_ID erweitert
-- 20170818 msar2108: Einbehalte auskommentiert.
-- 20170823 hmue2308: siehe AP0011585, SPEC0027557
-- 20171107 hmue2308: Anpassung Konditionswert AP0015930, SPEC0028048 (siehe Excel-Datei)
-- 20180207 nfis0811: SPEC0033158 Einfügen rech_beleg_id und Berücksichtigung bei Rangfolgenbildung
-- 20180302 nfis0811: AP0018748 - Einführung Rangfolgenbildung Abschlagszahlung; Anpassung Rangfolgenbildung Rest
-- 20180425 nfis0811: NSR0156939 - Kostenart_1 48011  Reaktiviierung
-- 20180615 nfis0811: Internationalisierung - auskommentieren bvv_leist_bez
-- 190514 nfis: SPEC0054930
-- 20200227 cbru1709: NSR1266666 Daten aus REFX blockieren (vorerst)
-- 20210204 richternic: SPEC0101029  
-- 20211222 richternic: INC4011470
-- 20220602 richternic: SPEC0132070 Anpassung Konditionswerte
-- 20220706 richternic: NSR2968527 Reaktivierung KMO Konditionswerte
-- 20220622 richternic: NSR2968527_IOS_KMO_Vertragswerte Berechnungsanpassung 
-- 20230908 staeblern: SPEC0215649 -> Konditionwerte auf Buchung ohne Bestellungen mappen 
-- 20231012 richternic: SPEC0153562 Mapping Leistung zu WG -> Falls Gewerk nicht passt, dann Leistung 99 + Gewerk verwenden 
-- 20241210 alavih: Filialumgliederung

SELECT
    psp.land_id,
    psp.mandant_id,
    COALESCE(w.aktuell_wup_id, psp.wup_id) AS wup_id,
    psp.wup_standort,
    psp.projekt_nr,
    psp.projekt_id,
    psp.rpm_projekt_typ_id,
    psp.rpm_hierarchie_id,
    psp.testmarkt_fg,
    psp.rpm_phase_id,
    psp.rpm_phase_bez,
    psp.wrg_id_rpm,
    psp.ims_projekt_typ_id,
    psp.in_projekt_id_char,
    psp.in_projekt_id,
    psp.psp_id_char,
    psp.psp_id,
    psp.psp_end_nr,
    -- Zur Steuerung, ob das Gewerk neu gemappt wurden ist 
    CASE WHEN bvv.bvv_leist_id IS NOT NULL
        THEN 0 ELSE 1 END AS wg_psp_end_nr,
    fakt.in_lief_id,
    fakt.in_wg_id,
    COALESCE(bvv.bvv_leist_id,('99' ||psp.psp_end_nr)::NUMBER(38,0)) AS bvv_leist_id,
    /*, bvv_leist_bez*/
    fakt.best_beleg_id,
    fakt.best_beleg_pos_id,
    COALESCE(endrech_fg, 0) AS endrech_fg,
    fakt.kontierung_pos_id, -- immer 1 ?!
    fakt.unterposition_typ_id,
    fakt.bestell_text_obligo AS bestell_text,
    fakt.menge_best_bme,
    /* Kurs_1 und Waehrung aus Usereinstellungen*/
    kurs.kurs_1 :: DECIMAL(8, 4) AS kurs_1,
    v99.wrg_id AS wrg_id,
    v99.wrg_typ_id,
    kurs.umrechnungskurs AS FAKTOR,
    /* logik zur Filterung vom bestimmten Betraegen auf PSP-Ebene für BE-User (IME darf alles sehen)*/
    CASE
        WHEN psp.psp_end_nr IN (3, 4, 5, 6, 7) THEN 1
        WHEN psp.psp_end_nr = 2
        OR (
            psp.psp_end_nr = 1
            AND fakt.in_wg_id = '-1'
        ) THEN 0
        ELSE 1
    END AS AUSBLEND, -- Flag für Prognose + IST Kosten
    /* SPEC0033158: löschen von fakt.best_beleg_pos_id und fakt.unterposition_typ_id*/
    /* fakt.best_beleg_pos_id  wieder aufgenommen*/
    RANK() OVER (
        PARTITION BY fakt.mandant_id,
        psp.projekt_id,
        fakt.best_beleg_id,
        fakt.best_beleg_pos_id,
        fakt.psp_id,
        fakt.in_wg_id,
        v99.wrg_typ_id
        ORDER BY
            fakt.mandant_id,
            fakt.best_beleg_id,
            fakt.psp_id,
            fakt.in_wg_id,
            v99.wrg_typ_id,
            fakt.dat_buch,
            fakt.rech_beleg_id
    ) rang,
    /*seperate Rangfolgenordnung für Abschlagszahlungen; dense_rank für fortlaufende Rangbildung*/
    DENSE_RANK() OVER (
        PARTITION BY fakt.mandant_id,
        psp.projekt_id,
        fakt.best_beleg_id,
        fakt.psp_id,
        fakt.in_wg_id,
        v99.wrg_typ_id
        ORDER BY
            fakt.mandant_id,
            fakt.best_beleg_id,
            fakt.psp_id,
            fakt.in_wg_id,
            v99.wrg_typ_id,
            CASE
                WHEN fakt.dat_buch IS NOT NULL THEN fakt.dat_buch
                ELSE CURRENT_DATE
            END,
            fakt.rech_beleg_id
    ) rang2,
    CASE
        WHEN rang = 1 AND pkw.in_wg_id = fakt.in_wg_id THEN pkw.betrag_konditionswert_gebucht * FAKTOR END :: DECIMAL(18, 4) AS psp_betrag_konditionswert_gebucht,
    CASE
        WHEN rang = 1 AND pkw.in_wg_id = fakt.in_wg_id THEN pkw.betrag_konditionswert_ungebucht * FAKTOR END :: DECIMAL(18, 4) AS psp_betrag_konditionswert_ungebucht,
    CASE
        WHEN rang = 1 AND pkw.in_wg_id = fakt.in_wg_id THEN     
        pkw.betrag_konditionswert_gebucht * FAKTOR END :: DECIMAL(18, 4) AS psp_betrag_konditionswert,
    CASE
        WHEN rang = 1 THEN betrag_besch_best * FAKTOR
    END :: DECIMAL(18, 4) AS betrag_besch_best_0,
    CASE
        WHEN rang = 1 THEN betrag_besch_best_NT * FAKTOR
    END :: DECIMAL(18, 4) AS betrag_besch_best_NT_0,
    CASE
        WHEN rang = 1 THEN betrag_obligo * FAKTOR
    END :: DECIMAL(18, 4) AS betrag_obligo_0,
    CASE
        WHEN rang = 1 THEN betrag_obligo_NT * FAKTOR
    END :: DECIMAL(18, 4) AS betrag_obligo_NT_0,
    /* SPEC0033158: löschen von fakt.best_beleg_pos_id und fakt.unterposition_typ_id*/
    /* fakt.best_beleg_pos_id  wieder aufgenommen*/
    CASE
        WHEN rang = 1 THEN SUM(betrag_ist_kosten) OVER (
            PARTITION BY fakt.mandant_id,
            fakt.best_beleg_id,
            fakt.psp_id,
            fakt.in_wg_id,
            v99.wrg_typ_id,
            fakt.best_beleg_pos_id
           /* ORDER BY
                fakt.mandant_id,
                fakt.best_beleg_id,
                fakt.psp_id,
                fakt.in_wg_id,
                v99.wrg_typ_id,
                fakt.dat_buch,
                fakt.rech_beleg_id*/
        )
    END * FAKTOR :: DECIMAL(18, 4) AS betrag_ist_kosten_0,
    /*-Abschlag auf rang 2!*/
    /*20170502: neue Metriken - SPEC0011308*/
    CASE
        WHEN rang = 1 THEN fakt.einbehalt_Abnahme * FAKTOR
    END :: DECIMAL(18, 4) AS einbehalt_Abnahme,
    CASE
        WHEN rang = 1 THEN fakt.einbehalt_Sicherheit * FAKTOR
    END :: DECIMAL(18, 4) AS einbehalt_Sicherheit,
    CASE
        WHEN rang = 1 THEN fakt.einbehalt_Gewaehrleistung * FAKTOR
    END :: DECIMAL(18, 4) AS einbehalt_Gewaehrleistung,
    CASE
        WHEN rang = 1 THEN fakt.einbehalt_Vertragsstrafe * FAKTOR
    END :: DECIMAL(18, 4) AS einbehalt_Vertragsstrafe,
    CASE
        WHEN rang = 1 THEN fakt.einbehalt_Rechnungen * FAKTOR
    END :: DECIMAL(18, 4) AS einbehalt_Rechnungen,
    CASE
        WHEN rang = 1 THEN fakt.einbehalt_Subunternehmer * FAKTOR
    END :: DECIMAL(18, 4) AS einbehalt_Subunternehmer,
    CASE
        WHEN rang2 = 1 THEN betrag_ist_kosten * FAKTOR
    END :: DECIMAL(18, 4) AS betrag_abschlag_01,
    CASE
        WHEN rang2 = 2 THEN betrag_ist_kosten * FAKTOR
    END :: DECIMAL(18, 4) AS betrag_abschlag_02,
    CASE
        WHEN rang2 = 3 THEN betrag_ist_kosten * FAKTOR
    END :: DECIMAL(18, 4) AS betrag_abschlag_03,
    CASE
        WHEN rang2 = 4 THEN betrag_ist_kosten * FAKTOR
    END :: DECIMAL(18, 4) AS betrag_abschlag_04,
    CASE
        WHEN rang2 = 5 THEN betrag_ist_kosten * FAKTOR
    END :: DECIMAL(18, 4) AS betrag_abschlag_05,
    CASE
        WHEN rang2 = 6 THEN betrag_ist_kosten * FAKTOR
    END :: DECIMAL(18, 4) AS betrag_abschlag_06,
    CASE
        WHEN rang2 = 7 THEN betrag_ist_kosten * FAKTOR
    END :: DECIMAL(18, 4) AS betrag_abschlag_07,
    CASE
        WHEN rang2 = 8 THEN betrag_ist_kosten * FAKTOR
    END :: DECIMAL(18, 4) AS betrag_abschlag_08,
    CASE
        WHEN rang2 = 9 THEN betrag_ist_kosten * FAKTOR
    END :: DECIMAL(18, 4) AS betrag_abschlag_09,
    CASE
        WHEN rang2 = 10 THEN betrag_ist_kosten * FAKTOR
    END :: DECIMAL(18, 4) AS betrag_abschlag_10,
    CASE
        WHEN rang2 > 10 THEN betrag_ist_kosten * FAKTOR
    END :: DECIMAL(18, 4) AS betrag_abschlag_1x,
    /* IVS Akte/Vertrag*/
    ibba.bvv_akte_id,
    ibasz.bvv_akte_bez,
    ilba.bvv_vertrag_nr,
    ilba.dat_vertrag_beginn,
    v01.einkaeufer_grp_id
FROM
    (
        -- PART I.0 - Stammdaten G und E Projekte (OHNE B)
        SELECT
            cpro.land_id,
            ipsp.mandant_id,
            rpm.wup_id,
            rpm.wup_standort,
            cpro.cpr_ext_id AS projekt_nr,
            cpro.projekt_id,
            rpm.rpm_projekt_typ_id,
            rpm.rpm_hierarchie_id,
            rpm.testmarkt_fg,
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
            dbp_view.v_in_psp_element_1 ipsp
            JOIN dbp_view.v_in_projekt_1 ipro ON ipro.mandant_id = ipsp.mandant_id
            AND ipro.in_projekt_id = ipsp.in_projekt_id
            AND ipro.ims_projekt_typ_id IN ('E', 'G','B') -- nur definierte Projekte
            JOIN dbp_view.v_cpr_projekt_per_1 cpro ON cpro.cpr_ext_id = ipro.projekt_ext_id
            AND cpro.dat_bis = TO_DATE('9999-12-31', 'YYYY-MM_1-DD')
            JOIN dbp_view.v_rpm_element_per_1 rpm ON rpm.projekt_id = cpro.cpr_ext_id
            AND rpm.dat_bis = TO_DATE('9999-12-31', 'YYYY-MM_1-DD')
            JOIN dbp_view.v_rpm_phase_spr_zu_1 rpsz ON rpsz.rpm_phase_id = rpm.rpm_phase_id
            AND rpsz.rpm_projekt_typ_id = rpm.rpm_projekt_typ_id
            AND rpsz.spr_id = 22
    ) psp
    LEFT JOIN (
        -- PART I.1 - Kosten + Bestellungen pro PSP / WG
        SELECT
            ibbk.psp_id,
            ibbk.mandant_id,
            COALESCE(in_wg_id, '-1') AS in_wg_id,
            ibb.in_lief_id,
            ibbk.best_beleg_id,
            ibbk.best_beleg_pos_id,
            ibbk.kontierung_pos_id, -- immer 1 ?!
            ibbd.menge_best_bme,
            ibbd.betrag_pos_netto_best_wrg * (
                CASE
                    WHEN ibbd.retourenpos_fg = 1 THEN -1
                    ELSE 1
                END
            ) AS betrag_besch_best,
            CASE
                WHEN unterposition_typ_id = 'N' THEN betrag_besch_best
                ELSE (betrag_besch_best * 0)
            END AS betrag_besch_best_NT,
            COALESCE(ibbd.unterposition_typ_id, ' ') AS unterposition_typ_id,
            ikd.betrag AS betrag_ist_kosten,
            ikd.bestell_text AS bestell_text_kosten,
            op.betrag AS betrag_obligo,
            CASE
                WHEN unterposition_typ_id = 'N' THEN op.betrag
                ELSE (op.betrag * 0)
            END AS betrag_obligo_NT,
            op.betrag_plan AS betrag_obligo_plan,
            op.bestell_text AS bestell_text_obligo,
            ikd.dat_buch,
            ikd.rech_beleg_id,
            ibbd.endrech_fg,
            /*20170823 hmue2308*/
            SUM(
                CASE
                    WHEN best.sonder_hauptbuch_kz = 1 THEN best.betrag_einbehalt
                END
            ) AS einbehalt_Abnahme,
            SUM(
                CASE
                    WHEN best.sonder_hauptbuch_kz = 2 THEN best.betrag_einbehalt
                END
            ) AS einbehalt_Sicherheit,
            SUM(
                CASE
                    WHEN best.sonder_hauptbuch_kz = 3 THEN best.betrag_einbehalt
                END
            ) AS einbehalt_Gewaehrleistung,
            SUM(
                CASE
                    WHEN best.sonder_hauptbuch_kz = 4 THEN best.betrag_einbehalt
                END
            ) AS einbehalt_Vertragsstrafe,
            SUM(
                CASE
                    WHEN best.sonder_hauptbuch_kz = 5 THEN best.betrag_einbehalt
                END
            ) AS einbehalt_Rechnungen,
            SUM(
                CASE
                    WHEN best.sonder_hauptbuch_kz = 7 THEN best.betrag_einbehalt
                END
            ) AS einbehalt_Subunternehmer
        FROM
            dbp_view.v_IN_besch_best_kontierung_1 ibbk --20170823 hmue2308
            LEFT JOIN (
                SELECT
                    ein.mandant_id,
                    ein.buchungskreis_id,
                    ein.in_fi_beleg_id,
                    ein.in_fi_beleg_pos_id,
                    ein.gj,
                    ein.referenzschluessel_id_,
                    ein.sonder_hauptbuch_kz,
                    ein.best_beleg_id,
                    ein.best_beleg_pos_id,
                    (
                        MAX(ein.betrag_fi_beleg) OVER (
                            PARTITION BY ein.mandant_id,
                            ein.buchungskreis_id,
                            ein.in_fi_beleg_id,
                            ein.in_fi_beleg_pos_id,
                            ein.gj,
                            ein.referenzschluessel_id_,
                            ein.sonder_hauptbuch_kz,
                            ein.best_beleg_id,
                            ein.best_beleg_pos_id
                        )
                    ) AS betrag_fi,
                    (
                        SUM(ein.betrag_wrbtr) OVER (
                            PARTITION BY ein.mandant_id,
                            ein.buchungskreis_id,
                            ein.in_fi_beleg_id,
                            ein.in_fi_beleg_pos_id,
                            ein.gj,
                            ein.referenzschluessel_id_,
                            ein.sonder_hauptbuch_kz,
                            ein.best_beleg_id
                        )
                    ) AS betrag_best,
                    (
                        SUM(ein.betrag_wrbtr) OVER (
                            PARTITION BY ein.mandant_id,
                            ein.buchungskreis_id,
                            ein.in_fi_beleg_id,
                            ein.in_fi_beleg_pos_id,
                            ein.gj,
                            ein.referenzschluessel_id_,
                            ein.sonder_hauptbuch_kz,
                            ein.best_beleg_id,
                            ein.best_beleg_pos_id
                        )
                    ) AS betrag_pos,
                    betrag_fi * betrag_pos / betrag_best AS betrag_einbehalt
                FROM
                    (
                        SELECT
                            fi.mandant_id,
                            fi.buchungskreis_id,
                            fi.in_fi_beleg_id,
                            fi.in_fi_beleg_pos_id,
                            fi.gj,
                            fi.referenzschluessel_id / 10000 AS referenzschluessel_id_, --muss aus BKPF.AWKEY kommen, speichern in in_fi_beleg_det_1
                            fi.betrag_fi_beleg,
                            fi.sonder_hauptbuch_kz,
                            bf.best_beleg_id,
                            bf.best_beleg_pos_id,
                            bf.betrag_wrbtr
                        FROM
                            dbp_view.v_in_fi_beleg_det_1 fi
                            JOIN dbp_view.v_in_best_belegfluss_1 bf ON fi.mandant_id = bf.mandant_id
                            AND fi.gj = bf.kj
                            AND fi.referenzschluessel_id / 10000 = bf.folge_beleg_id
                        WHERE
                            fi.sonder_hauptbuch_kz IN ('1', '2', '3', '4', '5', '7')
                    ) ein
            ) best ON ibbk.mandant_id = best.mandant_id
            AND ibbk.best_beleg_id = best.best_beleg_id
            AND ibbk.best_beleg_pos_id = best.best_beleg_pos_id -- Kosten mit Bestellung (Belegfluss)
            -- Einfügen rech_beleg_id SPEC0033158
            LEFT JOIN (
                -- Kosten mit Bestellung
                SELECT
                    ikd.mandant_id,
                    CASE
                        WHEN ikd.best_beleg_id = -1
                        OR ikd.best_beleg_id IS NULL THEN ibb.best_beleg_id
                        ELSE ikd.best_beleg_id
                    END best_beleg_id,
                    CASE
                        WHEN ikd.best_beleg_pos_id = 0 THEN ibb.best_beleg_pos_id
                        ELSE ikd.best_beleg_pos_id
                    END best_beleg_pos_id,
                    ikd.psp_id,
                    ikd.dat_buch,
                    ikd.beleg_id rech_beleg_id,
                    MAX(ikd.bestell_text) bestell_text,
                    SUM(ikd.betrag) betrag
                FROM
                    dbp_view.v_ist_kosten_det_1 ikd
                    LEFT JOIN (
                        SELECT
                            mandant_id,
                            folge_beleg_id,
                            dat_buch,
                            MAX(best_beleg_id) best_beleg_id,
                            MAX(best_beleg_pos_id) best_beleg_pos_id
                        FROM
                            dbp_view.v_in_best_belegfluss_1
                        GROUP BY
                            1,
                            2,
                            3
                    ) ibb ON ikd.ref_beleg_id = ibb.folge_beleg_id
                    AND ikd.dat_buch = ibb.dat_buch
                    AND ikd.mandant_id = ibb.mandant_id --WHERE LTRIM( Trim(Both From ikd.kostenart_id), '0')  NOT IN  ('912000', '979002', 'H912000', 'H979002', '880100', '940003')
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
                            WHEN ikd.best_beleg_id = -1
                            OR ikd.best_beleg_id IS NULL THEN ibb.best_beleg_id
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
                            dbp_view.v_in_besch_best_kontierung_1
                    )
                GROUP BY
                    1,
                    2,
                    3,
                    4,
                    5,
                    6
            ) ikd ON ikd.mandant_id = ibbk.mandant_id
            AND ikd.best_beleg_id = ibbk.best_beleg_id
            AND ikd.best_beleg_pos_id = ibbk.best_beleg_pos_id
            AND ikd.psp_id = ibbk.psp_id -- Alle Bestellungen (Kontierung)
            LEFT JOIN dbp_view.v_in_besch_best_det_1 ibbd ON ibbd.mandant_id = ibbk.mandant_id
            AND ibbd.best_beleg_id = ibbk.best_beleg_id
            AND ibbd.best_beleg_pos_id = ibbk.best_beleg_pos_id
            AND ibbd.loesch_id = '' -- ohne Loeschungen -- ISAG: Leerzeichen im Leerstring entfernt, weil in SNowflake zu Beginn getrimmed wird.
            -- Alle Obligo (Kontierung)
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
                    bedarf_nr,
                    SUM(betrag) betrag,
                    SUM(menge) menge,
                    SUM(betrag_plan) betrag_plan
                FROM
                    dbp_view.v_obligo_per_1
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
            ) op ON op.mandant_id = ibbk.mandant_id
            AND op.ref_beleg_id = ibbk.best_beleg_id
            AND op.ref_beleg_pos_id = ibbk.best_beleg_pos_id
            AND op.dat_bis = TO_DATE('9999-12-31', 'YYYY-MM_1-DD') -- letzter Stand
            AND CASE
                WHEN op.loesch_id = '' THEN 0
                ELSE op.loesch_id
            END = 0 -- ohne Loeschungen
            -- Lieferantennummer ermitteln
            LEFT JOIN dbp_view.v_in_besch_best_1 ibb ON ibb.mandant_id = ibbd.mandant_id
            AND ibb.best_beleg_id = ibbd.best_beleg_id
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
            20
        UNION
        ALL
        SELECT
            ipsp.psp_id,
            ipsp.mandant_id,
            '-1' AS in_wg_id,
            -1 AS in_lief_id,
            0 best_beleg_id,
            0 best_beleg_pos_id,
            0 kontierung_pos_id,
            NULL AS menge_best_bme,
            0 AS betrag_besch_best,
            0 AS betrag_besch_best_NT,
            ' ' AS unterposition_typ_id,
            ikd.betrag AS betrag_ist_kosten,
            ikd.bestell_text AS bestell_text_kosten,
            0 AS betrag_obligo,
            0 AS betrag_obligo_NT,
            0 AS betrag_obligo_plan,
            COALESCE(ikd.bestell_text, ' ') AS bestell_text_obligo,
            ikd.dat_buch,
            ikd.rech_beleg_id,
            0 AS endrech_fg,
            NULL AS einbehalt_Abnahme,
            NULL AS einbehalt_Sicherheit,
            NULL AS einbehalt_Gewaehrleistung,
            NULL AS einbehalt_Vertragsstrafe,
            NULL AS einbehalt_Rechnungen,
            NULL AS einbehalt_Subunternehmer
        FROM
            (
                SELECT
                    DISTINCT psp_id,
                    mandant_id
                FROM
                    dbp_view.v_in_psp_element_1
            ) ipsp
            LEFT JOIN (
                -- Kosten ohne Bestellung
                SELECT
                    DISTINCT psp_id,
                    mandant_id,
                    dat_buch,
                    beleg_id rech_beleg_id,
                    MAX(bestell_text) bestell_text,
                    SUM(betrag) betrag
                FROM
                    dbp_view.v_ist_kosten_det_1
                WHERE
                    (mandant_id, beleg_id, beleg_pos_id) NOT IN (
                        SELECT
                            ikd.mandant_id,
                            beleg_id,
                            beleg_pos_id
                        FROM
                            dbp_view.v_ist_kosten_det_1 ikd
                            LEFT JOIN (
                                SELECT
                                    mandant_id,
                                    folge_beleg_id,
                                    dat_buch,
                                    MAX(best_beleg_id) best_beleg_id,
                                    MAX(best_beleg_pos_id) best_beleg_pos_id
                                FROM
                                    dbp_view.v_in_best_belegfluss_1
                                GROUP BY
                                    1,
                                    2,
                                    3
                            ) ibb ON ikd.ref_beleg_id = ibb.folge_beleg_id
                            AND ikd.dat_buch = ibb.dat_buch
                            AND ikd.mandant_id = ibb.mandant_id --WHERE LTRIM( Trim(Both From ikd.kostenart_id), '0')  NOT IN  ('912000', '979002', 'H912000', 'H979002', '880100', '940003')
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
                                    WHEN ikd.best_beleg_id = -1
                                    OR ikd.best_beleg_id IS NULL THEN ibb.best_beleg_id
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
                                    dbp_view.v_in_besch_best_kontierung_1
                            )
                    ) --AND LTRIM( Trim(Both From kostenart_id), '0')  NOT IN  ('912000', '979002', 'H912000', 'H979002', '880100', '940003')
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
                    2,
                    3,
                    4
            ) ikd ON ikd.psp_id = ipsp.psp_id
            AND ikd.mandant_id = ipsp.mandant_id
    ) fakt ON psp.psp_id = fakt.psp_id
    AND psp.mandant_id = fakt.mandant_id
    LEFT JOIN (
        -- Anreicherung Leistung
        SELECT
            lpwz.mandant_id,
            lbl.psp_end_nr,
            lpwz.in_wg_id,
            lpwz.bvv_leist_id
            /*, lbl.bvv_leist_bez*/
        FROM
            dbp_view.v_leistung_psp_wg_zu_1 lpwz
            JOIN dbp_view.v_l_bvv_leistung_1 lbl ON lbl.bvv_leist_id = lpwz.bvv_leist_id
    ) bvv ON bvv.mandant_id = psp.mandant_id
    AND bvv.psp_end_nr = psp.psp_end_nr
    AND bvv.in_wg_id = fakt.in_wg_id 
    -- Akte  /  Keine Daten (2015-11-26)
    LEFT JOIN dbp_view.v_in_besch_best_akte_zu_1 ibba ON ibba.best_beleg_id = fakt.best_beleg_id
    AND ibba.mandant_id = fakt.mandant_id
    LEFT JOIN dbp_view.v_ivs_l_bvv_akte_1 ilba ON ilba.bvv_akte_id = ibba.bvv_akte_id
    AND ilba.mandant_id = ibba.mandant_id
    LEFT JOIN dbp_view.v_ivs_bvv_akte_spr_zu_1 ibasz ON ibasz.bvv_akte_id = ibba.bvv_akte_id
    AND ibasz.mandant_id = ibba.mandant_id
    AND ibasz.spr_id = 22
    LEFT JOIN dbp_view.v_in_besch_best_1 v01 ON v01.mandant_id = fakt.mandant_id
    AND v01.best_beleg_id = fakt.best_beleg_id
    JOIN dbp_view.v_mandant_wrg_typ_zu_1 v99 ON v99.mandant_id = psp.mandant_id
    LEFT JOIN (
        --Anpassung Konditionswert AP0015930
        /* Alte Version - Neue Version von IKS kopiert damit die Werte uebereinstimmen
        SELECT
            mandant_id,
            psp_id,
            wrg_id,
            SUM(betrag_konditionswert_gebucht) betrag_konditionswert_gebucht,
            SUM(betrag_konditionswert_ungebucht) betrag_konditionswert_ungebucht
        FROM
            dbp_view.v_psp_konditionswert_1
        WHERE
            mandant_id = 1 --Filterung auf DE da KMO Daten inkorrekt (NSR1266666)
        GROUP BY
            1,
            2,
            3*/
        SELECT
            pkw2.mandant_id mandant_id,
            pkw2.psp_id psp_id,
            pkw2.wrg_id wrg_id,
            --pkw2.konditionsart_id konditionsart_id,
            pkw2.wrg_typ_id,
            '-1' AS in_wg_id, --Um die kontionswerte richtig hinzuzufuegen 
            --msar2108 181205: Umrechnung für EUR in EUR
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
                    --msar2108 181205: Umrechnung für EUR in EUR
                    CASE
                        WHEN pkw.wrg_id = kurs.wrg_id THEN betrag_konditionswert_gebucht
                        ELSE betrag_konditionswert_gebucht * FAKTOR
                    END AS betrag_konditionswert_gebucht,
                    CASE
                        WHEN pkw.wrg_id = kurs.wrg_id THEN betrag_konditionswert_ungebucht
                        ELSE betrag_konditionswert_ungebucht * FAKTOR
                    END AS betrag_konditionswert_ungebucht
                FROM
                    dbp_view.v_psp_konditionswert_1 pkw
                    LEFT JOIN dbp_view.v_mandant_wrg_typ_zu_1 v99 ON v99.mandant_id = pkw.mandant_id 
                    AND v99.wrg_id = pkw.wrg_id
                    JOIN dbp_msi_view_ios.mv_user_kurs_konditionswert_1 kurs_1 ON kurs.mandant_id = pkw.mandant_id
                    AND kurs.von_wrg_id = pkw.wrg_id
                /*WHERE
                    pkw.mandant_Id = 1*/
            ) pkw2 --Filterung auf DE da KMO Daten inkorrekt (NSR1266666)
        GROUP BY
            1,
            2,
            3,
            4
    ) pkw --msar2108 190121: zusätzlicher Subselect damit Land_1 mit EUR = Landeswährung keine Daten verdoppelt werden.
    ON pkw.mandant_id = psp.mandant_id
        AND pkw.psp_id = psp.psp_id
        AND v99.wrg_id = pkw.wrg_id
        AND v99.wrg_typ_id = pkw.wrg_typ_id --msar2108 181205: Umrechnung für EUR in EUR
    JOIN dbp_msi_view_ios.mv_user_kurs_1 kurs_1 ON kurs.mandant_id = v99.mandant_id --AND kurs.von_wrg
    AND kurs.wrg_typ_id = v99.wrg_typ_id
    AND kurs.wrg_id = v99.wrg_id

    LEFT JOIN
    dbp_view.v_wup_1 w
    ON psp.wup_id = w.wup_id
    AND psp.mandant_Id = w.mandant_Id -- Um aktuell gültige wup_1 zu erhalten

WHERE
    (
        fakt.betrag_ist_kosten <> 0
        OR fakt.betrag_obligo <> 0
        OR betrag_besch_best <> 0
    );