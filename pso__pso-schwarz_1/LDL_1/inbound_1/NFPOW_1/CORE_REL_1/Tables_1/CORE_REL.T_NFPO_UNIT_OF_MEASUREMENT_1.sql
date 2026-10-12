CREATE TABLE CORE_REL.T_NFPO_UNIT_OF_MEASUREMENT_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_uom_sid                        NUMBER(38,0)     NOT NULL,
   nfpo_uom_nr                         VARCHAR(100),
   nfpo_uom_name                       VARCHAR(100),
   nfpo_uom_cd                         VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_UNIT_OF_MEASUREMENT PRIMARY KEY (nfpo_uom_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. UOFM; Masseinheiten; 
             SAP-Retail-Tabelle: t006_1 & t006a;
             SAP-BW: t_bw_z_ds_t006 & t_bw_z_ds_t006a;
             ELWIS: t_s_uom;
             WAWI: ';
