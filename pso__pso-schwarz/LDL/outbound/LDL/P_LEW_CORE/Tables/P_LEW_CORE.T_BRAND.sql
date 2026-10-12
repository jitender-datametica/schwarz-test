/* --------------------------------------------------------------------------------
   DDL for table: t_brand
   generated from Powerdesigner on Thursday, February 1, 2024 11:39:36 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_brand (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='DWH-Mandant; FK auf CLIENT            CBX: Static 7 (Stiftung);            ESB: Static 7 (Stiftung);'),
brand_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key BRAND;            CBX: LdlBrand.code;            ESB: cbxItem.brand.code;'),
src_brand_cd STRING(20)
OPTIONS(description='Markencode (SAP-Retail / CBX);            SAP-Retail: wrf_brands.brand_id;            SAP-BW: z_ds_wrf_brands_t.brand_id;            CBX: LdlBrand.code;            ESB: cbxItem.brand.code;'),
brand_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Brand-Name in Stiftungssprache;            SAP-Retail: wrf_brands_t.brand_descr;            SAP-BW: z_ds_wrf_brands_t.brand_descr;            CBX: Item.ldlBrand.name;            ESB: cbxItem.brand.name;'),
brand_type_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='FK Brand Type;            CBX: ldlBrand.custText1;            ESB: cbxItem.brand.type;'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (brand_sid) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $. BRND; Marken; ');