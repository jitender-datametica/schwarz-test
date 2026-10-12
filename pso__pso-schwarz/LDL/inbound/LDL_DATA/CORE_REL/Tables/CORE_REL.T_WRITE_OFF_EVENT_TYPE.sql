/* --------------------------------------------------------------------------------
   DDL for table: t_write_off_event_type
   generated from Powerdesigner on Dienstag, 22. Oktober 2024 13:38:38
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_WRITE_OFF_EVENT_TYPE (
   write_off_event_type_id             NUMBER(38, 0)   NOT NULL COMMENT 'The code identifying the type of write off event. (There are write offs for stores and write offs for warehouses.)',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   write_off_event_type_descr          VARCHAR(250)    NOT NULL COMMENT 'A textual description for the kind of write off events.',
   correction_fg                       BOOLEAN         NOT NULL COMMENT 'An indicator showing, if this write off event type defines a correction booking.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_WRITE_OFF_EVENT_TYPE PRIMARY KEY (write_off_event_type_id, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the types of write off events. There are write offs for stores and write offs for warehouses.';
