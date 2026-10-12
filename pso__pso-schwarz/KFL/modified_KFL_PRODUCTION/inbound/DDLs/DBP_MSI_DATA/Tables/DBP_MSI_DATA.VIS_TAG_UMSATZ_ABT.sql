--==============================================================
-- Table: vis_tag_umsatz_abt
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vis_tag_umsatz_abt
   generated from Powerdesigner on Freitag, 16. Mai 2025 16:06:32
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.VIS_TAG_UMSATZ_ABT CLUSTER BY (
     MANDANT_ID,
     DAT 
) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   dat                                 DATE             NOT NULL COMMENT 'Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM-DD',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wup_id                              INTEGER     NOT NULL COMMENT 'Nummer des Warenumschlagsplatzes',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   abt_id                              INTEGER     NOT NULL COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen',
   kjmo                                INTEGER     NOT NULL COMMENT 'Kalenderjahremonat, Format JJJJMM',
   kjwo                                INTEGER     NOT NULL COMMENT 'Kalenderjahreswoche, Format JJJJWW',
   ums_netto                           NUMBER(29,2)     NOT NULL COMMENT 'Umsatz netto',
   ums_netto_wvj                       NUMBER(29,2)     NOT NULL COMMENT 'Umsatz netto Wochentag im Vorjahr',
   ums_netto_wvvj                      NUMBER(29,2)     NOT NULL COMMENT 'Umsatz netto Wochentag im Vorvorjahr',
   ums_netto_kvj                       NUMBER(29,2)     NOT NULL COMMENT 'Umsatz netto Kalendertag im Vorjahr',
   ums_netto_kvvj                      NUMBER(29,2)     NOT NULL COMMENT 'Umsatz netto Kalendertag im Vor-Vorjahr',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_VIS_TAG_UMSATZ_ABT PRIMARY KEY (mandant_id, dat, nb_id, wup_id, arthiertyp_id, wrg_id, abt_id) NOT ENFORCED
)  COMMENT = 'VIS - Aggregat auf Tagesebene - MULTISET';
