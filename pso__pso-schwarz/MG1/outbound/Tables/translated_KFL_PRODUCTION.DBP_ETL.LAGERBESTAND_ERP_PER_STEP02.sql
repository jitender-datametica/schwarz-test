DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_ETL.LAGERBESTAND_ERP_PER_STEP02;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_ETL.LAGERBESTAND_ERP_PER_STEP02 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH. Zuteilung zum Land.'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
WUP_ID INTEGER NOT NULL OPTIONS(description='WUP: Warenumschlagsplatz. ID des Lagers / Verteilzentrum (VZ)'),
NB_ID INTEGER NOT NULL
OPTIONS(description='NB: Nebenbetrieb. DWH-Kennzeichnung, um wup_ids unterscheiden zu können. Bspw.: 0 = Markt; -111 = Lager / VZ'),
LAGERORT_ID STRING(4) NOT NULL
OPTIONS(description='ID des Ortes im Lager, an dem der Artikel liegt. Die IDs unterscheiden sich zwischen den Ländern.'),
DAT DATE NOT NULL OPTIONS(description='Datum / Tag für den die Bestände und Kennzahlen gelten.'),
GP_ID INTEGER
OPTIONS(description='ID des Lieferanten, der für diesen Tag gemäß der Lieferantenzuordnung (dbp_data.art_gp_nm_zu_per) für diesen Artikel zugeordnet ist.'),
POSTEN_ID STRING(2)
OPTIONS(description='ID des Posten. Posten sind Artikel, die vom Markt in der Regel nicht nachbestellt werden können. Für einen Tag kann ein Artikel immer nur ein Posten oder Sortimentsartikel sein.'),
WRG_ID STRING(3) NOT NULL OPTIONS(description='ID der Landeswährung des Landes aus der Mandant - Tabelle.'),
SPERR_ID STRING(1)
OPTIONS(description='Inventursperrkennzeichen: Gibt an, ob der Bestand für eine Inventur gesperrt ist (SAP-Quelle: MARD.SPERR).'),
GJMO_BUCH INTEGER
OPTIONS(description='Monat im Geschäftsjahr, in dem der Tagesbestand gebucht wurde (SAP-Quelle: MARD.LFMON).'),
LAGERORT_LOESCH_FG STRING(1)
OPTIONS(description='Gibt an, ober der Artikel aus dem Lagerort ausgetragen wird (SAP-Quelle: MARD.LVROM).'),
PFLEGE_STATUS STRING(20) OPTIONS(description='Pflegestatus (SAP-Quelle: MARD.PSTAT).'),
MENGE_LGBEST_ERP_FREI_BME NUMERIC(29,3)
OPTIONS(description='Frei verwendbarer Bestand (kann an die Märkte geliefert werden) (SAP-Quelle: MARD.LABST).'),
MENGE_LGBEST_ERP_UMLAG_BME NUMERIC(29,3)
OPTIONS(description='Umlagerungsbestand: Bestand, der den Lagerort wechselt (SAP-Quelle: MARD.UMLMD).'),
MENGE_LGBEST_ERP_QUAL_BME NUMERIC(29,3)
OPTIONS(description='Qualitätsprüfbestand - Bestand, der für eine Qualitätsprüfung zurückgehalten wird (SAP-Quelle: MARD.INSME).'),
MENGE_LGBEST_ERP_NF_CHARGE_BME NUMERIC(29,3)
OPTIONS(description='Bestand, der nicht freien Chargen (SAP-Quelle: MARD.EINME).'),
MENGE_LGBEST_ERP_GESP_BME NUMERIC(29,3)
OPTIONS(description='Gesperrter Bestand, der nicht an den Markt geliefert werden darf (SAP-Quelle: MARD.SPEME).'),
MENGE_LGBEST_ERP_RET_GESP_BME NUMERIC(29,3)
OPTIONS(description='Retourensperrbestand: Bestand, der bereits für Retoure geplant ist (SAP-Quelle: MARD.RETME).'),
MENGE_LGBEST_ERP_GESAMT_BME NUMERIC(29,3)
OPTIONS(description='Summe aller Bestandstypen (Frei, Umlagerung, Qualitätsprüfung, Nicht freie Chargen, Gesperrt, Retoure).'),
MENGE_LGBEST_ERP_KOLLI NUMERIC(29,3)
OPTIONS(description='Umrechnung der gesamten Bestandsmenge von BME (Basismengeneinheit) in Kolli.'),
MENGE_LGBEST_ERP_PALETTE NUMERIC(29,3)
OPTIONS(description='Umrechnung der gesamten Bestandsmenge von BME (Basismengeneinheit) in Paletten.'),
VK_NETTO NUMERIC(29,4) OPTIONS(description='Regulärer Verkaufspreis in Landeswährung (SAP-Quelle: ZVKP.KBETR).'),
VK_NETTO_KONZ NUMERIC(29,4) OPTIONS(description='Regulärer Verkaufspreis in Konzernwährung (SAP-Quelle: ZVKP.KBETR).'),
BETRAG_VK_NETTO_LGBEST_ERP_FREI NUMERIC(29,4)
OPTIONS(description='Bewerteter freier Bestand mit dem regulären VK netto in Landeswährung: Freier Bestand * VK netto.'),
BETRAG_VK_NETTO_LGBEST_ERP_FREI_KONZ NUMERIC(29,4)
OPTIONS(description='Bewerteter freier Bestand mit dem regulären VK netto in Konzernwährung: Freier Bestand * VK netto_konz.'),
BETRAG_VK_NETTO_LGBEST_ERP_QUAL NUMERIC(29,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem regulären VK netto in Landeswährung: Qualitätsprüfbestand * VK netto.'),
BETRAG_VK_NETTO_LGBEST_ERP_QUAL_KONZ NUMERIC(29,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem regulären VK netto in Konzernwährung: Qualitätsprüfbestand * VK netto_konz.'),
BETRAG_VK_NETTO_LGBEST_ERP_GESAMT NUMERIC(29,4)
OPTIONS(description='Bewerteter gesamter Bestand mit dem regulären VK netto in Landeswährung: Gesamter Bestand * VK netto.'),
BETRAG_VK_NETTO_LGBEST_ERP_GESAMT_KONZ NUMERIC(29,4)
OPTIONS(description='Bewerteter gesamter Bestand mit dem regulären VK netto in Konzernwährung: Gesamter Bestand * VK netto_konz.'),
EK_NETTO NUMERIC(29,4) OPTIONS(description='Rechnungs-Einkaufspreis in Landeswährung.'),
EK_NETTO_KONZ NUMERIC(29,4) OPTIONS(description='Rechnungs-Einkaufspreis in Konzernwährung.'),
BETRAG_EK_NETTO_LGBEST_ERP_FREI NUMERIC(29,4)
OPTIONS(description='Bewerteter freier Bestand mit dem regulären EK netto (Rechnungs-Einkaufspreis) in Landeswährung: Freier Bestand * EK netto.'),
BETRAG_EK_NETTO_LGBEST_ERP_FREI_KONZ NUMERIC(29,4)
OPTIONS(description='Bewerteter freier Bestand mit dem regulären EK netto (Rechnungs-Einkaufspreis) in Konzernwährung: Freier Bestand * EK netto_konz.'),
BETRAG_EK_NETTO_LGBEST_ERP_QUAL NUMERIC(29,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem regulären EK netto (Rechnungs-Einkaufspreis) in Landeswährung: Qualitätsprüfbestand * EK netto.'),
BETRAG_EK_NETTO_LGBEST_ERP_QUAL_KONZ NUMERIC(29,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem regulären EK netto (Rechnungs-Einkaufspreis) in Konzernwährung: Qualitätsprüfbestand * EK netto_konz.'),
EK_NETTO_BNK NUMERIC(29,4)
OPTIONS(description='EK netto (Rechnungs-Einkaufspreis) zuzüglich Bezugsnebenkosten in Landeswährung.'),
EK_NETTO_BNK_KONZ NUMERIC(29,4)
OPTIONS(description='EK netto (Rechnungs-Einkaufspreis) zuzüglich Bezugsnebenkosten in Konzernwährung.'),
BETRAG_EK_NETTO_BNK_LGBEST_ERP_FREI NUMERIC(29,4)
OPTIONS(description='Bewerteter freier Bestand mit dem EK netto BNK in Landeswährung: Freier Bestand * (EK netto + Bezugsnebenkosten).'),
BETRAG_EK_NETTO_BNK_LGBEST_ERP_FREI_KONZ NUMERIC(29,4)
OPTIONS(description='Bewerteter freier Bestand mit dem EK netto BNK in Konzernwährung: Freier Bestand * (EK netto + Bezugsnebenkosten).'),
BETRAG_EK_NETTO_BNK_LGBEST_ERP_QUAL NUMERIC(29,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem EK netto BNK in Landeswährung: Qualitätsprüfbestand * (EK netto + Bezugsnebenkosten).'),
BETRAG_EK_NETTO_BNK_LGBEST_ERP_QUAL_KONZ NUMERIC(29,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem EK netto BNK in Konzernwährung: Qualitätsprüfbestand * (EK netto + Bezugsnebenkosten).'),
EK_NETTONETTO NUMERIC(29,4) OPTIONS(description='EK netto (Rechnungs-Einkaufspreis) abzüglich Skonto in Landeswährung.'),
EK_NETTONETTO_KONZ NUMERIC(29,4)
OPTIONS(description='EK netto (Rechnungs-Einkaufspreis) abzüglich Skonto in Konzernwährung.'),
BETRAG_EK_NETTONETTO_LGBEST_ERP_FREI NUMERIC(29,4)
OPTIONS(description='Bewerteter freier Bestand mit dem EK netto netto in Landeswährung: Freier Bestand * (EK netto - Skonto).'),
BETRAG_EK_NETTONETTO_LGBEST_ERP_FREI_KONZ NUMERIC(29,4)
OPTIONS(description='Bewerteter freier Bestand mit dem EK netto netto in Konzernwährung: Freier Bestand * (EK netto - Skonto).'),
BETRAG_EK_NETTONETTO_LGBEST_ERP_QUAL NUMERIC(29,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem EK netto netto in Landeswährung: Qualitätsprüfbestand * (EK netto - Skonto).'),
BETRAG_EK_NETTONETTO_LGBEST_ERP_QUAL_KONZ NUMERIC(29,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem EK netto netto in Konzernwährung: Qualitätsprüfbestand * (EK netto - Skonto).'),
EK_MEP_OLK NUMERIC(29,4)
OPTIONS(description='Markteinstandspreis ohne Logistikkosten in Landeswährung (Ebene EKN3: EKN2 abzüglich dauerhaft regelmäßiger Konditionen und nachträglicher Vergütungen wie bspw. Finanz- oder Jahresbonus).'),
EK_MEP_OLK_KONZ NUMERIC(29,4)
OPTIONS(description='Markteinstandspreis ohne Logistikkosten in Konzernwährung  (Ebene EKN3: EKN2 abzüglich dauerhaft regelmäßiger Konditionen und nachträglicher Vergütungen wie bspw. Finanz- oder Jahresbonus).'),
BETRAG_EK_MEP_OLK_LGBEST_ERP_FREI NUMERIC(29,4)
OPTIONS(description='Bewerteter freier Bestand mit dem ek_mep_olk (Markteinstandspreis ohne Logistikkosten) in Landeswährung: Freier Bestand * ek_mep_olk.'),
BETRAG_EK_MEP_OLK_LGBEST_ERP_FREI_KONZ NUMERIC(29,4)
OPTIONS(description='Bewerteter freier Bestand mit dem ek_mep_olk (Markteinstandspreis ohne Logistikkosten) in Konzernwährung: Freier Bestand * ek_mep_olk_konz.'),
BETRAG_EK_MEP_OLK_LGBEST_ERP_QUAL NUMERIC(29,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem ek_mep_olk (Markteinstandspreis ohne Logistikkosten) in Landeswährung: Qualitätsprüfbestand * ek_mep_olk.'),
BETRAG_EK_MEP_OLK_LGBEST_ERP_QUAL_KONZ NUMERIC(29,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem ek_mep_olk (Markteinstandspreis ohne Logistikkosten) in Konzernwährung: Qualitätsprüfbestand * ek_mep_olk_konz.'),
EK_EINSTANDSPREIS NUMERIC(29,4)
OPTIONS(description='Einstandspreis in Landeswährung (Ebene EKN4: EKN3 abzüglich einmalig langfristiger Konditionen): Unterster EK, darf im VK nicht unterschritten werden.'),
EK_EINSTANDSPREIS_KONZ NUMERIC(29,4)
OPTIONS(description='Einstandspreis in Konzernwährung (Ebene EKN4: EKN3 abzüglich einmalig langfristiger Konditionen): Unterster EK, darf im VK nicht unterschritten werden.'),
BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_FREI NUMERIC(29,4)
OPTIONS(description='Bewerteter freier Bestand mit dem ek_einstandspreis in Landeswährung: Freier Bestand * ek_einstandspreis.'),
BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_FREI_KONZ NUMERIC(29,4)
OPTIONS(description='Bewerteter freier Bestand mit dem ek_einstandspreis in Konzernwährung: Freier Bestand * ek_einstandspreis_konz.'),
BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_QUAL NUMERIC(29,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem ek_einstandspreis in Landeswährung: Qualitätsprüfbestand * ek_einstandspreis.'),
BETRAG_EK_EINSTANDSPREIS_LGBEST_ERP_QUAL_KONZ NUMERIC(29,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem ek_einstandspreis in Konzernwährung: Qualitätsprüfbestand * ek_einstandspreis_konz.'),
EK_LOGISTIK NUMERIC(29,4)
OPTIONS(description='Konditionsmix für DE und KMO in Landeswährung, genutzt für bewertete Bestände im Bereich Logistik / SCM: Für DE wird der ek_netto_bnk (aus dbp_data.art_gp_wup_zu_per), für KMO der gld (gleitenderDurchschnitt aus dbp_data.art_bewertungskreis_periode) verwendet.'),
EK_LOGISTIK_KONZ NUMERIC(29,4)
OPTIONS(description='Konditionsmix für DE und KMO in Konzernwährung, genutzt für bewertete Bestände im Bereich Logistik / SCM: Für DE wird der ek_netto_bnk (aus dbp_data.art_gp_wup_zu_per), für KMO der gld (gleitenderDurchschnitt aus dbp_data.art_bewertungskreis_periode) verwendet.'),
BETRAG_EK_LOGISTIK_LGBEST_ERP_GESAMT NUMERIC(29,4)
OPTIONS(description='Bewerteter gesamter Bestand mit dem ek_logistik in Landeswährung: Gesamter Bestand * ek_logistik.'),
BETRAG_EK_LOGISTIK_LGBEST_ERP_GESAMT_KONZ NUMERIC(29,4)
OPTIONS(description='Bewerteter gesamter Bestand mit dem ek_logistik in Konzernwährung: Gesamter Bestand * ek_logistik_konz.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
UMRECHNUNGSKURS_HIST NUMERIC(29,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs '),
PRIMARY KEY (MANDANT_ID, ART_ID, WUP_ID, NB_ID, LAGERORT_ID, DAT) NOT ENFORCED
) CLUSTER BY MANDANT_ID, DAT, WUP_ID;