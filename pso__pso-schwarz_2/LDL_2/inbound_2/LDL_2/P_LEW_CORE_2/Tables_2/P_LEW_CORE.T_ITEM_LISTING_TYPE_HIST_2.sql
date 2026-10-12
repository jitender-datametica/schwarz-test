/* --------------------------------------------------------------------------------
   DDL for table: t_item_listing_type_hist_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_LISTING_TYPE_HIST_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Artikel_2; FK auf ITEM_2; SAP-Retail: zmmx_marc_list.matnr; SAP-BW: t_bw_z_ds_zmmx_marc_list.matnr',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Betrieb; FK auf LOCATION_2; SAP-Retail: zmmx_marc_list.werks; SAP-BW: t_bw_z_ds_zmmx_marc_list.werks',
   active_from_dt                      DATE             NOT NULL COMMENT 'Listungsart: Gueltig ab; SAP-Retail: zmmx_marc_list.zz_list_ab; SAP-BW: t_bw_z_ds_zmmx_marc_list.zz_list_ab; ELWIS: t_s_itm_loc_list.list_type_from_dat',
   active_to_dt                        DATE             NOT NULL COMMENT 'Listungsart: Gueltig bis; SAP-Retail: zmmx_marc_list.zz_list_bis; SAP-BW: t_bw_z_ds_zmmx_marc_list.zz_list_bis; ELWIS: t_s_itm_loc_list.list_type_to_dat',
   list_type_mark                      VARCHAR(20)      COMMENT 'Listungsart - Code; (A=Aktion_2, S=Sortiment); SAP-Retail: zmmx_marc_list.zz_key_list; SAP-BW: t_bw_z_ds_zmmx_marc_list.zz_key_list',
   list_type_label                     VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Listungsart - Beschreibung; (A=Aktion_2, S=Sortiment) if (ZZ_KEY_LIST = "A") then "Aktion_2" else if (ZZ_KEY_LIST = "S") then "Sortiment" else NULL ',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Listungsart ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_LISTING_TYPE_HIST PRIMARY KEY (item_sid, loc_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ILIS; Listungsart (Aktion_2, Sortiment) zeitabhangig Betriebe-Ebene; 
             SAP-Retail: zmmx_marc_list_2;
             SAP-BW: t_bw_z_ds_zmmx_marc_list;
             ELWIS: t_s_itm_loc_list';

