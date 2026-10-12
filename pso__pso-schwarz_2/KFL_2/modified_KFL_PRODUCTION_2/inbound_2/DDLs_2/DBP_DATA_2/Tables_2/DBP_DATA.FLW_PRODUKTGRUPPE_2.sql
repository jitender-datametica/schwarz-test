--==============================================================
-- Table: flw_produktgruppe_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_produktgruppe_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_PRODUKTGRUPPE_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   produktgruppe_id                    VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Produktguppe Id aus prodgr',
   hauptgruppe_id                      VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Hauptgruppe = oberste Hierarchiestufe der Fleischwerk- Produkthierarchie. Entspricht der Tierart',
   system_id                           INTEGER     COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_PRODUKTGRUPPE PRIMARY KEY (mandant_id, produktgruppe_id) NOT ENFORCED
)  COMMENT = 'FLW - Produktgruppen sind eine_2 Gruppierung von Produkthierarchien beliebiger Stufe aus zfw_prodgr';

