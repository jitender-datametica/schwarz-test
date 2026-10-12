/* --------------------------------------------------------------------------------
   DDL for table: t_item_replenishment_hist_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_REPLENISHMENT_HIST_2 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Artikel_2; FK auf ITEM_2; SAP-Retail: zmmx_v_wrpl_w001.matnr',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Betrieb; FK auf LOCATION_2; SAP-Retail: zmmx_v_wrpl_w001.werks',
   min_nominal_stock                   NUMBER(18,5)     COMMENT 'Minimaler Sollbestand; SAP-Retail: zmmx_v_wrpl_w001.zz_hb_bme; SAP-BW: t_bw_z_ds_zmmx_v_wrpl_w001.zz_hb_bme',
   min_order_qty                       NUMBER(18,5)     COMMENT 'Mindestbestellmenge/Basis-ME; SAP-Retail: zmmx_v_wrpl_w001.zz_mbm; SAP-BW: t_bw_z_ds_zmmx_v_wrpl_w001.zz_mbm',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Artikelnachschub ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_REPLENISHMENT_HIST PRIMARY KEY (item_sid, loc_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. DEPRECATED - use t_item_location_replenishment_info_hist_2 instead';

