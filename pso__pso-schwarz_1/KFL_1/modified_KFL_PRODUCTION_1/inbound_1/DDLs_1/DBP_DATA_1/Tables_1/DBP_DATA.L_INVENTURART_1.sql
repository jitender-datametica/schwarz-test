--==============================================================
-- Table: l_inventurart_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_inventurart_1
   generated from Powerdesigner on Dienstag, 30. April 2024 18:15:11
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_INVENTURART_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   inventurart_id                      INTEGER     NOT NULL COMMENT 'ID der Inventurart (international nicht identisch)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_INVENTURART PRIMARY KEY (mandant_id, inventurart_id) NOT ENFORCED
)  COMMENT = 'Lookup-Tabelle der Inventurarten.';
