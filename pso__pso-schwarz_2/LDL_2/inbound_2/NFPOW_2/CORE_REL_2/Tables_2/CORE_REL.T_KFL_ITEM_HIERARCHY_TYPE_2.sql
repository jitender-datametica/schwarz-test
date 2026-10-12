/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_item_hierarchy_type_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_ITEM_HIERARCHY_TYPE_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_item_hier_type_id               NUMBER(38,0)     NOT NULL COMMENT 'identifier of the item_2 hierarchy_2 type in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.ARTHIERTYP.ARTHIERTYP_ID',
   kfl_item_hier_type_descr            VARCHAR(250)     COMMENT 'name of the item_2 hierarchy_2 type in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.ARTHIERTYP.ARTHIERTYP_BEZ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_ITEM_HIERARCHY_TYPE PRIMARY KEY (kfl_item_hier_type_id) NOT ENFORCED 
)  COMMENT = 'Kaufland item_2 hierarchy_2 type
             KFL: DBP_DATA.ARTHIERTYP_2';

