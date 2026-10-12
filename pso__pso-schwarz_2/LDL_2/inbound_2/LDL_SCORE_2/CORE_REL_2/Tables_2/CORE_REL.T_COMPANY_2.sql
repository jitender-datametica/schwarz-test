--==============================================================
-- Table: t_company_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_company_2
   generated from Powerdesigner on Donnerstag, 25. Juli 2024 13:05:41
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_COMPANY_2 (
   company_sid                         NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the company.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   company_nr                          VARCHAR(20)     COMMENT 'A numeric or alphanumeric value which identifies the company for the business.',
   company_abbr_name                   VARCHAR(100)    COMMENT 'A short abbreviation for the company that identifies it.',
   company_short_name                  VARCHAR(100)    COMMENT 'Short name for company. On CARGO side = <Kurzbezeichnung>',
   company_name                        VARCHAR(100)    COMMENT 'The name by which the company is known.',
   company_type_cd                     VARCHAR(20)     COMMENT 'The code for the type of the company (internal or external). An internal company is contracted by the internal group of companies itself. An external company is commissioned by the supplier.',
   company_type_descr                  VARCHAR(100)    COMMENT 'A textual description for the company_type_cd written out in group language (German).',
   company_status_cd                   VARCHAR(20)     COMMENT 'The code for the status_2 of the company. (column  will likely be deleted and table doesn''t exist on SF)',
   supplier_fg                         BOOLEAN         COMMENT 'An indicator showing whether the company acts as a supplier_2 for us.',
   int_negot_fg                        BOOLEAN         COMMENT 'An indicator showing whether the company is internationally negotiated or country_2 specific.',
   hauler_fg                           BOOLEAN         COMMENT 'An indicator showing whether the company acts as a hauler for us.',
   vat_nr                              VARCHAR(20)     COMMENT 'The vat number (Umsatzsteuer ID). ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_COMPANY PRIMARY KEY (company_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'This entity contains all companies that we interact with, e.g. Supplier_2 and Hauler.';