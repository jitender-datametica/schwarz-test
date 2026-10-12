/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CONTAINER_PACKING_PLACE_1
   generated from Powerdesigner on Montag, 22. April 2024 11:13:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_container_packing_place_1 (
container_packing_place_cd STRING(100) NOT NULL
OPTIONS(description='Natural Key/Business Key - Information where the container stuffing is taken place '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (container_packing_place_cd) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - Table contains the information where the container stuffing is taken place ( at the factory or at an export warehouse (CFS / IC) in Asia ). - Source - VMT');