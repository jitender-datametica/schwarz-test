CREATE TABLE CORE_REL_OCTOPUS.T_ROUTE_SEGMENT_AGREEMENT_ELEMENT_EMISSION_1 (
   route_segment_agmt_elem_sid         NUMBER          NOT NULL COMMENT 'Business identifier for Agreement element',
   validity_period_from_tmsp           TIMESTAMP_TZ(9) NOT NULL COMMENT 'Emission valid from',
   validity_period_to_tmsp             TIMESTAMP_TZ(9) NOT NULL COMMENT 'Emission Valid to',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   route_segment_agmt_elem_emission_nr VARCHAR(20)     NOT NULL COMMENT 'Business identifier for Route Segment Agreement Element Emmssion',
   agmt_co2_emission_kg_meas           NUMBER(38, 5)   COMMENT 'Emission amount  of Carbon Dioxide in Kg',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_ROUTE_SEGMENT_AGREEMENT_ELEMENT_EMISSION PRIMARY KEY (route_segment_agmt_elem_sid, dwh_valid_from_tmsp, validity_period_from_tmsp, validity_period_to_tmsp) NOT ENFORCED 
)  COMMENT = 'The CO2 emissions describe the information provided by the logistics service provider on how much CO2 is emitted for the offered transport route segment. The unit_1 has not yet been determined, but in the future the information per truck will be transmitted by the logistics service provider.';
