/* --------------------------------------------------------------------------------
   DDL for table: t_internal_organization_1
   generated from Powerdesigner on Mittwoch, 29. November 2023 22:15:11
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_INTERNAL_ORGANIZATION_1 (
   int_org_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   int_org_type_cd                     VARCHAR(20)     NOT NULL COMMENT 'The code identifying the discriminators for internal organizations.',
   int_org_nr                          VARCHAR(20)     NOT NULL COMMENT 'The number by which the internal organization is identified by business.',
   int_org_name                        VARCHAR(100)    COMMENT 'The name by which the internal organization is known.',
   int_org_short_name                  VARCHAR(100)    COMMENT 'In case of internal companies, this column is filled with a three-letter abbreviation which identifies the internal company. E.g. LAA for Laakirchen.',
   open_dt                             DATE            COMMENT 'The date when the internal organization unit_1 (store, warehouse, …) has started its regular operation. (This date may be different from the planned opening date.)',
   planned_open_dt                     DATE            COMMENT 'The date for which it was initially intended that the internal organization unit_1 (store, warehouse, …) starts its regular operation. (This date may be different from the actual opening date.)',
   close_dt                            DATE            COMMENT 'The date when the internal organization unit_1 (store, warehouse, …) has stopped its regular operation.',
   holiday_store_fg                    BOOLEAN         COMMENT 'An indicator showing, if the store is open on public holidays.',
   legal_name                          VARCHAR(100)    COMMENT 'The official name of the company, as shown in the company register.',
   vat_nr                              VARCHAR(20)     COMMENT 'The VAT identification number of the company.',
   country_org_cd                      VARCHAR(2)      COMMENT 'The code of the business country_1 for which this country_1 organization is responsible. (The business country_1 is not identical to a political country.)',
   country_org_name                    VARCHAR(100)    COMMENT 'The name of the country_1 organization. (This is the country_1 name, as it is known to business. E.g. Germany.)',
   curr_cd                             VARCHAR(3)      COMMENT 'The code identifying the currency, according to ISO 4217.',
   comment_txt                         VARCHAR(1000)   COMMENT 'A free text comment to the internal organization',
   is_sales_company_fg                 BOOLEAN         COMMENT 'An indicator showing, if the internal company is a sales_1 company.',
   is_deliv_company_fg                 BOOLEAN         COMMENT 'An indicator showing, if the internal company is a delivery company.',
   is_country_org_fg                   BOOLEAN         COMMENT 'An indicator showing, if the internal company is a country_1 organization.',
   is_expansion_company_fg             BOOLEAN         COMMENT 'An indicator showing, if the internal company is an expansion company.',
   is_bal_sheet_company_fg             BOOLEAN         COMMENT 'An indicator showing, if the internal company is a balance sheet company.',
   is_owner_company_fg                 BOOLEAN         COMMENT 'An indicator showing, if the internal company is an owner company.',
   is_trust_fg                         BOOLEAN         COMMENT 'An indicator showing, if the internal company is the trust (Stiftung).',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_INTERNAL_ORGANIZATION PRIMARY KEY (int_org_sid, dwh_valid_from_tmsp) NOT ENFORCED
)  COMMENT= 'This party subtype contains organizational units of the Schwarz Group, such as departments or cost and profit centres.';