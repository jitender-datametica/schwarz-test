CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_equipment_type_pallet_capacity_2 (
equipment_type_cd STRING(20) NOT NULL
OPTIONS(description='The type discriminator for this equipment, i.e. vehicle(truck)'),
pallet_type_cd STRING(20) NOT NULL
OPTIONS(description='The type of pallet (Euro-palllet or Duesseldorfer pallet) on which this item_2 variant is typically transported.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
pallet_cnt BIGNUMERIC OPTIONS(description='number of pallets'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (pallet_type_cd, dwh_valid_from_tmsp, equipment_type_cd) NOT ENFORCED
) OPTIONS(description='How many storage spaces exist in this vehicle.');