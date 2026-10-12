/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_TRANSPORT_MODE_TYPE_2
   GENERATED FROM POWERDESIGNER ON Freitag, 21. Februar 2025 15:54:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_transport_mode_type_2 (
transport_mode_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of the transportation mode used. Example: ZTRK.'),
transport_mode_type_descr STRING(250) NOT NULL
OPTIONS(description='The description for the type of the transportation mode used. Example: Container, 	Truck Czech Republic Street'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (transport_mode_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension describes the type of the transportation mode used. It indicates whether it is a container, trailer, ship, airplane, truck etc.');