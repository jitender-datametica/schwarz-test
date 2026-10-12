--==============================================================
-- Table: t_resource_item_key
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_resource_item_key
   generated from Powerdesigner on Montag, 25. März. September 2023 16:40:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_meta.t_resource_item_key (
resource_item_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the Resource Item.'),
resource_item_key_type_cd STRING(100) NOT NULL
OPTIONS(description='The code for the type of natural key which identifies the Resource Item.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
nat_key_comp_nr STRING(100) NOT NULL
OPTIONS(description='The natural key which identifies the Resource Item. In case the natural key consist of several columns, all components get concatenated.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
PRIMARY KEY (resource_item_key_type_cd, dwh_valid_from_tmsp, nat_key_comp_nr) NOT ENFORCED
)
OPTIONS(description='Key table for the Resource Item key space. A surrogate key is identified by one or several natural keys. The kind of natural key is defined by the key type code. In case the natural key consists of several columns, all components get concatenated using a separator character. The association between a natural key and its surrogate key can change over time, e.g. because of a re-numbering in the source. That is why the key table is historized.');