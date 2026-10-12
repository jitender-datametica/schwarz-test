/* --------------------------------------------------------------------------------
   DDL for table: T_TRANSPORT_ROUTE_TYPE_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_transport_route_type_2 (
transport_route_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the transport route type.'),
transport_route_type_descr STRING(250) OPTIONS(description='A brief description of the transport route type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (transport_route_type_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - Defines the types of routes for specific transport of goods.             Wholesale uses BEFORE_IMPORT for its international transportation and AFTER_IMPORT for domestic transport at importing country.             Foreign trade uses BEFORE_IMPORT only for transportation to the importing country. - Source - Manual');