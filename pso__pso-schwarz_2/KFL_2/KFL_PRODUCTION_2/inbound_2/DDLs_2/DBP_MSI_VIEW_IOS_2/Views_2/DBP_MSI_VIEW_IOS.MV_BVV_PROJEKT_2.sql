CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_BVV_PROJEKT_2 AS -- LOOKUP/FILTER : Alle gueltigen 'E', 'G', 'B' Projekte (IN/RPM/cPRO)
-- Basis fuer Berichtsfilter inkl. benoetigten Terminen und
-- 20160314 ssch0611: initial
-- 20160414 ssch0611: Review Projekt-Filter, Systemstatus aus PSP, Anpassung Tage/Fertigstellung
-- 20160616 kkai0912: Änderung der Suchfelder, Abhängig vom Projekt-Typ, Anfo Frau Chemnitz
-- 20160712 kkai0912: Erweiterung um 2 Suchfelder: CPR_P_VORABSTIMMUNG_PRODUKT_FREIGEGEBEN, CPR_BAUGENEHMIGUNGEN_GEPRUEFT_VOLLZIEHB
-- 20160905 kkai0912: "Baubeginn Einrichtung"(BEGINN_EINRICHTUNG) und "Beginn Kälte" (CPR_BAUBEG_KAELTE) statt MAX auf MIN-Datum umstellen
-- 20160914 tuts1605: (TU) "Änderung 2 Suchfelder: CPR_P_VORABSTIMMUNG_PRODUKT_FREIGEGEBEN, CPR_BAUGENEHMIGUNGEN_GEPRUEFT_VOLLZIEHB erweitert um Abfrage typ -NB_2,-MM_2 ... etc.
-- 20161005 kkai0912: zusätzlicher Filter. Wenn Stille Eröffnung NUR in aktuellen GJ und aktuell
-- 20170818 msar2108: Anpassung Filter/Case CPR_BAUABNAHME
-- 20171113 hmue2308: Suchfelder ergänzt
-- 20180810 nfis0811 - SPEC0039196: Änderung Logik Terminbestimmung
-- 2020020 richternic SPEC0101029: Felder für Zeitpunkt Objektidee Definiert  & Objekt bestaetigt 
SELECT
    cpro.mandant_id,
    cpro.projekt_id,
    rpm_hierarchie_id,
    cpro.land_id,
   COALESCE(wup.aktuell_wup_id, rpm.wup_id) AS wup_id,
    rpm.wup_standort,
    cpro.cpr_ext_id AS projekt_nr,
    rpm.rpm_projekt_typ_id,
    CASE
        WHEN SUBSTR(rpm.rpm_projekt_typ_id, 1, 5) = 'ZPPM_' THEN (SUBSTRING(rpm.rpm_projekt_typ_id, 6, 2))
        ELSE rpm.rpm_projekt_typ_id
    END AS massnahme_id,
    SUBSTRING(sub01.cpr_ext_id, 14, 2) AS projekt_nr_endung,
    rpm.rpm_status_id,
    rssz.rpm_status_bez,
    rpm.rpm_phase_id,
    rpsz.rpm_phase_bez,
    ims_projekt_typ_id,
    in_projekt_id_char,
    sub02.in_systemstatus_min AS in_systemstatus_id,
    issz.systemstatus_bez AS in_systemstatus_bez,
    CASE
        rssz.rpm_status_bez
        WHEN 'Abgebrochen' THEN 2 -- abgebrochen
        ELSE CASE
            in_systemstatus_id
            WHEN 'I0002' THEN 0 -- freigegeben = aktuell
            WHEN 'I0045' THEN CASE
                WHEN CURRENT_DATE - 1 BETWEEN (
                    EXTRACT(
                        YEAR
                        FROM
                            ADD_MONTHS(STILLE_EROEFFNUNG, - 2)
                    ) || '-03-01'
                )::DATE
                AND DATEADD(
                    DAY,
                    -1,
                    ADD_MONTHS(
                        (
                            EXTRACT(
                                YEAR
                                FROM
                                    ADD_MONTHS(STILLE_EROEFFNUNG, - 2)
                            ) || '-03-01'
                        )::DATE,
                        12
                    )
                ) THEN 0
                ELSE 1
            END -- techn. abgeschlossen in akt. GJ = aktuell, sonst abgeschlossen
            WHEN 'I0046' THEN CASE
                WHEN CURRENT_DATE - 1 BETWEEN (
                    EXTRACT(
                        YEAR
                        FROM
                            ADD_MONTHS(STILLE_EROEFFNUNG, - 2)
                    ) || '-03-01'
                )::DATE
                AND DATEADD(
                    DAY,
                    -1,
                    ADD_MONTHS(
                        (
                            EXTRACT(
                                YEAR
                                FROM
                                    ADD_MONTHS(STILLE_EROEFFNUNG, - 2)
                            ) || '-03-01'
                        )::DATE,
                        12
                    )
                ) THEN 0
                ELSE 1
            END -- abgeschlossen in akt. GJ = aktuell, sonst abgeschlossen
            ELSE 3 -- unvollstaendig
        END
    END::BYTEINT AS projekt_filter_id,
    CASE
        projekt_filter_id
        WHEN 0 THEN 'Aktuell'
        WHEN 1 THEN 'Abgeschlossen'
        WHEN 2 THEN 'Abgebrochen'
        WHEN 3 THEN 'Unvollstaendig' -- WHEN  4 THEN 'Zukuenftig'
    END::VARCHAR(40) AS projekt_filter_bez,
    STILLE_EROEFFNUNG,
    CPR_BAUABNAHME,
    CPR_BAUBEG_KAELTE,
    BEGINN_EINRICHTUNG,
    BAUBEGINN,
    VERGABE_BAU,
    CPR_TECHN_BIETERGESPRAECH,
    CPR_SUBMISSION,
    CPR_LV_VERSENDEN,
    KBE_FS_VP_VERABSCHIEDET,
    -- Helper / VARIABLEN
    CASE
        WHEN CPR_BAUABNAHME > STILLE_EROEFFNUNG THEN STILLE_EROEFFNUNG - CPR_BAUABNAHME -- Abnahme nach Eroeffnung
        WHEN STILLE_EROEFFNUNG > CPR_BAUABNAHME THEN STILLE_EROEFFNUNG - CPR_BAUABNAHME -- Abnahme vor Eroeffnung
        ELSE 0
    END AS eroeffnung_abnahme,
    sub02.in_systemstatus_max, -- Helper
    CURRENT_DATE - 1 AS HEUTE, -- Default 1 Tag_2 Offset!
    (
        EXTRACT(
            YEAR
            FROM
                ADD_MONTHS(HEUTE, - 2)
        ) || '-03-01'
    )::DATE AS GJ_BEGINN,
    DATEADD(DAY, -1, ADD_MONTHS(GJ_BEGINN, 12)) AS GJ_ENDE,
    (
        EXTRACT(
            YEAR
            FROM
                ADD_MONTHS(STILLE_EROEFFNUNG, - 2)
        ) || '-03-01'
    )::DATE AS EROEFFNUNG_GJ_BEGINN,
    DATEADD(DAY, -1, ADD_MONTHS(EROEFFNUNG_GJ_BEGINN, 12)) AS EROEFFNUNG_GJ_ENDE,
    COALESCE (v01.gj, 9999)::INTEGER AS EROEFFNUNG_GJ,
    -- Ermittlung der Tage + Fertigstellung bis HEUTE bzw. GJ_ENDE
    -- FS_VP bis Baubeginn
    BAUBEGINN - KBE_FS_VP_VERABSCHIEDET AS fsvp_dauer,
    CASE
        WHEN HEUTE BETWEEN KBE_FS_VP_VERABSCHIEDET
        AND BAUBEGINN THEN HEUTE - KBE_FS_VP_VERABSCHIEDET
        WHEN HEUTE > BAUBEGINN THEN fsvp_dauer
        ELSE 0
    END AS fsvp_seit,
    fsvp_dauer - fsvp_seit AS fsvp_bis,
    ROUND(
        (1.000 * fsvp_seit) / CASE
            WHEN fsvp_dauer = 0 THEN NULL
            ELSE fsvp_dauer
        END,
        3
    ) AS fsvp_fertig,
    CASE
        WHEN GJ_ENDE BETWEEN KBE_FS_VP_VERABSCHIEDET
        AND BAUBEGINN THEN DATEDIFF(DAY, KBE_FS_VP_VERABSCHIEDET, GJ_ENDE) --GJ_ENDE - KBE_FS_VP_VERABSCHIEDET
        WHEN GJ_ENDE > BAUBEGINN THEN fsvp_dauer
        ELSE 0
    END AS fsvp_gj,
    ROUND(
        (1.000 * fsvp_gj) / CASE
            WHEN fsvp_dauer = 0 THEN NULL
            ELSE fsvp_dauer
        END,
        3
    ) AS fsvp_gj_fertig,
    -- Baubeginn bis Abnahme
    CPR_BAUABNAHME - BAUBEGINN AS bau_dauer,
    CASE
        WHEN HEUTE BETWEEN BAUBEGINN
        AND CPR_BAUABNAHME THEN HEUTE - BAUBEGINN
        WHEN HEUTE > CPR_BAUABNAHME THEN bau_dauer
        ELSE 0
    END AS bau_seit,
    bau_dauer - bau_seit AS bau_bis,
    ROUND(
        (1.000 * bau_seit) / CASE
            WHEN bau_dauer = 0 THEN NULL
            ELSE bau_dauer
        END,
        3
    ) AS bau_fertig,
    CASE
        WHEN GJ_ENDE BETWEEN BAUBEGINN
        AND CPR_BAUABNAHME THEN DATEDIFF(DAY, BAUBEGINN, GJ_ENDE) --GJ_ENDE - BAUBEGINN
        WHEN GJ_ENDE > CPR_BAUABNAHME THEN bau_dauer
        ELSE 0
    END AS bau_gj,
    ROUND(
        (1.000 * bau_gj) / CASE
            WHEN bau_dauer = 0 THEN NULL
            ELSE bau_dauer
        END,
        3
    ) AS bau_gj_fertig,
    -- TEST_2 : Baubeginn bis Eroeffnung
    STILLE_EROEFFNUNG - BAUBEGINN AS bau2_dauer,
    CASE
        WHEN HEUTE BETWEEN BAUBEGINN
        AND STILLE_EROEFFNUNG THEN HEUTE - BAUBEGINN
        WHEN HEUTE > STILLE_EROEFFNUNG THEN bau2_dauer
        ELSE 0
    END AS bau2_seit,
    bau2_dauer - bau2_seit AS bau2_bis,
    ROUND(
        (1.000 * bau2_seit) / CASE
            WHEN bau2_dauer = 0 THEN NULL
            ELSE bau2_dauer
        END,
        3
    ) AS bau2_fertig,
    CASE
        WHEN GJ_ENDE BETWEEN BAUBEGINN
        AND STILLE_EROEFFNUNG THEN DATEDIFF(DAY, BAUBEGINN, GJ_ENDE) --GJ_ENDE - BAUBEGINN
        WHEN GJ_ENDE > STILLE_EROEFFNUNG THEN bau2_dauer
        ELSE 0
    END AS bau2_gj,
    ROUND(
        (1.000 * bau2_gj) / CASE
            WHEN bau2_dauer = 0 THEN NULL
            ELSE bau2_dauer
        END,
        2
    ) AS bau2_gj_fertig,
    -- Einrichtung bis Eroeffnung
    STILLE_EROEFFNUNG - BEGINN_EINRICHTUNG AS einricht_dauer,
    CASE
        WHEN HEUTE BETWEEN BEGINN_EINRICHTUNG
        AND STILLE_EROEFFNUNG THEN HEUTE - BEGINN_EINRICHTUNG
        WHEN HEUTE > STILLE_EROEFFNUNG THEN einricht_dauer
        ELSE 0
    END AS einricht_seit,
    einricht_dauer - einricht_seit AS einricht_bis,
    ROUND(
        (1.000 * einricht_seit) / CASE
            WHEN einricht_dauer = 0 THEN NULL
            ELSE einricht_dauer
        END,
        2
    ) AS einricht_fertig,
    CASE
        WHEN GJ_ENDE BETWEEN BEGINN_EINRICHTUNG
        AND STILLE_EROEFFNUNG THEN DATEDIFF(DAY, BEGINN_EINRICHTUNG, GJ_ENDE) --GJ_ENDE - BEGINN_EINRICHTUNG
        WHEN GJ_ENDE > STILLE_EROEFFNUNG THEN einricht_dauer
        ELSE 0
    END AS einricht_gj,
    ROUND(
        (1.000 * einricht_gj) / CASE
            WHEN einricht_dauer = 0 THEN NULL
            ELSE einricht_dauer
        END,
        2
    ) AS einricht_gj_fertig,
    -- Kaelte bis Eroeffnung
    STILLE_EROEFFNUNG - CPR_BAUBEG_KAELTE AS kaelte_dauer,
    CASE
        WHEN HEUTE BETWEEN CPR_BAUBEG_KAELTE
        AND STILLE_EROEFFNUNG THEN DATEDIFF(DAY, CPR_BAUBEG_KAELTE, GJ_ENDE) --GJ_ENDE - CPR_BAUBEG_KAELTE
        WHEN HEUTE > STILLE_EROEFFNUNG THEN kaelte_dauer
        ELSE 0
    END AS kaelte_seit,
    kaelte_dauer - kaelte_seit AS kaelte_bis,
    ROUND(
        (1.000 * kaelte_seit) / CASE
            WHEN kaelte_dauer = 0 THEN NULL
            ELSE kaelte_dauer
        END,
        3
    ) AS kaelte_fertig,
    CASE
        WHEN GJ_ENDE BETWEEN CPR_BAUBEG_KAELTE
        AND STILLE_EROEFFNUNG THEN DATEDIFF(DAY, CPR_BAUBEG_KAELTE, GJ_ENDE) --GJ_ENDE - CPR_BAUBEG_KAELTE
        WHEN GJ_ENDE > STILLE_EROEFFNUNG THEN kaelte_dauer
        ELSE 0
    END AS kaelte_gj,
    ROUND(
        (1.000 * kaelte_gj) / CASE
            WHEN kaelte_dauer = 0 THEN NULL
            ELSE kaelte_dauer
        END,
        3
    ) AS kaelte_gj_fertig,
    -- uebrig
    CASE
        WHEN HEUTE < KBE_FS_VP_VERABSCHIEDET THEN KBE_FS_VP_VERABSCHIEDET - HEUTE
    END AS fsvp_bis_beginn,
    CASE
        WHEN HEUTE > BAUBEGINN THEN HEUTE - BAUBEGINN
    END AS fsvp_seit_ende,
    CASE
        WHEN HEUTE < BAUBEGINN THEN BAUBEGINN - HEUTE
    END AS bau_bis_beginn,
    CASE
        WHEN HEUTE > CPR_BAUABNAHME THEN HEUTE - CPR_BAUABNAHME
    END AS bau_seit_ende,
    CASE
        WHEN HEUTE < BEGINN_EINRICHTUNG THEN BEGINN_EINRICHTUNG - HEUTE
    END AS einricht_bis_beginn,
    CASE
        WHEN HEUTE > STILLE_EROEFFNUNG THEN HEUTE - STILLE_EROEFFNUNG
    END AS einricht_seit_ende,
    CASE
        WHEN HEUTE < CPR_BAUBEG_KAELTE THEN CPR_BAUBEG_KAELTE - HEUTE
    END AS kaelte_bis_beginn,
    CASE
        WHEN HEUTE > STILLE_EROEFFNUNG THEN HEUTE - STILLE_EROEFFNUNG
    END AS kaelte_seit_ende,
    CPR_P_VORABSTIMMUNG_PRODUKT_FREIGEGEBEN,
    CPR_BAUGENEHMIGUNGEN_GEPRUEFT_VOLLZIEHB,
    -- Neue Felder Objektidee definiert und Objekt bestaetigt
    CPR_PRODUKTIDEE_DEFINIERT,
    CPR_PRODUKT_BESTAETIGT,
    CPR_STANDORTSICHERUNG_DURCHFUEHREN,
    CPR_PROJEKT_ABGESCHLOSSEN
