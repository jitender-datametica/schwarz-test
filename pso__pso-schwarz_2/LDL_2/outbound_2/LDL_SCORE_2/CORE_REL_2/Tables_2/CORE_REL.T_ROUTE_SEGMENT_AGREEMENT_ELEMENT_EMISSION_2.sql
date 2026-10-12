--==============================================================
-- Table: t_route_segment_agreement_element_emission_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_route_segment_agreement_element_emission_2
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_route_segment_agreement_element_emission_2 (
route_segment_agmt_elem_sid BIGNUMERIC NOT NULL OPTIONS(description='Business identifier for Agreement element'),
validity_period_from_tmsp TIMESTAMP NOT NULL OPTIONS(description='Emission valid from'),
validity_period_to_tmsp TIMESTAMP NOT NULL OPTIONS(description='Emission Valid to'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
route_segment_agmt_elem_emission_nr STRING(20) NOT NULL
OPTIONS(description='Business identifier for Route Segment Agreement Element Emmssion'),
agmt_co2_emission_kg_meas BIGNUMERIC(38,5) OPTIONS(description='Emission amount  of Carbon Dioxide in Kg'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (route_segment_agmt_elem_sid, dwh_valid_from_tmsp, validity_period_from_tmsp, validity_period_to_tmsp)
NOT ENFORCED
)
OPTIONS(description='The CO2 emissions describe the information provided by the logistics service provider on how much CO2 is emitted for the offered transport route segment. The unit_2 has not yet been determined, but in the future the information per truck will be transmitted by the logistics service provider.');