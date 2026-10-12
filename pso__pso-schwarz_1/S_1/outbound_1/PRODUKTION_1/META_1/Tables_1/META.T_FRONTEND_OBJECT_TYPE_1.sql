--==============================================================
-- Table: T_FRONTEND_OBJECT_TYPE_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_FRONTEND_OBJECT_TYPE_1
   generated from Powerdesigner on Montag, 7. November 2022 10:16:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_meta.t_frontend_object_type_1 (
frontend_obj_type_cd STRING(50) NOT NULL OPTIONS(description='The code identifying the kind of frontend object.'),
frontend_obj_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the kind of frontend object.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (frontend_obj_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the kind frontend object. E.g. for Microstrategy it distinguishes between reports, cubes, documents and dossiers.');