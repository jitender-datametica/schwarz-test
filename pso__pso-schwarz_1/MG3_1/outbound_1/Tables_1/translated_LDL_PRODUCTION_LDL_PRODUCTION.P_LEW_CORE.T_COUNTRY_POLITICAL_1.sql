DROP TABLE IF EXISTS ldl_production_p_lew_core.t_country_political_1;
CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_country_political_1 (
client_id INTEGER NOT NULL
OPTIONS(description='DWH-Mandant_1; FK auf CLIENT\n            CBX: Static 7 (Stiftung);\n            ESB: Static 7 (Stiftung);'),
country_pol_sid INTEGER NOT NULL
OPTIONS(description='Surrogate Key COUNTRY_1 POLITICAL;\n            CBX: Item.ldlCountryOfOrigin.code;\n            ESB: cbxItem.countryOfOrigin.code;'),
src_land1 STRING(20)
OPTIONS(description='Quellsystemschluessel SAP-Retail: t005.land1;\n            CBX: Item.ldlCountryOfOrigin.code;\n            ESB: cbxItem.countryOfOrigin.code;'),
country_pol_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Name des Landes in Stiftungssprache; SAP-Retail: t005t.landx50;\n            CBX: Item.ldlCountryOfOrigin.name;\n            ESB: cbxItem.countryOfOrigin.name;'),
curr_sid INTEGER OPTIONS(description='Landeswaehrung; FK auf CURRENCY; SAP-Retail: t005.waers'),
lang_sid INTEGER OPTIONS(description='Default-Sprache; FK auf LANGUAGE; t005.spras'),
curr_cd STRING(20) OPTIONS(description='Landeswaehrung - Code; SAP-Retail: t005.waers'),
lang_cd STRING(20) OPTIONS(description='Default-Sprache; SAP-Retail: t005.spras'),
iso_code2 STRING(20) OPTIONS(description='2stelliger ISO Country_1 Code; SAP-Retail: t005.intca'),
iso_code3 STRING(20) OPTIONS(description='3stelliger ISO Country_1 Code; SAP-Retail: t005.intca3'),
member_eu_fg INTEGER OPTIONS(description='Mitglied der Europaeischen Union; SAP-Retail: t005.xegld'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (country_pol_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Politische Laender');