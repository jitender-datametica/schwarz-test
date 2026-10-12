CREATE TABLE CORE_REL_OCTOPUS.T_ROUTE_SEGMENT_AGREEMENT_ELEMENT_1 (
   route_segment_agmt_elem_sid         NUMBER          NOT NULL COMMENT 'Surrogate identifier for Agreement element',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   route_segment_agmt_elem_nr          VARCHAR(20)     NOT NULL COMMENT 'Number, which identifies route segment agreement element for Business',
   individual_logistics_agmt_sid       NUMBER          NOT NULL COMMENT 'Parent Individual logistics Agreement Identifier',
   route_segment_sid                   NUMBER          NOT NULL COMMENT 'The unique identifier of an transport route segment. Transportwegabschnitt',
   logistic_temp_cd                    VARCHAR(20)     COMMENT 'The code for the type of the temperature zone, e.g. TK, TL.',
   logistic_type_cd                    VARCHAR(20)     COMMENT 'The code for the type of the logistic, e.g. Direct- or Collective logistics.',
   transport_service_type_cd           VARCHAR(20)     COMMENT 'The code for the type of the transport service, i.e.
            Vorlauf,Zwischenlauf,Hauptlauf',
   receiving_bus_country_cd            VARCHAR(2)      COMMENT 'A two-character code according to the business definition of Kaufland or Lidl.',
   distance_cluster_cd                 VARCHAR(20)     COMMENT 'This is a Code for a group a set of distances in the same group (called a cluster).',
   distance_km_meas                    NUMBER(38, 5)   COMMENT 'Distance of route segment in km',
   validity_period_from_tmsp           TIMESTAMP_TZ(9) NOT NULL COMMENT 'Validity_1 start',
   validity_period_to_tmsp             TIMESTAMP_TZ(9) NOT NULL COMMENT 'Route Valid to date',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_ROUTE_SEGMENT_AGREEMENT_ELEMENT PRIMARY KEY (route_segment_agmt_elem_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'Logistics contract contains several clauses. This entity describes contractual clauses that regulate transport on the specific routes.';
