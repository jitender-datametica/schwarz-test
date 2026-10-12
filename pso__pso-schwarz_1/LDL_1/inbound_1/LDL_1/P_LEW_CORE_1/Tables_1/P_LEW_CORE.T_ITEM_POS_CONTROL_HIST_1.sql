/* --------------------------------------------------------------------------------
   DDL for table: t_item_pos_control_hist_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_POS_CONTROL_HIST_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Artikel_1; FK auf ITEM_1;  SAP-Retail: wlk2.matnr;',
   sales_org_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Verkaufsorganisation; FK auf SALES_1 ORGANISATION; SAP-Retail; wlk2.vkorg; SAP-BW: t_bw_z_ds_wlk2.vkorg',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Handelsbetrieb; FK auf LOCATION_1; SAP-Retail: wlk2.werks; SAP-BW: t_bw_z_ds_wlk2.werks',
   distribution_channel_cd             VARCHAR(20)      NOT NULL COMMENT 'Vertriebsweg in Vertriebs-Linie Retail (Code); SAP-Retail: wlk2.vtweg; SAP-BW: t_bw_z_ds_wlk2.vtweg',
   scale_area                          VARCHAR(20)      COMMENT 'Waagenkreis; SAP-Retail: wlk2.scagr; SAP-BW: t_bw_z_ds_wlk2.scagr; ELWIS: t_s_itm_pos_control_data.scale_area_cd',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Artikelsteuerungsinfo ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_POS_CONTROL_HIST PRIMARY KEY (item_sid, sales_org_sid, loc_sid, distribution_channel_cd, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ITPC; Artikel_1-Stammdaten SAP Retail / Teil POS-Steuerungs-Daten;
             SAP-Retail: wlk2_1;
             SAP-BW: t_bw_z_ds_wlk2;
             ELWIS: t_s_itm_pos_control_data';

