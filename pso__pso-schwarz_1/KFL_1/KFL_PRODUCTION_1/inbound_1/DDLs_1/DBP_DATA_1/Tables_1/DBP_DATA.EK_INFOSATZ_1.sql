--==============================================================
-- Table: ek_infosatz_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ek_infosatz_1
   generated from Powerdesigner on Freitag, 28. März 2025 12:20:10
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EK_INFOSATZ_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   ek_infosatz_id                      NUMBER(18,0)     NOT NULL COMMENT 'Nummer des Infosatzes. Zusammen mit mandant_id eindeutiger Schluessel',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT ' Artikel_1 - Id',
   gp_id                               NUMBER(38,0)     NOT NULL COMMENT 'Geschaeftspartner - ID (Lieferanten - ID)',
   crossdocking_id                     NUMBER(38,0)     COMMENT 'ID des Umschlagplatzs bzw. Cross Docking Orts.',
   einkaufsorganisation_id             NUMBER(38,0)     NOT NULL COMMENT 'Fuer verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen',
   dat_erstellung                      DATE             NOT NULL COMMENT 'Erstelldatum Infosatz. Bei mehreren Treffern gilt der Satz mit dem aktuellsten Datum',
   gp_art_id                           VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Lieferanten-Artikelnummer',
   dat_von                             DATE             NOT NULL COMMENT 'Lieferbar / gueltig-ab',
   dat_bis                             DATE             NOT NULL COMMENT 'Lieferbar / gueltig-bis',
   regel_gp_fg                         NUMBER(38,0)     NOT NULL COMMENT 'Flag für Regellieferanten',
   loesch_fg                           NUMBER(38,0)     NOT NULL COMMENT 'Flag geloescht',
   gp_teilsortiment_id                 VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Teilsortiment aus SAP ltsnr',
   konditionsgruppe_id                 VARCHAR(10)      COMMENT 'Eindeutiger Schluessel der Konditionsgruppen beim Lieferanten.',
   menge_einh_id                       VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Bestellmengeneinheit - nur gefüllt für DE (EINA_1 PR1), leer für KMO',
   apollo_ian                          VARCHAR(35)      COMMENT 'EN long: Apollo Suppl - IANEN short: APO. S-IAN DE long: Apollo Lft - IANDE short: APO. L-IANTA Dynpro DE:Apollo Lft-IANTA Dynpro EN:Apollo Supp-IAN',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EK_INFOSATZ PRIMARY KEY (mandant_id, ek_infosatz_id) NOT ENFORCED
)  COMMENT = 'AIS_KMO- Artikel_1-Lieferantenzuordnung aus der SAP-Tabelle EINA. Wird im DWH vorlaeufig nur für KMO genutzt';
