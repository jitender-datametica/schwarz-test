--==============================================================
-- Table: l_konditionsgruppe_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_konditionsgruppe_1
   generated from Powerdesigner on Freitag, 27. Oktober 2023 13:37:00
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_KONDITIONSGRUPPE_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   konditionsgruppe_id                 VARCHAR(10)      NOT NULL COMMENT 'Eindeutiger Schlüssel der Konditionsgruppen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_KONDITIONSGRUPPE PRIMARY KEY (mandant_id, konditionsgruppe_id) NOT ENFORCED
)  COMMENT = 'RPW - Lookuptabelle für die Gruppierung der Konditionsarten. Diese Tabelle wird per Initialisierung befüllt.';
