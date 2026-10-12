CREATE TABLE core_dim.T_DIM_REAL_ESTATE_USAGE_TYPE_2 (
   real_estate_usg_type_cd             VARCHAR(20)     NOT NULL COMMENT 'The code for the way, how a real estate object is used. An object may be used by the organization or by a third party.',
   real_estate_usg_type_descr          VARCHAR(250)    NOT NULL COMMENT 'A textual description for the way, how a real estate object is used. An object may be used by the organization or by a third party. (Description in group language, i.e. in German)',
   real_estate_usg_type_descr_de       VARCHAR(250)    COMMENT 'A textual description for the way, how a real estate object is used. An object may be used by the organization or by a third party. (Description in German)',
   real_estate_usg_type_descr_en       VARCHAR(250)    COMMENT 'A textual description for the way, how a real estate object is used. An object may be used by the organization or by a third party. (Description in English)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_REAL_ESTATE_USAGE_TYPE PRIMARY KEY (real_estate_usg_type_cd) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the way, how a real estate object is used. An object may be used by the organization or by a third party.';
