--==============================================================
-- Table: t_departure_site_agreement_element
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_departure_site_agreement_element
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_DEPARTURE_SITE_AGREEMENT_ELEMENT (
   departure_site_agmt_elem_sid        NUMBER           NOT NULL COMMENT 'Surrogate identifier for Agreement element',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN          NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   individual_logistics_agmt_sid       NUMBER           NOT NULL COMMENT 'Parent individual logistics Agreement Identifier',
   departure_site_sid                  NUMBER           COMMENT 'The unique identifier (surrogate key) for the departure site.',
   destination_bus_country_cd          VARCHAR(2)       COMMENT 'A two-character code according to the business definition of Kaufland or Lidl.',
   validity_period_from_tmsp           TIMESTAMP_TZ(9)  NOT NULL COMMENT 'Validity start',
   validity_period_to_tmsp             TIMESTAMP_TZ(9)  NOT NULL COMMENT 'Valid to',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_DEPARTURE_SITE_AGREEMENT_ELEMENT PRIMARY KEY (departure_site_agmt_elem_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = '''Strecke_AO''. Represents the agreement on a standard price with a hauler to transport goods from a supplier located a departure site to destination warehouses in another country.';

