CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_route_segment_supplier_cost (
route_segment_agmt_elem_sid BIGNUMERIC NOT NULL OPTIONS(description='Surrogate identifier for Agreement element'),
pallet_type_cd STRING(20) NOT NULL
OPTIONS(description='The type of pallet (Euro-palllet or Duesseldorfer pallet) on which this item variant is typically transported.'),
validity_period_from_tmsp TIMESTAMP NOT NULL OPTIONS(description='Validity start'),
validity_period_to_tmsp TIMESTAMP NOT NULL OPTIONS(description='Valid to'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
pallet_net_price BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Agreed netto price per pallet including service charge'),
curr_cd STRING(3) NOT NULL
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (route_segment_agmt_elem_sid, dwh_valid_from_tmsp, pallet_type_cd, validity_period_from_tmsp,
 validity_period_to_tmsp, curr_cd) NOT ENFORCED
)
OPTIONS(description='Table contains cost, which supplier pays to the hauler for a specific agreement element. The cost depends on pallet type. The cost is negotiated for validity period, contracts type\'Logistik\', route segment agreement element.');