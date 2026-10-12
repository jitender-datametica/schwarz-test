--==============================================================
-- Table: t_dim_logistics_tariff_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_logistics_tariff_2
   generated from Powerdesigner on Dienstag, 16. Juli 2024 13:41:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_logistics_tariff_2 (
logistics_tariff_sid BIGNUMERIC NOT NULL OPTIONS(description='Surrogate identifier for Logistics Tariff'),
equipment_type_cd STRING(20) NOT NULL
OPTIONS(description='The type discriminator for this equipment, i.e. vehicle(truck)'),
negot_fg BOOL OPTIONS(description='Is this a negotiable term?'),
weight_dispo_fg BOOL
OPTIONS(description='There can be a weight disposition in the groupage load as well as in the full load. In groupage, for example, the wine logistics are ordered truck-specifically,             since there are many heavy items in the order and the truck does not necessarily have to be ordered with a minimum purchase of 33 pallets,             but the weight restriction (e.g. 22.5 t) can also be reached first .            '),
max_tons_meas BIGNUMERIC(38,5) OPTIONS(description='The maximum allowance for charging a truck in tons'),
term_day_cnt BIGNUMERIC OPTIONS(description='Term days'),
min_pallet_cnt BIGNUMERIC OPTIONS(description='Minimum permitted load in Euro Pallets'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (logistics_tariff_sid) NOT ENFORCED
)
OPTIONS(description='Contains details about terms and conditions of tariffs applicable for a logistical agreements             ');