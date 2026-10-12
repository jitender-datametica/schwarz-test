--==============================================================
-- Table: t_dim_equipment_type_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_equipment_type_1
   generated from Powerdesigner on Donnerstag, 25. Juli 2024 09:24:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_equipment_type_1 (
equipment_type_cd STRING(20) NOT NULL
OPTIONS(description='The type discriminator for this equipment, i.e. vehicle(truck)'),
equipment_type_descr STRING(100)
OPTIONS(description='Description for this equipment code, i.e. vehicle(truck) e.g.Jumbo/Megas,Planen-LKW, Kühl_1-LKW,Seecontainer 45`pw reefer'),
equipment_type_descr_de STRING(100) OPTIONS(description='Description in German for this equipment code'),
equipment_type_descr_en STRING(100) OPTIONS(description='Description in English  for this equipment code'),
equipment_type_external_id BIGNUMERIC OPTIONS(description='External system numeric code'),
equipment_capacity_ep_pallet_cnt BIGNUMERIC OPTIONS(description='Number of EP pallets that can fit in the vehicle'),
equipment_capacity_dd_pallet_cnt BIGNUMERIC OPTIONS(description='Number of DD pallets that can fit in the vehicle'),
means_of_transport_cd STRING(20)
OPTIONS(description='Means of transport of the delivery. e.g. (LKW, LKW_KL, LKW_KT...)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (equipment_type_cd) NOT ENFORCED
) OPTIONS(description='Type of vehicle i.e. Koffer');