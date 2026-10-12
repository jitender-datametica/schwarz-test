--==============================================================
-- Table: vis_tag_umsatz_kunde_wup_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vis_tag_umsatz_kunde_wup_1
   generated from Powerdesigner on Mittwoch, 9. April 2025 15:21:29
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.VIS_TAG_UMSATZ_KUNDE_WUP_1 CLUSTER BY (
     MANDANT_ID,
     DAT 
) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   dat                                 DATE             NOT NULL COMMENT 'Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM_1-DD',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wup_id                              INTEGER     NOT NULL COMMENT 'Nummer des Warenumschlagsplatzes',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   gj                                  INTEGER     NOT NULL COMMENT 'Geschäftsjahr',
   akt_gj                              INTEGER     NOT NULL COMMENT 'Zähler auf Basis des aktuellen Geschäftsjahres',
   kjmo                                INTEGER     NOT NULL COMMENT 'Kalenderjahremonat, Format JJJJMM',
   akt_mo                              INTEGER     NOT NULL COMMENT 'Zähler auf Basis des aktuellen Kalendermonats',
   kjwo                                INTEGER     NOT NULL COMMENT 'Kalenderjahreswoche, Format JJJJWW',
   akt_wo                              INTEGER     NOT NULL COMMENT 'Zähler auf Basis der aktuellen Kalenderwoche',
   wtag_id                             INTEGER     NOT NULL COMMENT 'Wochentag ID',
   akt_tag                             INTEGER     NOT NULL COMMENT 'Zähler auf Basis des aktuellen Tages',
   ums_netto                           NUMBER(29,4)     NOT NULL COMMENT 'Umsatz netto',
   ums_netto_af                        NUMBER(29,4)     COMMENT 'Aktionsfreier Netto Umsatz auf Ebene Markt / Tage',
   ums_netto_sa                        NUMBER(29,4)     COMMENT 'Sonderaktion Netto Umsatz auf Ebene Markt / Tag_1',
   ums_netto_wvj                       NUMBER(29,4)     NOT NULL COMMENT 'Umsatz netto Wochentag im Vorjahr',
   ums_netto_af_wvj                    NUMBER(29,4)     COMMENT 'Aktionsfreier Netto Umsatz des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag_1',
   ums_netto_sa_wvj                    NUMBER(29,4)     COMMENT 'Sonderaktion Netto Umsatz des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag_1',
   ums_netto_wvvj                      NUMBER(29,4)     NOT NULL COMMENT 'Umsatz netto Wochentag im Vorvorjahr',
   ums_netto_af_wvvj                   NUMBER(29,4)     COMMENT 'Aktionsfreier Netto Umsatz des vergleichbaren Wochentages des Vorvorjahres auf Ebene Markt / Tag_1',
   ums_netto_sa_wvvj                   NUMBER(29,4)     COMMENT 'Sonderaktion Netto Umsatz des vergleichbaren Wochentages des Vorvorjahres auf Ebene Markt / Tag_1',
   ums_netto_kvj                       NUMBER(29,4)     NOT NULL COMMENT 'Umsatz netto Kalendertag im Vorjahr',
   ums_netto_af_kvj                    NUMBER(29,4)     COMMENT 'Aktionsfreier Netto Umsatz des Kalendertages des Vorjahres auf Ebene Markt / Tag_1',
   ums_netto_sa_kvj                    NUMBER(29,4)     COMMENT 'Sonderaktion Netto Umsatz des Kalendertages des Vorjahres auf Ebene Markt / Tag_1',
   ums_netto_kvvj                      NUMBER(29,4)     NOT NULL COMMENT 'Umsatz netto Kalendertag im Vor-Vorjahr',
   ums_netto_af_kvvj                   NUMBER(29,4)     COMMENT 'Aktionsfreier Netto Umsatz des Kalendertages des Vorvorjahres auf Ebene Markt / TAG_1',
   ums_netto_sa_kvvj                   NUMBER(29,4)     COMMENT 'Sonderaktion Netto Umsatz des Kalendertages des Vorvorjahres auf Ebene Markt / TAG_1',
   ums_netto_plan                      NUMBER(29,4)     NOT NULL COMMENT 'Umsatz netto Planwert',
   ums_netto_plan_extern               NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Umsatz netto Planwert extern',
   ums_brutto                          NUMBER(29,4)     NOT NULL COMMENT 'Umsatz brutto',
   ums_brutto_wvj                      NUMBER(29,4)     NOT NULL COMMENT 'Umsatz Betrag Brutto Wochentag im Vorjahr',
   ums_brutto_wvvj                     NUMBER(29,4)     NOT NULL COMMENT 'Umsatz brutto Wochentag im Vorvorjahr',
   ums_brutto_kvj                      NUMBER(29,4)     NOT NULL COMMENT 'Umsatz brutto Kalendertag im Vorjahr',
   ums_brutto_kvvj                     NUMBER(29,4)     NOT NULL COMMENT 'Umsatz brutto Kalendertag im Vor-Vorjahr',
   anz_kunde                           INTEGER     NOT NULL COMMENT 'Anzahl Kunden',
   anz_kunde_wvj                       INTEGER     NOT NULL COMMENT 'Anzahl Kunden Wochentag im Vorjahr',
   anz_kunde_kvj                       INTEGER     NOT NULL COMMENT 'Anzahl Kunden Kalendertag im Vorjahr',
   anz_offen                           INTEGER     NOT NULL COMMENT 'Anzahl Öffnungstage',
   anz_offen_wvj                       INTEGER     NOT NULL COMMENT 'Anzahl Öffnungstage Wochentag im Vorjahr',
   anz_offen_wvvj                      INTEGER     NOT NULL COMMENT 'Anzahl Öffnungstage Wochentag im Vor-Vorjahr',
   anz_offen_kvj                       INTEGER     NOT NULL COMMENT 'Anzahl Öffnungstage Kalendertag im Vorjahr',
   anz_offen_kvvj                      INTEGER     NOT NULL COMMENT 'Anzahl Öffnungstage Kalendertag im Vor-Vorjahr',
   menge_absatz                        NUMBER(29,3)     COMMENT 'Menge an verkauften Artikel_1 auf Ebene Markt / Tag_1',
   menge_absatz_af                     NUMBER(29,3)     COMMENT 'Menge an verkauften aktionsfreien Artikel_1 auf Ebene Markt / Tag_1',
   menge_absatz_sa                     NUMBER(29,3)     COMMENT 'Menge an verkauften Artikel_1 in Sonderaktion auf Ebene Markt / Tag_1',
   menge_absatz_wvj                    NUMBER(29,3)     COMMENT 'Menge an verkauften Artikel_1 des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag_1',
   menge_absatz_af_wvj                 NUMBER(29,3)     COMMENT 'Menge an verkauften aktionsfreien Artikel_1 des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag_1',
   menge_absatz_sa_wvj                 NUMBER(29,3)     COMMENT 'Menge an verkauften Artikel_1 in Sonderaktion des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag_1',
   menge_absatz_kvj                    NUMBER(29,3)     COMMENT 'Menge an verkauften Artikel_1 des Kalendertages des Vorjahres auf Ebene Markt / Tag_1',
   menge_absatz_af_kvj                 NUMBER(29,3)     COMMENT 'Menge an verkauften aktionsfreien Artikel_1 des Kalendertages des Vorjahres auf Ebene Markt / Tag_1',
   menge_absatz_sa_kvj                 NUMBER(29,3)     COMMENT 'Menge an verkauften Artikel_1 in Sonderaktion des Kalendertages des Vorjahres auf Ebene Markt / Tag_1',
   menge_absatz_ohne_pfand_plan        NUMBER(29,3)     COMMENT 'Geplante Menge an verkauften Artikel_1 ohne Pfandartikel auf Ebene Markt / Tag_1',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_VIS_TAG_UMSATZ_KUNDE_WUP PRIMARY KEY (mandant_id, dat, nb_id, wup_id, wrg_id) NOT ENFORCED
)  COMMENT = 'VIS - Aggregat auf Tagesebene - MULTISET - Beladung aus wup_plan_tag_1';
