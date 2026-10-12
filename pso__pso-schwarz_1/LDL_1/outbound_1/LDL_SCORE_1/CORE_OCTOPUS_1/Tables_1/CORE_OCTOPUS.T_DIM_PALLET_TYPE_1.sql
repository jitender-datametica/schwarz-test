CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_pallet_type_1 (
pallet_type_cd STRING(20) NOT NULL OPTIONS(description='Pallet code of the fact row'),
pallet_type_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the pallet_type_cd written out in group language (German).'),
pallet_type_descr_de STRING(100)
OPTIONS(description='A textual description for the pallet_type_cd written out in German.'),
pallet_type_descr_en STRING(100)
OPTIONS(description='A textual description for the pallet_type_cd written out in English.'),
pallet_type_factor BIGNUMERIC(38,5)
OPTIONS(description='Space requirement of the pallet type compared to space requirement of Euro Pallet. eg. 1DD = 0,5 EP '),
octopus_pallet_type_id BIGNUMERIC OPTIONS(description='External system numeric code'),
elm_pallet_type_id BIGNUMERIC OPTIONS(description='ELM: elm_pallettypeid'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (pallet_type_cd) NOT ENFORCED
) OPTIONS(description='Lists the types of pallets used for transportation. Euro pallet or Düsseldorf pallet');