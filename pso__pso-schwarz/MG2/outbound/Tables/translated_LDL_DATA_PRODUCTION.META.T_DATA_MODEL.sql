CREATE OR REPLACE TABLE ldl_data_production_meta.t_data_model (
data_model_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the data model.'),
data_model_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the subtype discriminator for data models. It distinguishes between logical models and physical models.'),
data_model_name STRING(100) NOT NULL
OPTIONS(description='The name that has been assigned to the model. (This is not necessarily the file name of the model file.)'),
data_model_descr STRING(250) OPTIONS(description='A textual description of the content and purpose of the data model.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (data_model_sid) NOT ENFORCED
)
OPTIONS(description='A data model is an abstract representation of data structures, showing their purpose and the way how they are related with each other. A data model is the blueprint for the implementation.');