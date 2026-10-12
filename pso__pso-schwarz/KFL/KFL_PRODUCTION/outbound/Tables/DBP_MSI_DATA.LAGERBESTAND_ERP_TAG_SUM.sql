--==============================================================
-- Table: lagerbestand_erp_tag_sum
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lagerbestand_erp_tag_sum
   generated from Powerdesigner on Donnerstag, 23. Januar 2025 15:05:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.lagerbestand_erp_tag_sum (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH. Zuteilung zum Land.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WUP: Warenumschlagsplatz. ID des Lagers / Verteilzentrum (VZ)'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='NB: Nebenbetrieb. DWH-Kennzeichnung, um wup_ids unterscheiden zu können. Bspw.: 0 = Markt; -111 = Lager / VZ'),
lagerort_id STRING(4) NOT NULL
OPTIONS(description='ID des Ortes im Lager, an dem der Artikel liegt. Die IDs unterscheiden sich zwischen den Ländern.'),
dat DATE NOT NULL OPTIONS(description='Datum / Tag für den die Bestände und Kennzahlen gelten.'),
gp_id BIGNUMERIC(38,0)
OPTIONS(description='ID des Lieferanten, der für diesen Tag gemäß der Lieferantenzuordnung (dbp_data.art_gp_nm_zu_per) für diesen Artikel zugeordnet ist.'),
posten_id STRING(2)
OPTIONS(description='ID des Posten. Posten sind Artikel, die vom Markt in der Regel nicht nachbestellt werden können. Für einen Tag kann ein Artikel immer nur ein Posten oder Sortimentsartikel sein.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='ID der Landeswährung des Landes aus der Mandant - Tabelle.'),
umrechnungskurs_hist BIGNUMERIC(38,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs '),
sperr_id STRING(1)
OPTIONS(description='Inventursperrkennzeichen: Gibt an, ob der Bestand für eine Inventur gesperrt ist (SAP-Quelle: MARD.SPERR).'),
gjmo_buch BIGNUMERIC(38,0)
OPTIONS(description='Monat im Geschäftsjahr, in dem der Tagesbestand gebucht wurde (SAP-Quelle: MARD.LFMON).'),
lagerort_loesch_fg STRING(1)
OPTIONS(description='Gibt an, ober der Artikel aus dem Lagerort ausgetragen wird (SAP-Quelle: MARD.LVROM).'),
pflege_status STRING(20) OPTIONS(description='Pflegestatus (SAP-Quelle: MARD.PSTAT).'),
menge_lgbest_erp_frei_bme BIGNUMERIC(38,3)
OPTIONS(description='Frei verwendbarer Bestand (kann an die Märkte geliefert werden) (SAP-Quelle: MARD.LABST).'),
menge_lgbest_erp_umlag_bme BIGNUMERIC(38,3)
OPTIONS(description='Umlagerungsbestand: Bestand, der den Lagerort wechselt (SAP-Quelle: MARD.UMLMD).'),
menge_lgbest_erp_qual_bme BIGNUMERIC(38,3)
OPTIONS(description='Qualitätsprüfbestand - Bestand, der für eine Qualitätsprüfung zurückgehalten wird (SAP-Quelle: MARD.INSME).'),
menge_lgbest_erp_nf_charge_bme BIGNUMERIC(38,3)
OPTIONS(description='Bestand, der nicht freien Chargen (SAP-Quelle: MARD.EINME).'),
menge_lgbest_erp_gesp_bme BIGNUMERIC(38,3)
OPTIONS(description='Gesperrter Bestand, der nicht an den Markt geliefert werden darf (SAP-Quelle: MARD.SPEME).'),
menge_lgbest_erp_ret_gesp_bme BIGNUMERIC(38,3)
OPTIONS(description='Retourensperrbestand: Bestand, der bereits für Retoure geplant ist (SAP-Quelle: MARD.RETME).'),
menge_lgbest_erp_gesamt_bme BIGNUMERIC(38,3)
OPTIONS(description='Summe aller Bestandstypen (Frei, Umlagerung, Qualitätsprüfung, Nicht freie Chargen, Gesperrt, Retoure).'),
menge_lgbest_erp_kolli BIGNUMERIC(38,3)
OPTIONS(description='Umrechnung der gesamten Bestandsmenge von BME (Basismengeneinheit) in Kolli.'),
menge_lgbest_erp_palette BIGNUMERIC(38,3)
OPTIONS(description='Umrechnung der gesamten Bestandsmenge von BME (Basismengeneinheit) in Paletten.'),
vk_netto BIGNUMERIC(38,4) OPTIONS(description='Regulärer Verkaufspreis in Landeswährung (SAP-Quelle: ZVKP.KBETR).'),
vk_netto_konz BIGNUMERIC(38,4)
OPTIONS(description='Regulärer Verkaufspreis in Konzernwährung (SAP-Quelle: ZVKP.KBETR).'),
betrag_vk_netto_lgbest_erp_frei BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter freier Bestand mit dem regulären VK netto in Landeswährung: Freier Bestand * VK netto.'),
betrag_vk_netto_lgbest_erp_frei_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter freier Bestand mit dem regulären VK netto in Konzernwährung: Freier Bestand * VK netto_konz.'),
betrag_vk_netto_lgbest_erp_qual BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem regulären VK netto in Landeswährung: Qualitätsprüfbestand * VK netto.'),
betrag_vk_netto_lgbest_erp_qual_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem regulären VK netto in Konzernwährung: Qualitätsprüfbestand * VK netto_konz.'),
betrag_vk_netto_lgbest_erp_gesamt BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter gesamter Bestand mit dem regulären VK netto in Landeswährung: Gesamter Bestand * VK netto.'),
betrag_vk_netto_lgbest_erp_gesamt_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter gesamter Bestand mit dem regulären VK netto in Konzernwährung: Gesamter Bestand * VK netto_konz.'),
ek_netto BIGNUMERIC(38,4) OPTIONS(description='Rechnungs-Einkaufspreis in Landeswährung.'),
ek_netto_konz BIGNUMERIC(38,4) OPTIONS(description='Rechnungs-Einkaufspreis in Konzernwährung.'),
betrag_ek_netto_lgbest_erp_frei BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter freier Bestand mit dem regulären EK netto (Rechnungs-Einkaufspreis) in Landeswährung: Freier Bestand * EK netto.'),
betrag_ek_netto_lgbest_erp_frei_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter freier Bestand mit dem regulären EK netto (Rechnungs-Einkaufspreis) in Konzernwährung: Freier Bestand * EK netto_konz.'),
betrag_ek_netto_lgbest_erp_qual BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem regulären EK netto (Rechnungs-Einkaufspreis) in Landeswährung: Qualitätsprüfbestand * EK netto.'),
betrag_ek_netto_lgbest_erp_qual_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem regulären EK netto (Rechnungs-Einkaufspreis) in Konzernwährung: Qualitätsprüfbestand * EK netto_konz.'),
ek_netto_bnk BIGNUMERIC(38,4)
OPTIONS(description='EK netto (Rechnungs-Einkaufspreis) zuzüglich Bezugsnebenkosten in Landeswährung.'),
ek_netto_bnk_konz BIGNUMERIC(38,4)
OPTIONS(description='EK netto (Rechnungs-Einkaufspreis) zuzüglich Bezugsnebenkosten in Konzernwährung.'),
betrag_ek_netto_bnk_lgbest_erp_frei BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter freier Bestand mit dem EK netto BNK in Landeswährung: Freier Bestand * (EK netto + Bezugsnebenkosten).'),
betrag_ek_netto_bnk_lgbest_erp_frei_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter freier Bestand mit dem EK netto BNK in Konzernwährung: Freier Bestand * (EK netto + Bezugsnebenkosten).'),
betrag_ek_netto_bnk_lgbest_erp_qual BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem EK netto BNK in Landeswährung: Qualitätsprüfbestand * (EK netto + Bezugsnebenkosten).'),
betrag_ek_netto_bnk_lgbest_erp_qual_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem EK netto BNK in Konzernwährung: Qualitätsprüfbestand * (EK netto + Bezugsnebenkosten).'),
ek_nettonetto BIGNUMERIC(38,4)
OPTIONS(description='EK netto (Rechnungs-Einkaufspreis) abzüglich Skonto in Landeswährung.'),
ek_nettonetto_konz BIGNUMERIC(38,4)
OPTIONS(description='EK netto (Rechnungs-Einkaufspreis) abzüglich Skonto in Konzernwährung.'),
betrag_ek_nettonetto_lgbest_erp_frei BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter freier Bestand mit dem EK netto netto in Landeswährung: Freier Bestand * (EK netto - Skonto).'),
betrag_ek_nettonetto_lgbest_erp_frei_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter freier Bestand mit dem EK netto netto in Konzernwährung: Freier Bestand * (EK netto - Skonto).'),
betrag_ek_nettonetto_lgbest_erp_qual BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem EK netto netto in Landeswährung: Qualitätsprüfbestand * (EK netto - Skonto).'),
betrag_ek_nettonetto_lgbest_erp_qual_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem EK netto netto in Konzernwährung: Qualitätsprüfbestand * (EK netto - Skonto).'),
ek_mep_olk BIGNUMERIC(38,4)
OPTIONS(description='Markteinstandspreis ohne Logistikkosten in Landeswährung (Ebene EKN3: EKN2 abzüglich dauerhaft regelmäßiger Konditionen und nachträglicher Vergütungen wie bspw. Finanz- oder Jahresbonus).'),
ek_mep_olk_konz BIGNUMERIC(38,4)
OPTIONS(description='Markteinstandspreis ohne Logistikkosten in Konzernwährung  (Ebene EKN3: EKN2 abzüglich dauerhaft regelmäßiger Konditionen und nachträglicher Vergütungen wie bspw. Finanz- oder Jahresbonus).'),
betrag_ek_mep_olk_lgbest_erp_frei BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter freier Bestand mit dem ek_mep_olk (Markteinstandspreis ohne Logistikkosten) in Landeswährung: Freier Bestand * ek_mep_olk.'),
betrag_ek_mep_olk_lgbest_erp_frei_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter freier Bestand mit dem ek_mep_olk (Markteinstandspreis ohne Logistikkosten) in Konzernwährung: Freier Bestand * ek_mep_olk_konz.'),
betrag_ek_mep_olk_lgbest_erp_qual BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem ek_mep_olk (Markteinstandspreis ohne Logistikkosten) in Landeswährung: Qualitätsprüfbestand * ek_mep_olk.'),
betrag_ek_mep_olk_lgbest_erp_qual_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem ek_mep_olk (Markteinstandspreis ohne Logistikkosten) in Konzernwährung: Qualitätsprüfbestand * ek_mep_olk_konz.'),
ek_einstandspreis BIGNUMERIC(38,4)
OPTIONS(description='Einstandspreis in Landeswährung (Ebene EKN4: EKN3 abzüglich einmalig langfristiger Konditionen): Unterster EK, darf im VK nicht unterschritten werden.'),
ek_einstandspreis_konz BIGNUMERIC(38,4)
OPTIONS(description='Einstandspreis in Konzernwährung (Ebene EKN4: EKN3 abzüglich einmalig langfristiger Konditionen): Unterster EK, darf im VK nicht unterschritten werden.'),
betrag_ek_einstandspreis_lgbest_erp_frei BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter freier Bestand mit dem ek_einstandspreis in Landeswährung: Freier Bestand * ek_einstandspreis.'),
betrag_ek_einstandspreis_lgbest_erp_frei_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter freier Bestand mit dem ek_einstandspreis in Konzernwährung: Freier Bestand * ek_einstandspreis_konz.'),
betrag_ek_einstandspreis_lgbest_erp_qual BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem ek_einstandspreis in Landeswährung: Qualitätsprüfbestand * ek_einstandspreis.'),
betrag_ek_einstandspreis_lgbest_erp_qual_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem ek_einstandspreis in Konzernwährung: Qualitätsprüfbestand * ek_einstandspreis_konz.'),
ek_logistik BIGNUMERIC(38,4)
OPTIONS(description='Konditionsmix für DE und KMO in Landeswährung, genutzt für bewertete Bestände im Bereich Logistik / SCM: Für DE wird der ek_netto_bnk (aus dbp_data.art_gp_wup_zu_per), für KMO der gld (gleitenderDurchschnitt aus dbp_data.art_bewertungskreis_periode) verwendet.'),
ek_logistik_konz BIGNUMERIC(38,4)
OPTIONS(description='Konditionsmix für DE und KMO in Konzernwährung, genutzt für bewertete Bestände im Bereich Logistik / SCM: Für DE wird der ek_netto_bnk (aus dbp_data.art_gp_wup_zu_per), für KMO der gld (gleitenderDurchschnitt aus dbp_data.art_bewertungskreis_periode) verwendet.'),
betrag_ek_logistik_lgbest_erp_gesamt BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter gesamter Bestand mit dem ek_logistik in Landeswährung: Gesamter Bestand * ek_logistik.'),
betrag_ek_logistik_lgbest_erp_gesamt_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter gesamter Bestand mit dem ek_logistik in Konzernwährung: Gesamter Bestand * ek_logistik_konz.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, wup_id, nb_id, lagerort_id, dat) NOT ENFORCED
) CLUSTER BY mandant_id, dat, wup_id
OPTIONS(description='Lagerbestände auf Tagesebene, zuzüglich Lieferant, Posten und bewerteter (EK & VK) Bestände.');