--==============================================================
-- Table: in_l_einkaeufer_int_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_l_einkaeufer_int_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_L_EINKAEUFER_INT_1 (
   einkaeufer_int_id                   VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'ID des internationalen Einkäufers aus dem SAP-Klassensystem, z.Bsp I14',
   einkaeufer_int_name                 VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Name des internationalen Einkäufers',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_L_EINKAEUFER_INT PRIMARY KEY (einkaeufer_int_id) NOT ENFORCED
)  COMMENT = 'BIS - internationaler Einkäufer aus dem SAP Klassensystem. Dem Lieferanten zugeordneter internationaler Einkäufer';
