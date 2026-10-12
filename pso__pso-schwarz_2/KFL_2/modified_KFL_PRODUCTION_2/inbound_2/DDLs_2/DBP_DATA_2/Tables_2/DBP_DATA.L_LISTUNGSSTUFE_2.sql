--==============================================================
-- Table: l_listungsstufe_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_listungsstufe_2
   generated from Powerdesigner on Montag, 26. Februar 2024 17:46:30
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_LISTUNGSSTUFE_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   listungsstufe_kz                    VARCHAR(50)      NOT NULL COMMENT 'Kennzeichen der Listungsstufe.',
   listungsstufe_bez                   VARCHAR(200)     NOT NULL COMMENT 'Bezeichnung der Listungsstufe.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_LISTUNGSSTUFE PRIMARY KEY (mandant_id, listungsstufe_kz) NOT ENFORCED
)  COMMENT = 'Tabelle für verschiedene Listungsstufen. Eine_2 Listungsstufe ist eine_2 Eingruppierung jedes einzelnen Artikels.';
