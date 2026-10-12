--==============================================================
-- Table: marktbestand_erp_tag_sum_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: marktbestand_erp_tag_sum_2
   generated from Powerdesigner on Donnerstag, 23. Januar 2025 15:05:46
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.MARKTBESTAND_ERP_TAG_SUM_2 CLUSTER BY (
     MANDANT_ID,
     DAT,
     WUP_ID
) (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH. Zuteilung zum Land.',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'WUP_2: Warenumschlagsplatz. ID des Lagers / Verteilzentrum (VZ)',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'NB_2: Nebenbetrieb. DWH-Kennzeichnung, um wup_ids unterscheiden zu können. Bspw.: 0 = Markt; -111 = Lager / VZ',
   dat                                 DATE             NOT NULL COMMENT 'Datum / Tag_2 für den die Bestände und Kennzahlen gelten.',
   gp_id                               NUMBER(38,0)     COMMENT 'ID des Lieferanten, der für diesen Tag_2 gemäß der Lieferantenzuordnung (dbp_data.art_gp_nm_zu_per_2) für diesen Artikel_2 zugeordnet ist.',
   bezugsweg_id                        NUMBER(38,0)     COMMENT 'Gibt an, ob der Artikel_2 aus einem VZ (BQ4, zentrale Lieferung) oder direkt vom Lieferant (BQ1, dezentrale Lieferung) geliefert wurde. (SAP-Quelle: ZEKORDERSATZ01_2)',
   posten_id                           VARCHAR(2)       COMMENT 'ID des Posten. Posten sind Artikel_2, die vom Markt in der Regel nicht nachbestellt werden können. Für einen Tag_2 kann ein Artikel_2 immer nur ein Posten oder Sortimentsartikel sein.',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'ID der Landeswährung des Landes aus der Mandant_2 - Tabelle.',
   umrechnungskurs_hist                NUMBER(38,5)     NOT NULL DEFAULT 0 COMMENT 'Historischer Berichtskurs aus dbp_data.kurs_2 ',
   relevant_fg                         NUMBER(38,0)     COMMENT 'Flag legt fest, ob der Datensatz für die Fehlmengenauswertung relevant ist. (Wird in der Versorgung aus Listung, Dispomerkmal dismm und kdis gebildet)',
   menge_lgbest_erp_frei_bme           NUMBER(38,3)     COMMENT 'Frei verwendbarer Bestand (kann abverkauft werden) (SAP-Quelle: MARD.LABST).',
   menge_lgbest_erp_qual_bme           NUMBER(38,3)     COMMENT 'Qualitätsprüfbestand - Bestand, der für eine_2 Qualitätsprüfung zurückgehalten wird (SAP-Quelle: MARD.INSME).',
   menge_lgbest_erp_gesp_bme           NUMBER(38,3)     COMMENT 'Gesperrter Bestand, der nicht abverkauft werden darf (SAP-Quelle: MARD.SPEME).',
   vk_netto                            NUMBER(38,4)     COMMENT 'Regulärer Verkaufspreis in Landeswährung (SAP-Quelle: ZVKP.KBETR).',
   vk_netto_konz                       NUMBER(38,4)     COMMENT 'Regulärer Verkaufspreis in Konzernwährung (SAP-Quelle: ZVKP.KBETR).',
   betrag_vk_netto_lgbest_erp_frei     NUMBER(38,4)     COMMENT 'Bewerteter freier Bestand mit dem regulären VK_2 netto in Landeswährung: Freier Bestand * VK_2 netto.',
   betrag_vk_netto_lgbest_erp_frei_konz NUMBER(38,4)     COMMENT 'Bewerteter freier Bestand mit dem regulären VK_2 netto in Konzernwährung: Freier Bestand * VK_2 netto.',
   betrag_vk_netto_lgbest_erp_qual     NUMBER(38,4)     COMMENT 'Bewerteter Qualitätsprüfbestand mit dem regulären VK_2 netto in Landeswährung: Qualitätsprüfbestand * VK_2 netto.',
   betrag_vk_netto_lgbest_erp_qual_konz NUMBER(38,4)     COMMENT 'Bewerteter Qualitätsprüfbestand mit dem regulären VK_2 netto in Konzernwährung: Qualitätsprüfbestand * VK_2 netto.',
   ek_netto                            NUMBER(38,4)     COMMENT 'Rechnungs-Einkaufspreis in Landeswährung.',
   ek_netto_konz                       NUMBER(38,4)     COMMENT 'Rechnungs-Einkaufspreis in Konzernwährung.',
   betrag_ek_netto_lgbest_erp_frei     NUMBER(38,4)     COMMENT 'Bewerteter freier Bestand mit dem regulären EK netto (Rechnungs-Einkaufspreis) in Landeswährung: Freier Bestand * EK netto.',
   betrag_ek_netto_lgbest_erp_frei_konz NUMBER(38,4)     COMMENT 'Bewerteter freier Bestand mit dem regulären EK netto (Rechnungs-Einkaufspreis) in Konzernwährung: Freier Bestand * EK netto_konz.',
   betrag_ek_netto_lgbest_erp_qual     NUMBER(38,4)     COMMENT 'Bewerteter Qualitätsprüfbestand mit dem regulären EK netto (Rechnungs-Einkaufspreis) in Landeswährung: Qualitätsprüfbestand * EK netto.',
   betrag_ek_netto_lgbest_erp_qual_konz NUMBER(38,4)     COMMENT 'Bewerteter Qualitätsprüfbestand mit dem regulären EK netto (Rechnungs-Einkaufspreis) in Konzernwährung: Qualitätsprüfbestand * EK netto_konz.',
   ek_netto_bnk                        NUMBER(38,4)     COMMENT 'EK netto (Rechnungs-Einkaufspreis) zuzüglich Bezugsnebenkosten in Landeswährung.',
   ek_netto_bnk_konz                   NUMBER(38,4)     COMMENT 'EK netto (Rechnungs-Einkaufspreis) zuzüglich Bezugsnebenkosten in Konzernwährung.',
   betrag_ek_netto_bnk_lgbest_erp_frei NUMBER(38,4)     COMMENT 'Bewerteter freier Bestand mit dem EK netto BNK in Landeswährung: Freier Bestand * (EK netto + Bezugsnebenkosten).',
   betrag_ek_netto_bnk_lgbest_erp_frei_konz NUMBER(38,4)     COMMENT 'Bewerteter freier Bestand mit dem EK netto BNK in Konzernwährung: Freier Bestand * (EK netto + Bezugsnebenkosten).',
   betrag_ek_netto_bnk_lgbest_erp_qual NUMBER(38,4)     COMMENT 'Bewerteter Qualitätsprüfbestand mit dem EK netto BNK in Landeswährung: Qualitätsprüfbestand * (EK netto + Bezugsnebenkosten).',
   betrag_ek_netto_bnk_lgbest_erp_qual_konz NUMBER(38,4)     COMMENT 'Bewerteter Qualitätsprüfbestand mit dem EK netto BNK in Konzernwährung: Qualitätsprüfbestand * (EK netto + Bezugsnebenkosten).',
   ek_nettonetto                       NUMBER(38,4)     COMMENT 'EK netto (Rechnungs-Einkaufspreis) abzüglich Skonto in Landeswährung.',
   ek_nettonetto_konz                  NUMBER(38,4)     COMMENT 'EK netto (Rechnungs-Einkaufspreis) abzüglich Skonto in Konzernwährung.',
   betrag_ek_nettonetto_lgbest_erp_frei NUMBER(38,4)     COMMENT 'Bewerteter freier Bestand mit dem EK netto netto in Landeswährung: Freier Bestand * (EK netto - Skonto).',
   betrag_ek_nettonetto_lgbest_erp_frei_konz NUMBER(38,4)     COMMENT 'Bewerteter freier Bestand mit dem EK netto netto in Konzernwährung: Freier Bestand * (EK netto - Skonto).',
   betrag_ek_nettonetto_lgbest_erp_qual NUMBER(38,4)     COMMENT 'Bewerteter Qualitätsprüfbestand mit dem EK netto netto in Landeswährung: Qualitätsprüfbestand * (EK netto - Skonto).',
   betrag_ek_nettonetto_lgbest_erp_qual_konz NUMBER(38,4)     COMMENT 'Bewerteter Qualitätsprüfbestand mit dem EK netto netto in Konzernwährung: Qualitätsprüfbestand * (EK netto - Skonto).',
   ek_mep_olk                          NUMBER(38,4)     COMMENT 'Markteinstandspreis ohne Logistikkosten in Landeswährung (Ebene EKN3: EKN2 abzüglich dauerhaft regelmäßiger Konditionen und nachträglicher Vergütungen wie bspw. Finanz- oder Jahresbonus).',
   ek_mep_olk_konz                     NUMBER(38,4)     COMMENT 'Markteinstandspreis ohne Logistikkosten in Konzernwährung (Ebene EKN3: EKN2 abzüglich dauerhaft regelmäßiger Konditionen und nachträglicher Vergütungen wie bspw. Finanz- oder Jahresbonus).',
   betrag_ek_mep_olk_lgbest_erp_frei   NUMBER(38,4)     COMMENT 'Bewerteter freier Bestand mit dem ek_mep_olk (Markteinstandspreis ohne Logistikkosten) in Landeswährung: Freier Bestand * ek_mep_olk.',
   betrag_ek_mep_olk_lgbest_erp_frei_konz NUMBER(38,4)     COMMENT 'Bewerteter freier Bestand mit dem ek_mep_olk (Markteinstandspreis ohne Logistikkosten) in Konzernwährung: Freier Bestand * ek_mep_olk_konz.',
   betrag_ek_mep_olk_lgbest_erp_qual   NUMBER(38,4)     COMMENT 'Bewerteter Qualitätsprüfbestand mit dem ek_mep_olk (Markteinstandspreis ohne Logistikkosten) in Landeswährung: Qualitätsprüfbestand * ek_mep_olk.',
   betrag_ek_mep_olk_lgbest_erp_qual_konz NUMBER(38,4)     COMMENT 'Bewerteter Qualitätsprüfbestand mit dem ek_mep_olk (Markteinstandspreis ohne Logistikkosten) in Konzernwährung: Qualitätsprüfbestand * ek_mep_olk_konz.',
   ek_einstandspreis                   NUMBER(38,4)     COMMENT 'Einstandspreis in Landeswährung (Ebene EKN4: EKN3 abzüglich einmalig langfristiger Konditionen): Unterster EK, darf im VK_2 nicht unterschritten werden.',
   ek_einstandspreis_konz              NUMBER(38,4)     COMMENT 'Einstandspreis in Konzernwährung (Ebene EKN4: EKN3 abzüglich einmalig langfristiger Konditionen): Unterster EK, darf im VK_2 nicht unterschritten werden.',
   betrag_ek_einstandspreis_lgbest_erp_frei NUMBER(38,4)     COMMENT 'Bewerteter freier Bestand mit dem ek_einstandspreis in Landeswährung: Freier Bestand * ek_einstandspreis.',
   betrag_ek_einstandspreis_lgbest_erp_frei_konz NUMBER(38,4)     COMMENT 'Bewerteter freier Bestand mit dem ek_einstandspreis in Konzernwährung: Freier Bestand * ek_einstandspreis_konz.',
   betrag_ek_einstandspreis_lgbest_erp_qual NUMBER(38,4)     COMMENT 'Bewerteter Qualitätsprüfbestand mit dem ek_einstandspreis in Landeswährung: Qualitätsprüfbestand * ek_einstandspreis.',
   betrag_ek_einstandspreis_lgbest_erp_qual_konz NUMBER(38,4)     COMMENT 'Bewerteter Qualitätsprüfbestand mit dem ek_einstandspreis in Konzernwährung: Qualitätsprüfbestand * ek_einstandspreis_konz.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_MARKTBESTAND_ERP_TAG_SUM PRIMARY KEY (mandant_id, art_id, wup_id, nb_id, dat) NOT ENFORCED
)  COMMENT = 'Marktbestände auf Tagesebene, zuzüglich Lieferant, Posten und bewerteter (EK & VK_2) Bestände.';
