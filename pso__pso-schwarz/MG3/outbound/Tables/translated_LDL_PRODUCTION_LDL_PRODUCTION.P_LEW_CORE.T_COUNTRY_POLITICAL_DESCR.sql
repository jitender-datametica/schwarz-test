DROP TABLE IF EXISTS ldl_production_p_lew_core.t_country_political_descr;
CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_country_political_descr (
client_id INTEGER NOT NULL
OPTIONS(description='DWH-Mandant; FK auf CLIENT;\n            CBX: Static 7 (Stiftung);\n            ESB: Static 7 (Stiftung);'),
country_pol_sid INTEGER NOT NULL
OPTIONS(description='pol. Land; FK auf COUNTRY POLITICAL;\n            SAP-Retail: t005t.land1;\n            SAP-BW: z_ds_t005t.land1;\n            CBX: Item.ldlCountryOfOrigin.code;\n            ESB: cbxItem.countryOfOrigin.code;'),
lang_sid INTEGER NOT NULL
OPTIONS(description='Sprache; FK auf REPORT LANGUAGE;\n            SAP-Retail: t005t.spras;\n            SAP-BW: z_ds_t005t.spras;\n            CBX: Static @ (Stiftung);\n            ESB: Static @ (Stiftung);'),
lang_cd STRING(20)
OPTIONS(description='Sprache - Code;\n            SAP-Retail: t005t.spras;\n            SAP-BW: z_ds_t005t.spras;\n            CBX: Static @ (Stiftung);\n            ESB: Static @ (Stiftung);'),
country_pol_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='Landesbezeichnung;\n            SAP-Retail: t005t.landx50;\n            SAP-BW: z_ds_t005t.landx50;\n            CBX: Item.ldlCountryOfOrigin.name;\n            ESB: cbxItem.countryOfOrigin.name;'),
nationality STRING(300) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung der Nationalitat;\n            SAP-Retail: t005t.natio50;\n            SAP-BW: z_ds_t005t.natio50;\n            CBX: NULL;\n            ESB: NULL;'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (country_pol_sid, lang_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. CPOD; Bezeichnung der politischen Laender;\nSAP-Retail: t005t;\nSAP-BW: z_ds_t005t;\nELWIS: -;\nCBX: Item.ldlCountryOfOrigin;\nESB: cbxItem.countryOfOrigin;');