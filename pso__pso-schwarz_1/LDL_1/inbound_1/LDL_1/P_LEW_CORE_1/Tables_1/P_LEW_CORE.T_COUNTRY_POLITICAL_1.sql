/* --------------------------------------------------------------------------------
   DDL for table: t_country_political_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_COUNTRY_POLITICAL_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT
            CBX: Static 7 (Stiftung);
            ESB: Static 7 (Stiftung);',
   country_pol_sid                     NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key COUNTRY_1 POLITICAL;
            CBX: Item.ldlCountryOfOrigin.code;
            ESB: cbxItem.countryOfOrigin.code;',
   src_land1                           VARCHAR(20)      COMMENT 'Quellsystemschluessel SAP-Retail: t005.land1;
            CBX: Item.ldlCountryOfOrigin.code;
            ESB: cbxItem.countryOfOrigin.code;',
   country_pol_name                    VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Name des Landes in Stiftungssprache; SAP-Retail: t005t.landx50;
            CBX: Item.ldlCountryOfOrigin.name;
            ESB: cbxItem.countryOfOrigin.name;',
   curr_sid                            NUMBER(38,0)     COMMENT 'Landeswaehrung; FK auf CURRENCY; SAP-Retail: t005.waers',
   lang_sid                            NUMBER(38,0)     COMMENT 'Default-Sprache; FK auf LANGUAGE; t005.spras',
   curr_cd                             VARCHAR(20)      COMMENT 'Landeswaehrung - Code; SAP-Retail: t005.waers',
   lang_cd                             VARCHAR(20)      COMMENT 'Default-Sprache; SAP-Retail: t005.spras',
   iso_code2                           VARCHAR(20)      COMMENT '2stelliger ISO Country_1 Code; SAP-Retail: t005.intca',
   iso_code3                           VARCHAR(20)      COMMENT '3stelliger ISO Country_1 Code; SAP-Retail: t005.intca3',
   member_eu_fg                        NUMBER(38,0)     COMMENT 'Mitglied der Europaeischen Union; SAP-Retail: t005.xegld',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_COUNTRY_POLITICAL PRIMARY KEY (country_pol_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Politische Laender';

