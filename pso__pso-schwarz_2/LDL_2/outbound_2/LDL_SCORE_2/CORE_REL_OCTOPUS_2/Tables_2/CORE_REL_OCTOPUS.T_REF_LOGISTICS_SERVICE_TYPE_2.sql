CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_ref_logistics_service_type_2 (
logistics_service_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of the logistics service, e.g. short-time storage.'),
logistics_service_type_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the logistics_service_type_cd written out in group language (German).'),
logistics_service_type_descr_de STRING(100)
OPTIONS(description='A textual description for the logistics_service_type_cd written out in German.'),
logistics_service_type_descr_en STRING(100)
OPTIONS(description='A textual description for the logistics_service_type_cd written out in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (logistics_service_type_cd) NOT ENFORCED
)
OPTIONS(description='Describes which service is offered in the disposition (warehouse logistics). In this case its WU = Warenumschlag, which means that the goods are brought to a crossdock which are picked from that one to the next destination.');