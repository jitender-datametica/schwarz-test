/* --------------------------------------------------------------------------------
   DDL for table: t_subitemgroup_hist
   generated from Powerdesigner on Montag, 28. August 2023 13:30:27
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_SUBITEMGROUP_HIST (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   sub_item_grp_sid                    NUMBER(38,0)     NOT NULL COMMENT 'FK auf SUBITEMGROUP; SAP-Retail: wrf_matgrp_struc.node; SAP-BW: z_ds_wrf_matgrp_struc.node',
   item_grp_int_sid                    NUMBER(38,0)     COMMENT 'Itemgroup International; FK auf ITEMGROUP INTERNATIONAL; SAP-Retail: wrf_matgrp_struc.parent; SAP-BW: z_ds_wrf_matgrp_struc.parent',
   main_item_grp_sid                   NUMBER(38,0)     COMMENT 'MainItemgroup; FK auf MAINITEMGROUP; ',
   item_grp_int_cd                     VARCHAR(20)      COMMENT 'Knotennummer der Itemgroup International aus SAP-Hierachie (= t_itemgroup_international.src_node); SAP-Retail: wrf_matgrp_struc.parent; SAP-BW: z_ds_wrf_matgrp_struc.parent',
   main_item_grp_cd                    VARCHAR(20)      COMMENT 'MainItemgroup; ',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Subitemgroup ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_SUBITEMGROUP_HIST PRIMARY KEY (sub_item_grp_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. SUIGH; 3. level item hierarchy - right above item famgrp;';
