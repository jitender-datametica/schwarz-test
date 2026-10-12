--==============================================================
-- Table: vis_monat_umsatz_wg_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vis_monat_umsatz_wg_2
   generated from Powerdesigner on Freitag, 16. Mai 2025 15:56:31
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Nummer des Warenumschlagsplatzes',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   kjmo                                INTEGER     NOT NULL COMMENT 'Kalenderjahremonat, Format JJJJMM',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   wg_id                               INTEGER     NOT NULL COMMENT 'ID der Warengruppe',
   abt_id                              INTEGER     NOT NULL COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen',
   gj                                  INTEGER     NOT NULL COMMENT 'Geschäftsjahr',
   ums_netto                           NUMBER(29,2)     NOT NULL COMMENT 'Umsatz netto',
   ums_netto_kvj                       NUMBER(29,2)     NOT NULL COMMENT 'Umsatz netto Kalendertag im Vorjahr',
   ums_netto_kvvj                      NUMBER(29,2)     NOT NULL COMMENT 'Umsatz netto Kalendertag im Vor-Vorjahr',
   ums_netto_plan                      NUMBER(29,2)     NOT NULL COMMENT 'Umsatz netto Planwert',
   ums_brutto                          NUMBER(29,2)     NOT NULL COMMENT 'Umsatz brutto',
   ums_brutto_kvj                      NUMBER(29,2)     NOT NULL COMMENT 'Umsatz brutto Kalendertag im Vorjahr',
   menge_absatz                        NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Menge in Basismengeneinheit. Stück und Gewichtsartikel gemischt',
   menge_absatz_kvj                    NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Menge Kalendertag im Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt',
   menge_absatz_kvvj                   NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Menge Kalendertag im Vor-Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_VIS_MONAT_UMSATZ_WG PRIMARY KEY (mandant_id, wup_id, nb_id, wrg_id, kjmo, arthiertyp_id, wg_id) NOT ENFORCED
)  COMMENT = 'VIS - Aggregat auf Monatsebene - MULTISET';
