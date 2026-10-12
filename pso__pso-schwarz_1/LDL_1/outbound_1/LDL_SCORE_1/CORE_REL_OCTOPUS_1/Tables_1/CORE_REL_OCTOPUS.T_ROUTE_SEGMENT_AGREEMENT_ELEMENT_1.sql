CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_route_segment_agreement_element_1 (
route_segment_agmt_elem_sid BIGNUMERIC NOT NULL OPTIONS(description='Surrogate identifier for Agreement element'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
route_segment_agmt_elem_nr STRING(20) NOT NULL
OPTIONS(description='Number, which identifies route segment agreement element for Business'),
individual_logistics_agmt_sid BIGNUMERIC NOT NULL
OPTIONS(description='Parent Individual logistics Agreement Identifier'),
route_segment_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier of an transport route segment. Transportwegabschnitt'),
logistic_temp_cd STRING(20) OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'),
logistic_type_cd STRING(20)
OPTIONS(description='The code for the type of the logistic, e.g. Direct- or Collective logistics.'),
transport_service_type_cd STRING(20)
OPTIONS(description='The code for the type of the transport service, i.e.            Vorlauf,Zwischenlauf,Hauptlauf'),
receiving_bus_country_cd STRING(2)
OPTIONS(description='A two-character code according to the business definition of Kaufland or Lidl.'),
distance_cluster_cd STRING(20)
OPTIONS(description='This is a Code for a group a set of distances in the same group (called a cluster).'),
distance_km_meas BIGNUMERIC(38,5) OPTIONS(description='Distance of route segment in km'),
validity_period_from_tmsp TIMESTAMP NOT NULL OPTIONS(description='Validity_1 start'),
validity_period_to_tmsp TIMESTAMP NOT NULL OPTIONS(description='Route Valid to date'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (route_segment_agmt_elem_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Logistics contract contains several clauses. This entity describes contractual clauses that regulate transport on the specific routes.');