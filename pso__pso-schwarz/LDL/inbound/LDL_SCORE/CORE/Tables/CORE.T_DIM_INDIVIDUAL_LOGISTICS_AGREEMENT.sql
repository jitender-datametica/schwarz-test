--==============================================================
-- Table: t_dim_individual_logistics_agreement
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_individual_logistics_agreement
   generated from Powerdesigner on Dienstag, 16. Juli 2024 13:22:34
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_INDIVIDUAL_LOGISTICS_AGREEMENT (
   individual_logistics_agmt_sid       NUMBER          NOT NULL COMMENT 'Agreement Identifier',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record becomes valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   individual_logistics_agmt_term_type_cd VARCHAR(20)     NOT NULL COMMENT 'The term type of an individual logistic agreement ',
   individual_logistics_agmt_type_cd   VARCHAR(20)     COMMENT 'The unique code for the type of an individual logistic agreement',
   individual_logistics_agmt_status_cd VARCHAR(20)     NOT NULL COMMENT 'Status of an agreement',
   individual_logistics_agmt_bus_nr    VARCHAR(50)     COMMENT 'Business Contract number, concatenation of  hauler_abbr_name, individual_logistics_agmt_nr, individual_logistics_agmt_version_nr.
            ',
   individual_logistics_agmt_nr        VARCHAR(20)     COMMENT 'Part of Business Individual logistics Agreement Key, defines number of the logistic agreement.',
   individual_logistics_agmt_version_nr VARCHAR(20)     COMMENT 'Part of Business Individual logistics Agreement Key, defines version of the logistic agreement.',
   agmt_released_tmsp                  TIMESTAMP_TZ(9) COMMENT 'Agreement released date time',
   agmt_sent_tmsp                      TIMESTAMP_TZ(9) COMMENT 'Agreement  sent  date time',
   agmt_checked_tmsp                   TIMESTAMP_TZ(9) COMMENT 'Agreement checked date time',
   agmt_printed_tmsp                   TIMESTAMP_TZ(9) COMMENT 'Agreement printed date time',
   agmt_changed_tmsp                   TIMESTAMP_TZ(9) COMMENT 'Agreement changed date time',
   agmt_created_tmsp                   TIMESTAMP_TZ(9) COMMENT 'Agreement created date time',
   hauler_sid                          NUMBER          COMMENT 'The unique identifier (surrogate key) for the company.',
   internal_contract_partner_sid       NUMBER          COMMENT 'Unique identifier for the internal contract partner',
   logistics_agmt_area_cd              VARCHAR(20)     COMMENT 'Agreement logistics area',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_DIM_INDIVIDUAL_LOGISTICS_AGREEMENT PRIMARY KEY (individual_logistics_agmt_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'CDM: Transportwegabschnitt-Vertrag, - designates a subcategory of a logistics contract that can be based on a logistics master agreement.';