FROM
    dbp_view.v_cpr_projekt_per_2 cpro
    JOIN dbp_view.v_in_projekt_2 ipro ON ipro.mandant_id  = cpro.mandant_id 
    AND ipro.projekt_ext_id = cpro.cpr_ext_id
    AND ipro.ims_projekt_typ_id IN ('E', 'G', 'B') -- definierte Projekte inkl 'B'
    JOIN dbp_view.v_rpm_element_per_2 rpm ON rpm.mandant_id  = cpro.mandant_id 
    AND rpm.projekt_id = cpro.cpr_ext_id
    AND rpm.dat_bis = '9999-12-31'
    JOIN dbp_view.v_rpm_phase_spr_zu_2 rpsz ON rpsz.rpm_phase_id = rpm.rpm_phase_id
    AND rpsz.rpm_projekt_typ_id = rpm.rpm_projekt_typ_id
    AND rpsz.spr_id = 22
    JOIN dbp_view.v_rpm_status_spr_zu_2 rssz ON rssz.rpm_status_id = rpm.rpm_status_id
    AND rssz.spr_id = 22
    LEFT JOIN (
        -- Ermittlung des Systemstatus aus PSP, Projektion auf Projekt
        SELECT
            ipsp.mandant_id,
            ipsp.in_projekt_id,
            MIN(systemstatus_id) in_systemstatus_min,
            MAX(systemstatus_id) in_systemstatus_max -- Helper
        FROM
            dbp_view.v_in_psp_element_2 ipsp
            JOIN dbp_view.v_ims_psp_ele_sysstat_zu_2 ipes ON ipes.mandant_id = ipsp.mandant_id
            AND ipes.psp_id = ipsp.psp_id
        GROUP BY
            1,
            2
    ) sub02 ON sub02.mandant_id = ipro.mandant_id
    AND sub02.in_projekt_id = ipro.in_projekt_id
    LEFT JOIN dbp_view.v_ims_systemstatus_spr_zu_2 issz ON issz.mandant_id = sub02.mandant_id
    AND issz.systemstatus_id = sub02.in_systemstatus_min
    AND issz.spr_id = 22
    LEFT JOIN (
        -- Ermittlung der Termine aus IOS Views
        SELECT
            pbz.projekt_id,
            cpr.mandant_id,
            pbz.cpr_ext_id,
            MAX(
                CASE
                    WHEN pbz.cpr_suchfeld_id IN (89, 370) THEN CASE
                        WHEN pbz.dat_ende_ist > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_ist
                        WHEN pbz.dat_ende_vorhersage > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_vorhersage
                        WHEN pbz.dat_ende_einschraenkung > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_einschraenkung
                        ELSE NULL
                    END
                    ELSE NULL
                END
            ) AS KBE_FS_VP_VERABSCHIEDET,
            MIN(
                CASE
                    WHEN pbz.cpr_suchfeld_id IN (2, 407) THEN CASE
                        WHEN pbz.dat_ende_ist > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_ist
                        WHEN pbz.dat_ende_vorhersage > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_vorhersage
                        WHEN pbz.dat_ende_einschraenkung > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_einschraenkung
                        ELSE NULL
                    END
                    ELSE NULL
                END
            ) AS BAUBEGINN,
            MIN(
                CASE
                    WHEN pbz.cpr_suchfeld_id IN (275) THEN CASE
                        WHEN pbz.dat_ende_ist > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_ist
                        WHEN pbz.dat_ende_vorhersage > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_vorhersage
                        WHEN pbz.dat_ende_einschraenkung > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_einschraenkung
                        ELSE NULL
                    END
                    ELSE NULL
                END
            ) AS CPR_BAUBEG_KAELTE,
            MIN(
                CASE
                    WHEN pbz.cpr_suchfeld_id IN (3, 408) THEN CASE
                        WHEN pbz.dat_ende_ist > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_ist
                        WHEN pbz.dat_ende_vorhersage > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_vorhersage
                        WHEN pbz.dat_ende_einschraenkung > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_einschraenkung
                        ELSE NULL
                    END
                    ELSE NULL
                END
            ) AS BEGINN_EINRICHTUNG,
            MAX(
                CASE
                    WHEN pbz.cpr_suchfeld_id IN (123) THEN CASE
                        WHEN pbz.dat_ende_ist > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_ist
                        WHEN pbz.dat_ende_vorhersage > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_vorhersage
                        WHEN pbz.dat_ende_einschraenkung > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_einschraenkung
                        ELSE NULL
                    END
                    ELSE NULL
                END
            ) AS CPR_BAUABNAHME,
            MAX(
                CASE
                    WHEN pbz.cpr_suchfeld_id IN (113, 410) THEN CASE
                        WHEN pbz.dat_ende_ist > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_ist
                        WHEN pbz.dat_ende_vorhersage > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_vorhersage
                        WHEN pbz.dat_ende_einschraenkung > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_einschraenkung
                        ELSE NULL
                    END
                    ELSE NULL
                END
            ) AS STILLE_EROEFFNUNG,
            MAX(
                CASE
                    WHEN pbz.cpr_suchfeld_id IN (45, 402) THEN CASE
                        WHEN pbz.dat_ende_ist > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_ist
                        WHEN pbz.dat_ende_vorhersage > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_vorhersage
                        WHEN pbz.dat_ende_einschraenkung > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_einschraenkung
                        ELSE NULL
                    END
                    ELSE NULL
                END
            ) AS CPR_SUBMISSION,
            MAX(
                CASE
                    WHEN pbz.cpr_suchfeld_id IN (46, 403) THEN CASE
                        WHEN pbz.dat_ende_ist > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_ist
                        WHEN pbz.dat_ende_vorhersage > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_vorhersage
                        WHEN pbz.dat_ende_einschraenkung > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_einschraenkung
                        ELSE NULL
                    END
                    ELSE NULL
                END
            ) AS CPR_TECHN_BIETERGESPRAECH,
            MAX(
                CASE
                    WHEN pbz.cpr_suchfeld_id IN (115, 404) THEN CASE
                        WHEN pbz.dat_ende_ist > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_ist
                        WHEN pbz.dat_ende_vorhersage > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_vorhersage
                        WHEN pbz.dat_ende_einschraenkung > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_einschraenkung
                        ELSE NULL
                    END
                    ELSE NULL
                END
            ) AS VERGABE_BAU,
            MAX(
                CASE
                    WHEN pbz.cpr_suchfeld_id IN (401) THEN CASE
                        WHEN pbz.dat_ende_ist > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_ist
                        WHEN pbz.dat_ende_vorhersage > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_vorhersage
                        WHEN pbz.dat_ende_einschraenkung > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_einschraenkung
                        ELSE NULL
                    END
                    ELSE NULL
                END
            ) AS CPR_LV_VERSENDEN,
            MAX(
                CASE
                    WHEN pbz.cpr_suchfeld_id IN (367) THEN CASE
                        WHEN pbz.dat_ende_ist > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_ist
                        WHEN pbz.dat_ende_vorhersage > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_vorhersage
                        WHEN pbz.dat_ende_einschraenkung > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_einschraenkung
                        ELSE NULL
                    END
                    ELSE NULL
                END
            ) AS CPR_P_VORABSTIMMUNG_PRODUKT_FREIGEGEBEN,
            MAX(
                CASE
                    WHEN pbz.cpr_suchfeld_id IN (392) THEN CASE
                        WHEN pbz.dat_ende_ist > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_ist
                        WHEN pbz.dat_ende_vorhersage > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_vorhersage
                        WHEN pbz.dat_ende_einschraenkung > CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_einschraenkung
                        ELSE NULL
                    END
                    ELSE NULL
                END
            ) AS CPR_BAUGENEHMIGUNGEN_GEPRUEFT_VOLLZIEHB,
            --- Objektidee definiert
            MAX(CASE 
                    WHEN pbz.cpr_suchfeld_id IN (358) THEN CASE  
                        WHEN pbz.dat_ende_ist>CAST('1900-01-01' AS DATE)  THEN pbz.dat_ende_ist
                        WHEN pbz.dat_ende_vorhersage> CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_vorhersage
                        WHEN pbz.dat_ende_einschraenkung>CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_einschraenkung
                        ELSE NULL 
                    END
                    ELSE NULL 
                END
            ) AS CPR_PRODUKTIDEE_DEFINIERT,
            --- objekt bestaetigt  
            MAX(CASE 
                    WHEN pbz.cpr_suchfeld_id IN (384) THEN CASE  
                        WHEN pbz.dat_ende_ist>CAST('1900-01-01' AS DATE)  THEN pbz.dat_ende_ist
                        WHEN pbz.dat_ende_vorhersage>CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_vorhersage
                        WHEN pbz.dat_ende_einschraenkung>CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_einschraenkung
                        ELSE NULL 
                    END
                    ELSE NULL 
                END
            ) AS CPR_PRODUKT_BESTAETIGT,
            --- Standortsicherung durchfuehren 
            MAX(CASE 
                    WHEN pbz.cpr_suchfeld_id = 373 THEN CASE  
                        WHEN pbz.dat_ende_ist>CAST('1900-01-01' AS DATE)  THEN pbz.dat_ende_ist
                        WHEN pbz.dat_ende_vorhersage> CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_vorhersage
                        WHEN pbz.dat_ende_einschraenkung>CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_einschraenkung
                        ELSE NULL 
                    END
                    ELSE NULL 
                END
            ) AS CPR_STANDORTSICHERUNG_DURCHFUEHREN,
            --- Projekt abgeschlossen 
            MAX(CASE 
                    WHEN pbz.cpr_suchfeld_id = 427 THEN CASE  
                        WHEN pbz.dat_ende_ist>CAST('1900-01-01' AS DATE)  THEN pbz.dat_ende_ist
                        WHEN pbz.dat_ende_vorhersage>CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_vorhersage
                        WHEN pbz.dat_ende_einschraenkung>CAST('1900-01-01' AS DATE) THEN pbz.dat_ende_einschraenkung
                        ELSE NULL 
                    END
                    ELSE NULL 
                END
            ) AS CPR_PROJEKT_ABGESCHLOSSEN 
        FROM
            dbp_msi_view_ios.mv_cpr_projekt_bauabschnitt_zu_2 pbz
            JOIN dbp_view.v_cpr_projekt_per_2 cpr ON cpr.projekt_id = pbz.projekt_id
            AND cpr.dat_bis = '9999-12-31'
        GROUP BY
            pbz.projekt_id,
            cpr.mandant_id,
            pbz.cpr_ext_id
    ) sub01 ON sub01.projekt_id = cpro.projekt_id
    LEFT JOIN dbp_view.v_tag_2 v01 ON v01.dat = STILLE_EROEFFNUNG

    LEFT JOIN
   dbp_view.v_wup_2 wup_2
  ON rpm.wup_id = wup.wup_id AND rpm.mandant_id = wup.mandant_id --Nur aktuell gültige WUP_2

WHERE
    cpro.dat_bis = '9999-12-31';