--==============================================================
-- Table: amx_l_system
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_l_system
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_L_SYSTEM (
   amx_system_id                       INTEGER     NOT NULL COMMENT 'Amx System ID zur unterscheidung der verschiedenen AMX Systeme',
   amx_system_bez                      VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Bezeichnung der unterschiedlichen AMX Systeme',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_L_SYSTEM PRIMARY KEY (amx_system_id) NOT ENFORCED
)  COMMENT = 'Lookup Tabelle für die unterschiedlichen AMX Quellsysteme.
             ';

