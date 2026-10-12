--==============================================================
-- Table: ts_lin_gf_org_ebene_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_lin_gf_org_ebene_zu_1
   generated from Powerdesigner on Dienstag, 20. Juli 2021 16:46:34
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.ts_lin_gf_org_ebene_zu_1 (
   USER_ID                             VARCHAR(30) NOT NULL COLLATE 'en-ci' COMMENT 'LDAP / Benutzerkennung',
   hr_objekt_ebene2_id                 NUMBER(18,0)    COMMENT 'ID zur Organisationseinheit auf Ebene 2',
   hr_objekt_ebene3_id                 NUMBER(18,0)    COMMENT 'ID zur Organisationseinheit auf Ebene 3',
   hr_objekt_ebene4_id                 NUMBER(18,0)    COMMENT 'ID zur Organisationseinheit auf Ebene 4'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Tabelle fuer Transaction-Service: Zuordnung GF_1 zu Organisationshierarchie-Ebene';