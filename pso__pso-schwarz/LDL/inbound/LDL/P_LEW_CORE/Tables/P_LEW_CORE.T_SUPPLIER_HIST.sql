/* --------------------------------------------------------------------------------
   DDL for table: t_supplier_hist
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_SUPPLIER_HIST CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   sup_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key SUPPLIER',
   loc_sid                             NUMBER(38,0)     COMMENT 'Betrieb; FK auf LOCATION; SAP-Retail: lfa1.werks; SAP-BW: t_bw_0vendor_attr.werks; ELWIS: t_s_sup.loc_id',
   country_sid_negot                   NUMBER(38,0)     COMMENT 'Mitverhandelndes Lidl-Land; FK auf COUNTRY; SAP-Retail: lfa1.zz_negot_country; SAP-BW: t_bw_0vendor_attr.zz_negot_country; ELWIS: t_s_sup.main_negot_cntry_id',
   addr_sid                            NUMBER(38,0)     COMMENT 'Adresse; FK auf ADRESS; SAP-Retail: lfa1.adrnr;  Adressnummer; SAP-BW: t_bw_0vendor_attr.adrnr',
   country_cd_negot                    VARCHAR(20)      COMMENT 'Mitverhandelndes Land; SAP-Retail: lfa1.zz_negot_country; SAP-BW: t_bw_0vendor_attr.zz_negot_country; ELWIS: t_s_sup.main_negot_cntry_id',
   debtor_cd                           VARCHAR(20)      COMMENT 'Debitornummer; SAP-Retail: lfa1.kunnr; SAP-BW: t_bw_0vendor_attr.kunnr; ELWIS: t_s_sup.cust_id; ELWIS: t_s_sup.',
   name_1                              VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Lieferantenname; SAP-Retail: lfa1.name1; SAP-BW: t_bw_0vendor_attr.name1; ELWIS: t_s_sup_adr.name',
   int_location_no_1                   NUMBER(38,0)     COMMENT 'Internationale Locationsnummer Teil 1; SAP-Retail: lfa1.bbbnr; SAP-BW: t_bw_0vendor_attr.bbbnr; ELWIS: t_s_sup.global_loc_nr_1',
   int_location_no_2                   NUMBER(38,0)     COMMENT 'Internationale Locationnummber Teil 2; SAP-Retail: lfa1.bbsnr; SAP-BW: t_bw_0vendor_attr.bbsnr; ELWIS: t_s_sup.global_loc_nr_2',
   int_location_checking_no            NUMBER(38,0)     COMMENT 'Prueffziffer der internationalen Locationnummber; SAP-Retail: lfa1.bubkz; SAP-BW: t_bw_0vendor_attr.bubkz; ELWIS: t_s_sup.global_loc_nr_chkd',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Lieferant ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_SUPPLIER_HIST PRIMARY KEY (sup_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. SUPLH; Lieferanten; 
             SAP-Retail: lfa1;
             SAP-BW: t_bw_0vendor_attr;
             ELWIS: t_s_sup;
             WAWI: t_sup_supplier;';

