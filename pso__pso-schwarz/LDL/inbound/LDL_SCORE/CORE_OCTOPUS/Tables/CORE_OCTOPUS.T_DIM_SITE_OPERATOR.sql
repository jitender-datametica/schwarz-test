CREATE TABLE CORE_OCTOPUS.T_DIM_SITE_OPERATOR (
   site_operator_sid                   NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the site operator.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   site_operator_nr                    VARCHAR(20)     COMMENT 'A numeric or alphanumeric value which identifies the company for the business.',
   site_operator_abbr_name             VARCHAR(100)    COMMENT 'A short abbreviation for the company that identifies it.',
   site_operator_short_name            VARCHAR(100)    COMMENT 'Short name for company. On CARGO side = <Kurzbezeichnung>',
   site_operator_name                  VARCHAR(100)    COMMENT 'The name by which the company is known.',
   site_operator_status_cd             VARCHAR(20)     NOT NULL COMMENT 'The code for the status of the company. (column  will likely be deleted and table doesn''t exist on SF)',
   supplier_fg                         BOOLEAN         COMMENT 'An indicator showing whether the site operator acts as a supplier for us.',
   hauler_fg                           BOOLEAN         COMMENT 'An indicator showing whether the site operator acts as a hauler for us.',
   org_unit_fg                         BOOLEAN         COMMENT 'An indicator showing whether the site operator acts as a org unit for us.',
   vat_nr                              VARCHAR(20)     COMMENT 'The vat number (Umsatzsteuer ID). ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_SITE_OPERATOR PRIMARY KEY (site_operator_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'This dimension contains all companies that we interact with, e.g. Supplier and Hauler and Warehouse Org Units';
