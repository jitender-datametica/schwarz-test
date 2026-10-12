--==============================================================
-- Table: marktbestand_erp_tag_sum_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: marktbestand_erp_tag_sum_1
   generated from Powerdesigner on Donnerstag, 23. Januar 2025 15:05:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.marktbestand_erp_tag_sum_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. Zuteilung zum Land.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WUP_1: Warenumschlagsplatz. ID des Lagers / Verteilzentrum (VZ)'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='NB_1: Nebenbetrieb. DWH-Kennzeichnung, um wup_ids unterscheiden zu können. Bspw.: 0 = Markt; -111 = Lager / VZ'),
dat DATE NOT NULL OPTIONS(description='Datum / Tag_1 für den die Bestände und Kennzahlen gelten.'),
gp_id BIGNUMERIC(38,0)
OPTIONS(description='ID des Lieferanten, der für diesen Tag_1 gemäß der Lieferantenzuordnung (dbp_data.art_gp_nm_zu_per_1) für diesen Artikel_1 zugeordnet ist.'),
bezugsweg_id BIGNUMERIC(38,0)
OPTIONS(description='Gibt an, ob der Artikel_1 aus einem VZ (BQ4, zentrale Lieferung) oder direkt vom Lieferant (BQ1, dezentrale Lieferung) geliefert wurde. (SAP-Quelle: ZEKORDERSATZ01_1)'),
posten_id STRING(2)
OPTIONS(description='ID des Posten. Posten sind Artikel_1, die vom Markt in der Regel nicht nachbestellt werden können. Für einen Tag_1 kann ein Artikel_1 immer nur ein Posten oder Sortimentsartikel sein.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='ID der Landeswährung des Landes aus der Mandant_1 - Tabelle.'),
umrechnungskurs_hist BIGNUMERIC(38,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs_1 '),
relevant_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag legt fest, ob der Datensatz für die Fehlmengenauswertung relevant ist. (Wird in der Versorgung aus Listung, Dispomerkmal dismm und kdis gebildet)'),
menge_lgbest_erp_frei_bme BIGNUMERIC(38,3)
OPTIONS(description='Frei verwendbarer Bestand (kann abverkauft werden) (SAP-Quelle: MARD.LABST).'),
menge_lgbest_erp_qual_bme BIGNUMERIC(38,3)
OPTIONS(description='Qualitätsprüfbestand - Bestand, der für eine_1 Qualitätsprüfung zurückgehalten wird (SAP-Quelle: MARD.INSME).'),
menge_lgbest_erp_gesp_bme BIGNUMERIC(38,3)
OPTIONS(description='Gesperrter Bestand, der nicht abverkauft werden darf (SAP-Quelle: MARD.SPEME).'),
vk_netto BIGNUMERIC(38,4) OPTIONS(description='Regulärer Verkaufspreis in Landeswährung (SAP-Quelle: ZVKP.KBETR).'),
vk_netto_konz BIGNUMERIC(38,4)
OPTIONS(description='Regulärer Verkaufspreis in Konzernwährung (SAP-Quelle: ZVKP.KBETR).'),
betrag_vk_netto_lgbest_erp_frei BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter freier Bestand mit dem regulären VK_1 netto in Landeswährung: Freier Bestand * VK_1 netto.'),
betrag_vk_netto_lgbest_erp_frei_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter freier Bestand mit dem regulären VK_1 netto in Konzernwährung: Freier Bestand * VK_1 netto.'),
betrag_vk_netto_lgbest_erp_qual BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem regulären VK_1 netto in Landeswährung: Qualitätsprüfbestand * VK_1 netto.'),
betrag_vk_netto_lgbest_erp_qual_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem regulären VK_1 netto in Konzernwährung: Qualitätsprüfbestand * VK_1 netto.'),
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
OPTIONS(description='Markteinstandspreis ohne Logistikkosten in Konzernwährung (Ebene EKN3: EKN2 abzüglich dauerhaft regelmäßiger Konditionen und nachträglicher Vergütungen wie bspw. Finanz- oder Jahresbonus).'),
betrag_ek_mep_olk_lgbest_erp_frei BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter freier Bestand mit dem ek_mep_olk (Markteinstandspreis ohne Logistikkosten) in Landeswährung: Freier Bestand * ek_mep_olk.'),
betrag_ek_mep_olk_lgbest_erp_frei_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter freier Bestand mit dem ek_mep_olk (Markteinstandspreis ohne Logistikkosten) in Konzernwährung: Freier Bestand * ek_mep_olk_konz.'),
betrag_ek_mep_olk_lgbest_erp_qual BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem ek_mep_olk (Markteinstandspreis ohne Logistikkosten) in Landeswährung: Qualitätsprüfbestand * ek_mep_olk.'),
betrag_ek_mep_olk_lgbest_erp_qual_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem ek_mep_olk (Markteinstandspreis ohne Logistikkosten) in Konzernwährung: Qualitätsprüfbestand * ek_mep_olk_konz.'),
ek_einstandspreis BIGNUMERIC(38,4)
OPTIONS(description='Einstandspreis in Landeswährung (Ebene EKN4: EKN3 abzüglich einmalig langfristiger Konditionen): Unterster EK, darf im VK_1 nicht unterschritten werden.'),
ek_einstandspreis_konz BIGNUMERIC(38,4)
OPTIONS(description='Einstandspreis in Konzernwährung (Ebene EKN4: EKN3 abzüglich einmalig langfristiger Konditionen): Unterster EK, darf im VK_1 nicht unterschritten werden.'),
betrag_ek_einstandspreis_lgbest_erp_frei BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter freier Bestand mit dem ek_einstandspreis in Landeswährung: Freier Bestand * ek_einstandspreis.'),
betrag_ek_einstandspreis_lgbest_erp_frei_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter freier Bestand mit dem ek_einstandspreis in Konzernwährung: Freier Bestand * ek_einstandspreis_konz.'),
betrag_ek_einstandspreis_lgbest_erp_qual BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem ek_einstandspreis in Landeswährung: Qualitätsprüfbestand * ek_einstandspreis.'),
betrag_ek_einstandspreis_lgbest_erp_qual_konz BIGNUMERIC(38,4)
OPTIONS(description='Bewerteter Qualitätsprüfbestand mit dem ek_einstandspreis in Konzernwährung: Qualitätsprüfbestand * ek_einstandspreis_konz.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, wup_id, nb_id, dat) NOT ENFORCED
) CLUSTER BY mandant_id, dat, wup_id
OPTIONS(description='Marktbestände auf Tagesebene, zuzüglich Lieferant, Posten und bewerteter (EK & VK_1) Bestände.');