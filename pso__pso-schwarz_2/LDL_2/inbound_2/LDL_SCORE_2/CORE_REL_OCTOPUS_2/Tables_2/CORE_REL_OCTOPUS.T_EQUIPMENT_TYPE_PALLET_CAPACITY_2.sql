CREATE TABLE CORE_REL_OCTOPUS.T_EQUIPMENT_TYPE_PALLET_CAPACITY_2 (
   equipment_type_cd                   VARCHAR(20)     NOT NULL COMMENT 'The type discriminator for this equipment, i.e. vehicle(truck)',
   pallet_type_cd                      VARCHAR(20)     NOT NULL COMMENT 'The type of pallet (Euro-palllet or Duesseldorfer pallet) on which this item_2 variant is typically transported.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   pallet_cnt                          NUMBER          COMMENT 'number of pallets',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_EQUIPMENT_TYPE_PALLET_CAPACITY PRIMARY KEY (pallet_type_cd, dwh_valid_from_tmsp, equipment_type_cd) NOT ENFORCED 
)  COMMENT = 'How many storage spaces exist in this vehicle.';
