--==============================================================
-- Table: l_saison
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_saison
   generated from Powerdesigner on Montag, 14. März 2022 11:18:08
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_SAISON (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant im DWH',
   saison_id                           VARCHAR(10)     COLLATE 'en-ci' NOT NULL COMMENT 'ID der Saison aus saiso, z.Bsp 9',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_SAISON PRIMARY KEY (mandant_id, saison_id) NOT ENFORCED
)  COMMENT = 'AIS_KMO - Lookuptabelle der Saisonkennzeichen aus der SAP Tabelle T6WSP';