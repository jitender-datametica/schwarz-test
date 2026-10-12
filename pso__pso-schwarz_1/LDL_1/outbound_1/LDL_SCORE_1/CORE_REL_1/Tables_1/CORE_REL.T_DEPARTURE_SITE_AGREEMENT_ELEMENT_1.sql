--==============================================================
-- Table: t_departure_site_agreement_element_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_departure_site_agreement_element_1
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_departure_site_agreement_element_1 (
departure_site_agmt_elem_sid BIGNUMERIC NOT NULL OPTIONS(description='Surrogate identifier for Agreement element'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
individual_logistics_agmt_sid BIGNUMERIC NOT NULL
OPTIONS(description='Parent individual logistics Agreement Identifier'),
departure_site_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the departure site.'),
destination_bus_country_cd STRING(2)
OPTIONS(description='A two-character code according to the business definition of Kaufland or Lidl.'),
validity_period_from_tmsp TIMESTAMP NOT NULL OPTIONS(description='Validity_1 start'),
validity_period_to_tmsp TIMESTAMP NOT NULL OPTIONS(description='Valid to'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (departure_site_agmt_elem_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='\'Strecke_AO\'. Represents the agreement on a standard price with a hauler to transport goods from a supplier_1 located a departure site to destination warehouses in another country.');