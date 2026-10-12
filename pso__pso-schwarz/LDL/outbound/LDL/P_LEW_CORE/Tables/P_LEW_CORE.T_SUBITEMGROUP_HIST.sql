/* --------------------------------------------------------------------------------
   DDL for table: t_subitemgroup_hist
   generated from Powerdesigner on Montag, 28. August 2023 13:30:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_subitemgroup_hist (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
sub_item_grp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='FK auf SUBITEMGROUP; SAP-Retail: wrf_matgrp_struc.node; SAP-BW: z_ds_wrf_matgrp_struc.node'),
item_grp_int_sid BIGNUMERIC(38,0)
OPTIONS(description='Itemgroup International; FK auf ITEMGROUP INTERNATIONAL; SAP-Retail: wrf_matgrp_struc.parent; SAP-BW: z_ds_wrf_matgrp_struc.parent'),
main_item_grp_sid BIGNUMERIC(38,0) OPTIONS(description='MainItemgroup; FK auf MAINITEMGROUP; '),
item_grp_int_cd STRING(20)
OPTIONS(description='Knotennummer der Itemgroup International aus SAP-Hierachie (= t_itemgroup_international.src_node); SAP-Retail: wrf_matgrp_struc.parent; SAP-BW: z_ds_wrf_matgrp_struc.parent'),
main_item_grp_cd STRING(20) OPTIONS(description='MainItemgroup; '),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Subitemgroup ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (sub_item_grp_sid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $. SUIGH; 3. level item hierarchy - right above item famgrp;');