/* --------------------------------------------------------------------------------
   DDL for table: t_subitemgroup_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_subitemgroup_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
sub_item_grp_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SUBITEMGROUP'),
src_node STRING(20)
OPTIONS(description='Knotennummer aus SAP-Hierarchie; SAP-Retail: wrf_matgrp_struc.node; SAP-BW: z_ds_wrf_matgrp_struc.node'),
src_subitemgrp_cd STRING(20) OPTIONS(description='WAWI CD'),
src_subitemgrp_id BIGNUMERIC(38,0) OPTIONS(description='WAWI ID'),
sub_item_grp_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Subitemgroupname in Stiftungssprache; SAP-Retail: wrf_matgrp_strct.ltext; SAP-BW: z_ds_wrf_matgrp_strct.ltext'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (sub_item_grp_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. SUIG; 3. level item_1 hierarchy_1 - right above item_1 famgrp;             SAP-Retail: wrf_matgrp_struc;             SAP-BW: z_ds_wrf_matgrp_struc, Filter: HIER_ID="L1" & TREE_LEVEL="03";             ELWIS: t_s_itm_hier_node / t_l_itm_hier_struct;             WAWI: t_itm_subitemgroup_1');