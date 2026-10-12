--==============================================================
-- Table: art_backshop
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_backshop
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_BACKSHOP (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   bestell_art_id                      INTEGER     NOT NULL COMMENT 'Bestellartikel = ein Artikel der WG 291, der nicht verkauft wird, sondern lediglich zur Produktion eines anderen Artikels dient. Referenz zur Tabelle art',
   inhalt_menge                        NUMBER(29,3)      COMMENT 'Menge des Artkels in Stück',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_BACKSHOP PRIMARY KEY (mandant_id, bestell_art_id) NOT ENFORCED
)  COMMENT = 'VIS Backshop - Backshop Bestellartikel aus der Warengruppe 291. Quelle ist SAP Klassenbibliothek';

