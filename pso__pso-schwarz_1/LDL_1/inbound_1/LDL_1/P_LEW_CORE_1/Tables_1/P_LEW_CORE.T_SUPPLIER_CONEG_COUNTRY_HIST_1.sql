/* --------------------------------------------------------------------------------
   DDL for table: t_supplier_coneg_country_hist_1
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_SUPPLIER_CONEG_COUNTRY_HIST_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   sup_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Lieferant/Kreditor_1; FK auf SUPPLIER_1; SAP-Retail: zmmx_coneg_cntry.lifnr; SAP-BW: z_ds_zmmx_coneg_country.lifnr',
   country_sid_conegot                 NUMBER(38,0)     NOT NULL COMMENT 'Mitverhandelndes Land_1; FK auf COUNTRY_1; SAP-Retail: zmmx_coneg_cntry.conegot_country; SAP-BW: z_ds_zmmx_coneg_country.CONEGOT_COUNTRY',
   country_cd_conegot                  VARCHAR(20)      COMMENT 'Mitverhandelndes Land_1; SAP-Retail: zmmx_coneg_cntry.conegot_country; SAP-BW: z_ds_zmmx_coneg_country.conegot_country',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Lieferant/Land_1 ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_SUPPLIER_CONEG_COUNTRY_HIST PRIMARY KEY (sup_sid, country_sid_conegot, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. SPCCH; Mitverhandelnde Lander zum Lieferantenstamm;
             SAP-Retail: zmmx_coneg_cntry;
             SAP-BW: z_ds_zmmx_coneg_country;
             ELWIS: t_s_sup_co_negot_cntry;
             WAWI: t_sup_supplier';

