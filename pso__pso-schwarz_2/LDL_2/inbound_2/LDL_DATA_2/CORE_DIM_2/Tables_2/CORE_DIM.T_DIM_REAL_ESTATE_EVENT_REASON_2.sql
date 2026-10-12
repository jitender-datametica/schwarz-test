/* --------------------------------------------------------------------------------
   DDL for table: t_dim_real_estate_event_reason_2
   generated from Powerdesigner on Dienstag, 28. Mai 2024 20:53:54
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_DIM.T_DIM_REAL_ESTATE_EVENT_REASON_2 (
   real_estate_event_reason_cd         VARCHAR(20)     NOT NULL COMMENT 'The code identifying the reason why the status_2 of a real estate object has changed. E.g. a store was closed because of lack of expansion options.',
   real_estate_event_reason_descr      VARCHAR(250)    NOT NULL COMMENT 'A textual description for the reason why the status_2 of a real estate object has changed. E.g. a store was closed because of lack of expansion options. (Description in group language, i.e. in German)',
   real_estate_event_reason_descr_de   VARCHAR(250)    COMMENT 'A textual description for the reason why the status_2 of a real estate object has changed. E.g. a store was closed because of lack of expansion options. (Description in German)',
   real_estate_event_reason_descr_en   VARCHAR(250)    COMMENT 'A textual description for the reason why the status_2 of a real estate object has changed. E.g. a store was closed because of lack of expansion options. (Description in English)',
   real_estate_event_type_cd           VARCHAR(20)     NOT NULL COMMENT 'The code identifying the kind of event which changes the status_2 of a real estate object, such as opening, closing or relocation.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_REAL_ESTATE_EVENT_REASON PRIMARY KEY (real_estate_event_reason_cd) NOT ENFORCED
)  COMMENT= 'This minor dimension defines the reason why the status_2 of a real estate object has changed. E.g. a store was closed because of lack of expansion options.';
