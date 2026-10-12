/*
    CREATE T_SRG_VC_PK_SID_1 - SURROGATE TABLE FOR UNIQUE PK_SID
*/

CREATE TABLE transfer.t_srg_vc_pk_sid_1
(
	vc_pk_sid             NUMBER(38,0) AUTOINCREMENT START 1 INCREMENT 1 ORDER COMMENT 'The unique identifier (surrogate key) for a particular value cube record.'
    , granularity_lvl     VARCHAR(100)               COMMENT 'The set or combination of attributes defining the granularity level for a value cube record.'
    , vc_pk_cd            OBJECT NOT NULL            COMMENT 'The primary key code identifier containing the values of corresponding granularity level attributes for a value cube record.'
	, vc_ref_dt 		  OBJECT					 COMMENT 'The reference date for a particular value cube record, based on the dataset associated busines process'
    , vc_fk_attr_cd       OBJECT                     COMMENT 'The foreign key code reference to additional dimensions for a particular value cube record.'
    , vc_master_data_cd   OBJECT                     COMMENT 'Reference to additional master data dimensions (e.g. product variant dimensions) for a particular value cube record'
	, tmsp_insert         TIMESTAMP_LTZ(9)           COMMENT 'The point in time when this record was created in the data warehouse.'
	, tmsp_update         TIMESTAMP_LTZ(9)           COMMENT 'The point in time when this record was last updated.'
	, src_table_name 	  VARCHAR(250)				 COMMENT 'The source table behind the latest update of the record'
    , CONSTRAINT pk_t_srg_vc_pk_sid PRIMARY KEY ( vc_pk_cd ) NOT ENFORCED
) COMMENT = 'The surrogate table holding information about the value cube records, their different granularity levels and their corresponding additional attributes relationships.'
;