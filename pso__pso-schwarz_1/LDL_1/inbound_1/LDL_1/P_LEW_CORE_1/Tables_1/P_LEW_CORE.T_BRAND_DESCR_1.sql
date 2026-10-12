/* --------------------------------------------------------------------------------
   DDL for table: t_brand_descr_1
   generated from Powerdesigner on Thursday, February 1, 2024 11:39:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_BRAND_DESCR_1 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT;
            CBX: Static 7 (Stiftung);
            ESB: Static 7 (Stiftung);',
   brand_sid                           NUMBER(38,0)     NOT NULL COMMENT 'Marke; FK auf BRAND_1;
            SAP-Retail: wrf_brands_t.brand_id;
            SAP-BW: z_ds_wrf_brands_t.kmbrnd;
            CBX: LdlBrand.code;
            ESB: cbxItem.brand.code;',
   lang_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Sprache; FK auf REPORT LANGUAGE;
            SAP-Retail: wrf_brands_t.language;
            SAP-BW: z_ds_wrf_brands_t.spras;
            CBX: ''@'' (Stiftung);
            ESB: ''@'' (Stiftung);',
   lang_cd                             VARCHAR(20)      COMMENT 'Sprache - Code;
            SAP-Retail: wrf_brands_t.language;
            SAP-BW: z_ds_wrf_brands_t.spras;
            CBX: ''@'' (Stiftung);
            ESB: ''@'' (Stiftung);',
   brand_descr                         VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Markenbezeichnung;
            SAP-Retail: wrf_brands_t.brand_descr;
            SAP-BW: z_ds_wrf_brands_t.bezek;
            CBX: LdlBrand.name;
            ESB: cbxItem.brand.name;',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_BRAND_DESCR PRIMARY KEY (brand_sid, lang_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. BRDD; Markennamen; 
             SAP-Retail: wrf_brands_t_1;
             SAP-BW: z_ds_wrf_brands_t;
             ELWIS: t_r_brand_descr;
             WAWI: 
             CBX: Item.ldlBrand;
             ESB: cbxItem.brand_1;';

