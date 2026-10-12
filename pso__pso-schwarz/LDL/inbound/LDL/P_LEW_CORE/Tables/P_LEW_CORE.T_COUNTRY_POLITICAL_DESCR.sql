/* --------------------------------------------------------------------------------
   DDL for table: t_country_political_descr
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_COUNTRY_POLITICAL_DESCR CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT;
            CBX: Static 7 (Stiftung);
            ESB: Static 7 (Stiftung);',
   country_pol_sid                     NUMBER(38,0)     NOT NULL COMMENT 'pol. Land; FK auf COUNTRY POLITICAL;
            SAP-Retail: t005t.land1;
            SAP-BW: z_ds_t005t.land1;
            CBX: Item.ldlCountryOfOrigin.code;
            ESB: cbxItem.countryOfOrigin.code;',
   lang_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Sprache; FK auf REPORT LANGUAGE;
            SAP-Retail: t005t.spras;
            SAP-BW: z_ds_t005t.spras;
            CBX: Static @ (Stiftung);
            ESB: Static @ (Stiftung);',
   lang_cd                             VARCHAR(20)      COMMENT 'Sprache - Code;
            SAP-Retail: t005t.spras;
            SAP-BW: z_ds_t005t.spras;
            CBX: Static @ (Stiftung);
            ESB: Static @ (Stiftung);',
   country_pol_descr                   VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Landesbezeichnung;
            SAP-Retail: t005t.landx50;
            SAP-BW: z_ds_t005t.landx50;
            CBX: Item.ldlCountryOfOrigin.name;
            ESB: cbxItem.countryOfOrigin.name;',
   nationality                         VARCHAR(300)     COLLATE 'en-ci' COMMENT 'Bezeichnung der Nationalitat;
            SAP-Retail: t005t.natio50;
            SAP-BW: z_ds_t005t.natio50;
            CBX: NULL;
            ESB: NULL;',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_COUNTRY_POLITICAL_DESCR PRIMARY KEY (country_pol_sid, lang_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. CPOD; Bezeichnung der politischen Laender; 
             SAP-Retail: t005t;
             SAP-BW: z_ds_t005t;
             ELWIS: -;
             CBX: Item.ldlCountryOfOrigin;
             ESB: cbxItem.countryOfOrigin;';

