CREATE TABLE CORE_REL.T_NFPO_ITEM_FAMILY_GROUP_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_fam_grp_sid               NUMBER(38,0)     NOT NULL,
   nfpo_item_fam_grp_nr                VARCHAR(100),
   nfpo_item_fam_grp_name              VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_FAMILY_GROUP PRIMARY KEY (nfpo_item_fam_grp_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. FAMG; 2. Ebene der Artikelhierarchie. Direkt oberhalb des Artikels;';
