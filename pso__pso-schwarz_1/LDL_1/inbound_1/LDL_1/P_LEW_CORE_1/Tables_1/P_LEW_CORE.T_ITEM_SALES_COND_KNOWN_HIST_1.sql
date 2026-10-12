/* --------------------------------------------------------------------------------
   DDL for table: t_item_sales_cond_known_hist_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_SALES_COND_KNOWN_HIST_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Artikel_1; FK auf ITEM_1; SAP-Retail: zsdx_sales_price.matnr; SAP BW: zsdx_sales_price.matnr',
   uom_sid_sales                       NUMBER(38,0)     NOT NULL COMMENT 'Verkaufsmengeneinheit; FK auf UNIT_1 OF MEASUREMENT; SAP-Retail: zsdx_sales_price.vrkme; SAP BW: zsdx_sales_price.vrkme',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Betrieb; FK auf LOCATION_1; SAP-Retail: zsdx_sales_price.werks; SAP-BW: zsdx_sales_price.werks',
   comp_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Buchungskreis; FK auf COMPANY; SAP-Retail: zsdx_sales_price.bukrs; SAP-BW: zsdx_sales_price.bukrs',
   cond_type_cd                        VARCHAR(20)      NOT NULL COMMENT 'Konditionsart; SAP-Retail: zsdx_sales_price.kschl; SAP-BW: zsdx_sales_price.kschl',
   uom_sid_cond                        NUMBER(38,0)     COMMENT 'Konditionsmengeneinheit; FK auf UNIT_1 OF MEASUREMENT; SAP-Retail: zsdx_sales_price.kmein; SAP-BW: z_ds_zsdx_sales_price.kmein; ELWIS: t_s_itm_sales_condition.cond_uom_sid',
   curr_sid                            NUMBER(38,0)     COMMENT 'Wahrung; FK auf CURRENCY; SAP-Retail: zsdx_sales_price.waers; SAP-BW: zsdx_sales_price.waers',
   curr_cd                             VARCHAR(20)      COMMENT 'Wahrungscode; SAP-Retail: zsdx_sales_price.waers; SAP-BW: zsdx_sales_price.waers',
   uom_cd_sales                        VARCHAR(20)      COMMENT 'Verkaufsmengeneinheit; SAP BW: zsdx_sales_price.vrkme; SAP Retail: zsdx_sales_price.vrkme',
   uom_cd_cond                         VARCHAR(20)      COMMENT 'Konditionsmengeneinheit; SAP-Retail: zsdx_sales_price.kmein; SAP-BW: z_ds_zsdx_sales_price.kmein; ELWIS: t_s_itm_sales_condition.cond_uom_sid',
   cond_val                            NUMBER(18,5)     COMMENT 'Konditionsbetrag; SAP-Retail: zsdx_sales_price.kbetr; SAP-BW: zsdx_sales_price.kbetr; ELWIS Name: t_s_itm_sales_condition.gross_prcs',
   net_val                             NUMBER(18,5)     COMMENT 'Nettopreis; SAP-Retail: zsdx_sales_price.net_price; SAP-BW: z_ds_zsdx_sales_price.net_price; ELWIS: t_s_itm_sales_condition.net_prcs',
   reason_price_modification           VARCHAR(20)      COMMENT 'Aenderungsgrund fuer Verkaufspreisaenderung; SAP-Retail: zsdx_sales_price.grund; SAP-BW: zsdx_sales_price.grund; ELWIS: t_s_itm_sales_condition.reason_prc_mod_cd',
   tax_rate                            NUMBER(18,5)     COMMENT 'Steuersatz; SAP-Retail: zsdx_sales_price.mwst_rate; SAP-BW: zsdx_sales_price.mwst_rate; ELWIS: t_s_itm_sales_condition.vat_rate',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Verkaufskondition ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem loekn im Quellsystem wird dieser Status_1 angenommen; SAP-Retail: loekn; SAP-BW: loekn; ELWIS: del_fg',
   active_from_dt                      DATE             NOT NULL COMMENT 'Datum Gueltig Ab (default: 01.01.1900); SAP-Retail: zsdx_sales_price.datab; SAP-BW: z_ds_zsdx_sales_price.datab; ELWIS: t_s_itm_sales_condition.itm_valid_from_dat',
   active_to_dt                        DATE             NOT NULL COMMENT 'Datum Gueltig Bis; SAP-Retail: zsdx_sales_price.datbi; SAP-BW: zsdx_sales_price.datbi; ELWIS Name: t_s_itm_sales_condition.itm_valid_to_dat',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_SALES_COND_KNOWN_HIST PRIMARY KEY (item_sid, loc_sid, comp_sid, uom_sid_sales, cond_type_cd, active_to_dt, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ITSCH; Verkaufskonditionen/-preise; 
             SAP-Retail: zsdx_sales_price; 
             SAP-BW: t_bw_z_ds_zsdx_sales_price;
             ELWIS: t_s_itm_sales_condition';

