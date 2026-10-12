--==============================================================
-- Table: t_agreement_billing_unit_cost_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_agreement_billing_unit_cost_2
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_agreement_billing_unit_cost_2 (
route_segment_agmt_elem_sid BIGNUMERIC NOT NULL OPTIONS(description='Surrogate identifier for Agreement element'),
charge_type_cd STRING(20) NOT NULL
OPTIONS(description='This is a code, which defines the services for which, a fee is charged - for example for freight, surcharge.'),
pallet_type_cd STRING(20) NOT NULL
OPTIONS(description='A code for the pallet that indicates the storage occupation for transportation.'),
pallet_exchange_fg BOOL NOT NULL
OPTIONS(description='A pallet exchange program is a collective agreement between pallet shippers and receivers that tries to ensure that each party maintains the same number of pallets. When loaded pallets are brought to a warehouse or another receiver, they are exchanged for an equal number of empty pallets.'),
validity_period_from_tmsp TIMESTAMP NOT NULL OPTIONS(description='Validity_2 start'),
validity_period_to_tmsp TIMESTAMP NOT NULL OPTIONS(description='Validity_2 End'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
billing_unit_price BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Agreed price by billing unit_2 type'),
curr_cd STRING(3)
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\',…'),
billing_unit_cd STRING(20) NOT NULL
OPTIONS(description='Cost component\'s billing unit_2 code (Container, Stellplatz etc.)'),
equipment_type_cd STRING(20) OPTIONS(description='The type discriminator for this equipment, i.e. vehicle(truck)'),
billing_unit_cost_nr STRING(20) NOT NULL
OPTIONS(description='Number, which identifies the cos element for given route segment agreement element.'),
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
PRIMARY KEY (route_segment_agmt_elem_sid, pallet_type_cd, dwh_valid_from_tmsp, pallet_exchange_fg,
 validity_period_from_tmsp, validity_period_to_tmsp, charge_type_cd) NOT ENFORCED
)
OPTIONS(description='Billing Unit_2 price is comprised of graduated prices (Staffel) and can be supplemented by the graduated unit_2 prices if not defined as part of  the agreed price. This must be specified by the carrier in a logistics offer and can be per pallet or by  EP storage space (Euro pallet standardized storage space) or by means of transport or per loading meter.');