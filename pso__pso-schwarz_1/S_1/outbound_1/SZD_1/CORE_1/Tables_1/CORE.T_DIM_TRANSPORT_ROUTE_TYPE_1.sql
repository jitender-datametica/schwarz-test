/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_TRANSPORT_ROUTE_TYPE_1
   generated from Powerdesigner on Montag, 22. April 2024 11:13:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_transport_route_type_1 (
transport_route_type_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - Type of transport that is used deliver the goods from harbor EU to OWIM warehouse'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (transport_route_type_cd) NOT ENFORCED
) OPTIONS(description='Minor Dimension - Type of transport that is used deliver the goods. - Source - VMT');