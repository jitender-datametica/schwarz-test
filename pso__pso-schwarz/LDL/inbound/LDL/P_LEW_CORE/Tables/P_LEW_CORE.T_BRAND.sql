/* --------------------------------------------------------------------------------
   DDL for table: t_brand
   generated from Powerdesigner on Thursday, February 1, 2024 11:39:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_BRAND (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT
            CBX: Static 7 (Stiftung);
            ESB: Static 7 (Stiftung);',
   brand_sid                           NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key BRAND;
            CBX: LdlBrand.code;
            ESB: cbxItem.brand.code;',
   src_brand_cd                        VARCHAR(20)      COMMENT 'Markencode (SAP-Retail / CBX);
            SAP-Retail: wrf_brands.brand_id;
            SAP-BW: z_ds_wrf_brands_t.brand_id;
            CBX: LdlBrand.code;
            ESB: cbxItem.brand.code;',
   brand_name                          VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Brand-Name in Stiftungssprache;
            SAP-Retail: wrf_brands_t.brand_descr;
            SAP-BW: z_ds_wrf_brands_t.brand_descr;
            CBX: Item.ldlBrand.name;
            ESB: cbxItem.brand.name;',
   brand_type_cd                       VARCHAR(20)      COLLATE 'en-ci' COMMENT 'FK Brand Type;
            CBX: ldlBrand.custText1;
            ESB: cbxItem.brand.type;',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_BRAND PRIMARY KEY (brand_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. BRND; Marken; ';

