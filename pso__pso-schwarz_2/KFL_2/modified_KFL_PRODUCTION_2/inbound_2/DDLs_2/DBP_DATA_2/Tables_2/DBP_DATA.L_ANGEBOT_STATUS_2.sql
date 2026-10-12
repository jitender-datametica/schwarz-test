--==============================================================
-- Table: l_angebot_status_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_angebot_status_2
   generated from Powerdesigner on Dienstag, 21. Januar 2025 11:49:23
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_ANGEBOT_STATUS_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   angebot_status_id                   INTEGER     NOT NULL COMMENT 'ID des Angebotstatus',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_ANGEBOT_STATUS PRIMARY KEY (mandant_id, angebot_status_id) NOT ENFORCED
)  COMMENT = 'Lookuptabelle der möglichen Status_2 des Angebots.';
