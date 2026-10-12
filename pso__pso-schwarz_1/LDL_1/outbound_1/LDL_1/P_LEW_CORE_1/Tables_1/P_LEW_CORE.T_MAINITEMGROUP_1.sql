/* --------------------------------------------------------------------------------
   DDL for table: t_mainitemgroup_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mainitemgroup_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
main_item_grp_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key MAINITEMGROUP'),
src_mainitemgrp_id BIGNUMERIC(38,0) OPTIONS(description='WAWI Quellschluessel'),
main_item_grp_name STRING(100) COLLATE 'und:ci' OPTIONS(description='MainItemGroupName in Stiftungssprache; '),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (main_item_grp_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. MAIG; 4. Ebene der Artikelhierarchie aus WAWI. Steht oberhalb der SUBITEMGROUP in der WAWI;             SAP-Retail: -;             SAP-BW: -;             ELWIS: -;             WAWI: t_itm_mainitemgroup');