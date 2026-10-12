--==============================================================
-- Table: t_company_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_company_2
   generated from Powerdesigner on Donnerstag, 25. Juli 2024 13:05:41
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_company_2 (
company_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the company.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
company_nr STRING(20)
OPTIONS(description='A numeric or alphanumeric value which identifies the company for the business.'),
company_abbr_name STRING(100) OPTIONS(description='A short abbreviation for the company that identifies it.'),
company_short_name STRING(100) OPTIONS(description='Short name for company. On CARGO side = <Kurzbezeichnung>'),
company_name STRING(100) OPTIONS(description='The name by which the company is known.'),
company_type_cd STRING(20)
OPTIONS(description='The code for the type of the company (internal or external). An internal company is contracted by the internal group of companies itself. An external company is commissioned by the supplier.'),
company_type_descr STRING(100)
OPTIONS(description='A textual description for the company_type_cd written out in group language (German).'),
company_status_cd STRING(20)
OPTIONS(description='The code for the status_2 of the company. (column  will likely be deleted and table doesn\'t exist on SF)'),
supplier_fg BOOL OPTIONS(description='An indicator showing whether the company acts as a supplier_2 for us.'),
int_negot_fg BOOL
OPTIONS(description='An indicator showing whether the company is internationally negotiated or country_2 specific.'),
hauler_fg BOOL OPTIONS(description='An indicator showing whether the company acts as a hauler for us.'),
vat_nr STRING(20) OPTIONS(description='The vat number (Umsatzsteuer ID). '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (company_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='This entity contains all companies that we interact with, e.g. Supplier_2 and Hauler.');