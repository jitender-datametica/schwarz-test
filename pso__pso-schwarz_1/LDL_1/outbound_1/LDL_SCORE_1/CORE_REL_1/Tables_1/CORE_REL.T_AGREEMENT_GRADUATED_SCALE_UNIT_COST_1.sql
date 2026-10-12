--==============================================================
-- Table: t_agreement_graduated_scale_unit_cost_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_agreement_graduated_scale_unit_cost_1
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_agreement_graduated_scale_unit_cost_1 (
route_segment_agmt_elem_sid BIGNUMERIC NOT NULL OPTIONS(description='Surrogate identifier for Agreement element'),
charge_type_cd STRING(20) NOT NULL
OPTIONS(description='This is a code, which defines the services for which, a fee is charged.'),
pallet_type_cd STRING(20) NOT NULL
OPTIONS(description='A code for the pallet that indicates the storage occupation for transportation.'),
pallet_exchange_fg BOOL NOT NULL
OPTIONS(description='A pallet exchange program is a collective agreement between pallet shippers and receivers that tries to ensure that each party maintains the same number of pallets. When loaded pallets are brought to a warehouse or another receiver, they are exchanged for an equal number of empty pallets.'),
unit_from_cnt BIGNUMERIC NOT NULL
OPTIONS(description='Start of the range for number of pallets or pallet spaces etc. for this graduated scale unit_1 record'),
unit_to_cnt BIGNUMERIC NOT NULL
OPTIONS(description='End of the range for  number of pallets or pallet spaces etc for this graduated scale unit_1 record'),
graduated_scale_billing_unit_cd STRING(20) NOT NULL
OPTIONS(description='This is the Units in which cost component is charged and can be Pallets or Pallet Spaces etc.'),
validity_period_from_tmsp TIMESTAMP NOT NULL OPTIONS(description='Validity_1 start'),
validity_period_to_tmsp TIMESTAMP NOT NULL OPTIONS(description='Validity_1 end'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
graduated_scale_unit_price BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Agreed price by billing unit_1 type'),
curr_cd STRING(3)
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\',…'),
price_billing_unit_cd STRING(20)
OPTIONS(description='This is the Unit_1 in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.'),
equipment_type_cd STRING(20) OPTIONS(description='The type discriminator for this equipment, i.e. vehicle(truck)'),
graduated_scale_unit_cost_nr STRING(20) NOT NULL
OPTIONS(description='Number, which identifies for business the graduated scale unit_1 cost.'),
term_day_cnt BIGNUMERIC OPTIONS(description='Term days'),
max_tons_meas BIGNUMERIC(38,5) OPTIONS(description='The maximum allowance for charging a truck in tons'),
min_pallet_cnt BIGNUMERIC OPTIONS(description='Minimum permitted load in Euro Pallets'),
weight_dispo_fg BOOL
OPTIONS(description='There can be a weight disposition in the groupage load as well as in the full load. In groupage, for example, the wine logistics are ordered truck-specifically,    since there are many heavy items in the order and the truck does not necessarily have to be ordered with a minimum purchase of 33 pallets,but the weight restriction (e.g. 22.5 t) can also be reached first .'),
negot_fg BOOL OPTIONS(description='Is this a negotiable term?'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (graduated_scale_billing_unit_cd, pallet_type_cd, route_segment_agmt_elem_sid, pallet_exchange_fg,
 unit_from_cnt, dwh_valid_from_tmsp, charge_type_cd, validity_period_from_tmsp, validity_period_to_tmsp, unit_to_cnt)
NOT ENFORCED
) OPTIONS(description='Depending on the quantity, a different price is used for the graduated price');