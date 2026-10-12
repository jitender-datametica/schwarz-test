--==============================================================
-- Table: nl_listung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: nl_listung_1
   generated from Powerdesigner on Freitag, 8. Oktober 2021 10:44:41
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.nl_listung_1  CLUSTER BY (
      listung_art,
      sm_id_selected,
      kjwo_update
 )(
   nl_listung_id                       NUMBER(38,0)    NOT NULL DEFAULT 0 COMMENT 'Automatischer generierter Schluessel',
   mandant_id                          NUMBER(38,0)    DEFAULT 1 NOT NULL COMMENT 'Mandant_1 im DWH',
   listung_art                         VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'Vorschlagswert bezueglich Listung aus Stored Procedure (z.B. Listung erweitern)',
   sm_id_selected                      NUMBER(38,0)    NOT NULL COMMENT 'Sortimentsmodul ID. Es gibt 5 Sortimentsstufen, von 1 bis 5. -1: keine Sortimentsstufe zugeordnet',
   sm_id                               NUMBER(38,0)    NOT NULL COMMENT 'Sortimentsmodul ID',
   gtin                                VARCHAR(300)    COLLATE 'en-ci' NOT NULL COMMENT 'Global Trade Item_1 Number (GTIN)',
   ost_basis                           VARCHAR(1)      COLLATE 'en-ci' NOT NULL COMMENT 'Listungsinformation abgeleitet aus SAL (Sternchenlogik)',
   ost_gross                           VARCHAR(1)      COLLATE 'en-ci' NOT NULL COMMENT 'Listungsinformation abgeleitet aus SAL (Sternchenlogik)',
   sued_ost                            VARCHAR(1)      COLLATE 'en-ci' NOT NULL COMMENT 'Listungsinformation abgeleitet aus SAL (Sternchenlogik)',
   sued_west                           VARCHAR(1)      COLLATE 'en-ci' NOT NULL COMMENT 'Listungsinformation abgeleitet aus SAL (Sternchenlogik)',
   west                                VARCHAR(1)      COLLATE 'en-ci' NOT NULL COMMENT 'Listungsinformation abgeleitet aus SAL (Sternchenlogik)',
   nord                                VARCHAR(1)      COLLATE 'en-ci' NOT NULL COMMENT 'Listungsinformation abgeleitet aus SAL (Sternchenlogik)',
   kl_owg_id                           NUMBER(38,0)    COMMENT 'ID Kaufland Oberwarengruppe fuer Nielsen-Daten (Vergabe im Beladeprozess)',
   wg_id                               NUMBER(38,0)    NOT NULL COMMENT 'ID der Warengruppe',
   art_nielsen_bez                     VARCHAR(500)    COLLATE 'en-ci' COMMENT 'Artikelbezeichnung aus Nielsen ',
   umsatz_artikel                      NUMBER(18,4)    COMMENT 'Gesamtumsatz',
   durchschnitt_anz_maerkte            NUMBER(38,0)    COMMENT 'Durschnittliche Anzahl Maerkte (Nielsen Daten)',
   durchschnitt_preis                  NUMBER(18,4)    COMMENT 'Durchschnittlicher VK_1 (Wenn umsatz_brutto_af>0 Dann umsatz_brutto_af/menge_af Sonst umsatz_brutto_sa/menge_sa)',
   anz_wochen                          NUMBER(38,0)    COMMENT 'Anzahl Wochen',
   anz_maerkte                         NUMBER(38,0)    COMMENT 'Anzahl gelistete Maerkte  (wird im ETL-Prozess ermittelt)',
   umsatz_hr                           NUMBER(18,4)    COMMENT 'Hochrechnung Umsatz (stored Procedure zur Laufzeit der Ermittlung)',
   absatz_hr                           NUMBER(18,4)    COMMENT 'Hochrechnung Absatz (stored Procedure zur Laufzeit der Ermittlung)',
   kjwo_update                         NUMBER(38,0)    COMMENT 'Kalenderjahreswoche. Format JJJJWW',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'EK-INT -  Sortimentstool - Tabelle fuer Zwischenablage der Hochrechnungsergebnisse Nielsen-Artikel_1';