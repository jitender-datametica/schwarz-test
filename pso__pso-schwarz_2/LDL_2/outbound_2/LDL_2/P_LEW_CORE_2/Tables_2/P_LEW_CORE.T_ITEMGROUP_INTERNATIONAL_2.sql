/* --------------------------------------------------------------------------------
   DDL for table: t_itemgroup_international_2
   generated from Powerdesigner on Montag, 28. August 2023 13:31:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_itemgroup_international_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
item_grp_int_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key ITEMGROUP_2 INTERNATIONAL'),
src_node STRING(20)
OPTIONS(description='Knotennummer aus SAP-Hierarchie; SAP-Retail: wrf_matgrp_struc.node; SAP-BW: z_ds_wrf_matgrp_struc.node'),
src_itemgrp_int_cd STRING(20) OPTIONS(description='WAWI Code'),
src_itemgrp_int_id BIGNUMERIC(38,0) OPTIONS(description='WAWI ID'),
item_grp_int_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Name der Subitemgroup Intenational in Stiftungssprache; SAP-Retail: wrf_matgrp_strct.ltext; SAP-BW: z_ds_wrf_matgrp_strct.ltext'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_grp_int_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. IGRI; 4. level item_2 hierarchy_2 - right above subitemgroup;             SAP-Retail: wrf_matgrp_struc;             SAP-BW: z_ds_wrf_matgrp_struc, Filter: HIER_ID="L1" & TREE_LEVEL="02"             ELWIS: t_s_itm_hier_node / t_l_itm_hier_struct;             WAWI: t_itm_itemgroup_int_2');