/* --------------------------------------------------------------------------------
   DDL for table: t_country_political_descr_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_country_political_descr_2 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='DWH-Mandant_2; FK auf CLIENT;            CBX: Static 7 (Stiftung);            ESB: Static 7 (Stiftung);'),
country_pol_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='pol. Land_2; FK auf COUNTRY_2 POLITICAL;            SAP-Retail: t005t.land1;            SAP-BW: z_ds_t005t.land1;            CBX: Item.ldlCountryOfOrigin.code;            ESB: cbxItem.countryOfOrigin.code;'),
lang_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Sprache; FK auf REPORT LANGUAGE;            SAP-Retail: t005t.spras;            SAP-BW: z_ds_t005t.spras;            CBX: Static @ (Stiftung);            ESB: Static @ (Stiftung);'),
lang_cd STRING(20)
OPTIONS(description='Sprache - Code;            SAP-Retail: t005t.spras;            SAP-BW: z_ds_t005t.spras;            CBX: Static @ (Stiftung);            ESB: Static @ (Stiftung);'),
country_pol_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='Landesbezeichnung;            SAP-Retail: t005t.landx50;            SAP-BW: z_ds_t005t.landx50;            CBX: Item.ldlCountryOfOrigin.name;            ESB: cbxItem.countryOfOrigin.name;'),
nationality STRING(300) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung der Nationalitat;            SAP-Retail: t005t.natio50;            SAP-BW: z_ds_t005t.natio50;            CBX: NULL;            ESB: NULL;'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (country_pol_sid, lang_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. CPOD; Bezeichnung der politischen Laender;              SAP-Retail: t005t_2;             SAP-BW: z_ds_t005t;             ELWIS: -;             CBX: Item.ldlCountryOfOrigin;             ESB: cbxItem.countryOfOrigin;');