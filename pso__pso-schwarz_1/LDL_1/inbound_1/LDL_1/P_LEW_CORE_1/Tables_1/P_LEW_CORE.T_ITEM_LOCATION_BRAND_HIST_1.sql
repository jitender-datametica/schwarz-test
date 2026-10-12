/* --------------------------------------------------------------------------------
   DDL for table: t_item_location_brand_hist_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_LOCATION_BRAND_HIST_1 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Artikel_1; FK auf ITEM_1; SAP-BW: t_bw_z_ds_mxxd2016.material',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Lokation; FK auf LOCATION_1; SAP-BW: t_bw_z_ds_mxxd2016.plant',
   brand_sid                           NUMBER(38,0)     COMMENT 'Marke; FK auf BRAND_1; SAP-BW: t_bw_z_ds_mxxd2016.zmbrandid',
   brand_type_mark                     VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Markentyp - Code; SAP-BW: t_bw_z_ds_mxxd2016.zmbrandtp',
   brand_type_label                    VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Markentyp - Beschreibung; ',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Artikel_1-Lokation-Info ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_LOCATION_BRAND_HIST PRIMARY KEY (item_sid, loc_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ILBR; Markeninformation pro Artikel_1 und Lokation (Filiale); 
             SAP-Retail: -;
             SAP-BW: t_bw_z_ds_mxxd2016 (berechnet aus z_ds_zmmx_v_wrpl_w001 + 0art_plant_attr + 0fre_matplant_attr);
             ELWIS: t_s_itm_loc_ext';

