--==============================================================
-- Table: art_backshop_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_backshop_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_BACKSHOP_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   bestell_art_id                      NUMBER(38,0)     NOT NULL COMMENT 'Bestellartikel = ein Artikel_2 der WG 291, der nicht verkauft wird, sondern lediglich zur Produktion eines anderen Artikels dient. Referenz zur Tabelle art_2',
   inhalt_menge                        NUMBER(9,3)      COMMENT 'Menge des Artkels in Stück',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_BACKSHOP PRIMARY KEY (mandant_id, bestell_art_id) NOT ENFORCED
)  COMMENT = 'VIS Backshop - Backshop Bestellartikel aus der Warengruppe 291. Quelle ist SAP Klassenbibliothek';

