CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_logistics_agreement_area_2 (
logistics_agmt_area_cd STRING(20) NOT NULL
OPTIONS(description='Code of Logistics agreement area, for example: IMP/LOG.'),
logistics_agmt_area_descr STRING(100)
OPTIONS(description='Description of logistics agreement area, for example: Import/Logistik.'),
logistics_agmt_area_descr_de STRING(100) OPTIONS(description='Description of logistics agreement area in English.'),
logistics_agmt_area_descr_en STRING(100) OPTIONS(description='Description of logistics agreement area in German.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (logistics_agmt_area_cd) NOT ENFORCED
) OPTIONS(description='This table defines areas of logistics agreement. For example Logistics and Import.');