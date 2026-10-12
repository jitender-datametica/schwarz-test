--==============================================================
-- Table: in_l_einkaeufer_bis_int_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_l_einkaeufer_bis_int_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_L_EINKAEUFER_BIS_INT_1 (
   einkaeufer_bis_int_id               VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'ID des internationalen Einkäufers aus dem SAP-Klassensystem, z.Bsp. I07',
   einkaeufer_bis_int_name             VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Name des internationalen Einkäufers',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_L_EINKAEUFER_BIS_INT PRIMARY KEY (einkaeufer_bis_int_id) NOT ENFORCED
)  COMMENT = 'BIS - internationaler Einkäufer aus dem SAP Klassensystem. Dem Artikel_1 zugeordneter internationaler Einkäufer';
