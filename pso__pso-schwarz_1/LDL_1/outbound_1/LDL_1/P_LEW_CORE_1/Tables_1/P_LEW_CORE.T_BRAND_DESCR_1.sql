/* --------------------------------------------------------------------------------
   DDL for table: t_brand_descr_1
   generated from Powerdesigner on Thursday, February 1, 2024 11:39:36 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_brand_descr_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='DWH-Mandant_1; FK auf CLIENT;            CBX: Static 7 (Stiftung);            ESB: Static 7 (Stiftung);'),
brand_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Marke; FK auf BRAND_1;            SAP-Retail: wrf_brands_t.brand_id;            SAP-BW: z_ds_wrf_brands_t.kmbrnd;            CBX: LdlBrand.code;            ESB: cbxItem.brand.code;'),
lang_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Sprache; FK auf REPORT LANGUAGE;            SAP-Retail: wrf_brands_t.language;            SAP-BW: z_ds_wrf_brands_t.spras;            CBX:\'@\' (Stiftung);            ESB:\'@\' (Stiftung);'),
lang_cd STRING(20)
OPTIONS(description='Sprache - Code;            SAP-Retail: wrf_brands_t.language;            SAP-BW: z_ds_wrf_brands_t.spras;            CBX:\'@\' (Stiftung);            ESB:\'@\' (Stiftung);'),
brand_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='Markenbezeichnung;            SAP-Retail: wrf_brands_t.brand_descr;            SAP-BW: z_ds_wrf_brands_t.bezek;            CBX: LdlBrand.name;            ESB: cbxItem.brand.name;'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (brand_sid, lang_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. BRDD; Markennamen;              SAP-Retail: wrf_brands_t_1;             SAP-BW: z_ds_wrf_brands_t;             ELWIS: t_r_brand_descr;             WAWI:              CBX: Item.ldlBrand;             ESB: cbxItem.brand_1;');