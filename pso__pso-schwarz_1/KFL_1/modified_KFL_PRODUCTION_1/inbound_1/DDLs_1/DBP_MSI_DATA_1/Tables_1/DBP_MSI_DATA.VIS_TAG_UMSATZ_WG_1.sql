--==============================================================
-- Table: vis_tag_umsatz_wg_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vis_tag_umsatz_wg_1
   generated from Powerdesigner on Dienstag, 8. April 2025 18:46:21
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.VIS_TAG_UMSATZ_WG_1 CLUSTER BY (
     MANDANT_ID,
     DAT 
) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   dat                                 DATE             NOT NULL COMMENT 'Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM_1-DD',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wup_id                              INTEGER     NOT NULL COMMENT 'Nummer des Warenumschlagsplatzes',
   wg_id                               INTEGER     NOT NULL COMMENT 'ID der Warengruppe',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   abt_id                              INTEGER     NOT NULL COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen',
   gj                                  INTEGER     NOT NULL COMMENT 'Geschäftsjahr',
   kjmo                                INTEGER     NOT NULL COMMENT 'Kalenderjahremonat, Format JJJJMM',
   kjwo                                INTEGER     NOT NULL COMMENT 'Kalenderjahreswoche, Format JJJJWW',
   wtag_id                             INTEGER     NOT NULL COMMENT 'Wochentag ID',
   ums_netto                           NUMBER(29,4)     NOT NULL COMMENT 'Umsatz netto',
   ums_netto_af                        NUMBER(29,4)     COMMENT 'Aktionsfreier Netto Umsatz auf Ebene Markt / TAG_1 / Warengruppe',
   ums_netto_sa                        NUMBER(29,4)     COMMENT 'Sonderaktion Netto Umsatz auf Ebene Markt / TAG_1 / Warengruppe',
   ums_netto_wvj                       NUMBER(29,4)     NOT NULL COMMENT 'Umsatz netto Wochentag im Vorjahr',
   ums_netto_af_wvj                    NUMBER(29,4)     COMMENT 'Aktionsfreier Netto Umsatz des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_1 / Warengruppe',
   ums_netto_sa_wvj                    NUMBER(29,4)     COMMENT 'Sonderaktion Netto Umsatz des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_1 / Warengruppe',
   ums_netto_wvvj                      NUMBER(29,4)     NOT NULL COMMENT 'Umsatz netto Wochentag im Vorvorjahr',
   ums_netto_af_wvvj                   NUMBER(29,4)     COMMENT 'Aktionsfreier Netto Umsatz des vergleichbaren Wochentages des Vorvorjahres auf Ebene Markt / TAG_1 / Warengruppe',
   ums_netto_sa_wvvj                   NUMBER(29,4)     COMMENT 'Sonderaktion Netto Umsatz des vergleichbaren Wochentages des Vorvorjahres auf Ebene Markt / TAG_1 / Warengruppe',
   ums_netto_kvj                       NUMBER(29,4)     NOT NULL COMMENT 'Umsatz netto Kalendertag im Vorjahr',
   ums_netto_af_kvj                    NUMBER(29,4)     COMMENT 'Aktionsfreier Netto Umsatz des Kalendertages des Vorjahres auf Ebene Markt / TAG_1 / Warengruppe',
   ums_netto_sa_kvj                    NUMBER(29,4)     COMMENT 'Sonderaktion Netto Umsatz des Kalendertages des Vorjahres auf Ebene Markt / TAG_1 / Warengruppe',
   ums_netto_kvvj                      NUMBER(29,4)     NOT NULL COMMENT 'Umsatz netto Kalendertag im Vor-Vorjahr',
   ums_netto_af_kvvj                   NUMBER(29,4)     COMMENT 'Aktionsfreier Netto Umsatz des Kalendertages des Vorvorjahres auf Ebene Markt / TAG_1 / Warengruppe',
   ums_netto_sa_kvvj                   NUMBER(29,4)     COMMENT 'Sonderaktion Netto Umsatz des Kalendertages des Vorvorjahres auf Ebene Markt / TAG_1 / Warengruppe',
   ums_brutto                          NUMBER(29,4)     NOT NULL COMMENT 'Umsatz brutto',
   ums_brutto_kvj                      NUMBER(29,4)     NOT NULL COMMENT 'Umsatz brutto Kalendertag im Vorjahr',
   ums_brutto_wvj                      NUMBER(29,4)     NOT NULL COMMENT 'Umsatz Betrag Brutto Wochentag im Vorjahr',
   menge_absatz                        NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Menge in Basismengeneinheit. Stück und Gewichtsartikel gemischt',
   menge_absatz_af                     NUMBER(29,3)     COMMENT 'Menge an verkauften aktionsfreien Artikel_1 auf Ebene Markt / TAG_1 / Warengruppe',
   menge_absatz_sa                     NUMBER(29,3)     COMMENT 'Menge an verkauften Artikel_1 in Sonderaktion auf Ebene Markt / TAG_1 / Warengruppe',
   menge_absatz_kvj                    NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Menge Kalendertag im Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt',
   menge_absatz_af_kvj                 NUMBER(29,3)     COMMENT 'Menge an verkauften aktionsfreien Artikel_1 des Kalendertages des Vorjahres auf Ebene Markt / TAG_1 / Warengruppe',
   menge_absatz_sa_kvj                 NUMBER(29,3)     COMMENT 'Menge an verkauften Artikel_1 in Sonderaktion des Kalendertages des Vorjahres auf Ebene Markt / TAG_1 / Warengruppe',
   menge_absatz_wvj                    NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Menge Wochentag im Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt',
   menge_absatz_af_wvj                 NUMBER(29,3)     COMMENT 'Menge an verkauften aktionsfreien Artikel_1 des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_1 / Warengruppe',
   menge_absatz_sa_wvj                 NUMBER(29,3)     COMMENT 'Menge an verkauften Artikel_1 in Sonderaktion des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_1 / Warengruppe',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_VIS_TAG_UMSATZ_WG PRIMARY KEY (mandant_id, dat, nb_id, wup_id, wg_id, arthiertyp_id, wrg_id) NOT ENFORCED
)  COMMENT = 'VIS - Aggregat auf Tagesebene';
