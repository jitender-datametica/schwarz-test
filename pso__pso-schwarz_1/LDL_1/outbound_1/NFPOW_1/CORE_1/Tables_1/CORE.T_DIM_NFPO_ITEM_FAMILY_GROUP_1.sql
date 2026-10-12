/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_item_family_group_1
   generated from Powerdesigner on Mittwoch, 26. Februar 2025 09:39:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_item_family_group_1 (
nfpo_item_fam_grp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of item_1 family group            CBX: ctm_codelist_book.custText1;            LDL: p_lew_core.t_item_familygroup.item_fam_grp_sid            core_rel:T_NFPO_ITEM_FAMILY_GROUP_HIST.nfpo_item_fam_grp_sid'),
nfpo_item_fam_grp_nr STRING(100)
OPTIONS(description='identifiying code of the item_1 family group, consists of the code of the sub itemgroup_1 and the code of the item_1 family in the sub itemgroup_1            WAWI Code;            CBX: ctm_codelist_book.custText1;            LDL: p_lew_core.t_item_familygroup.src_familygrp_cd            CORE_REL: t_nfpo_item_family_group.nfpo_item_fam_grp_nr'),
nfpo_item_fam_grp_name STRING(100)
OPTIONS(description='name of the item_1 family group            CBX: ctm_codelist_bookcustText3;            LDL: p_lew_core.t_item_family_group.item_fam_grp_name            CORE_REL: t_nfpo_item_family_group.nfpo_item_fam_grp_name'),
nfpo_assortment_area_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='code of the NFPO assortment area            CBX:  CNT_CODELIST.CUSTOM_FIELD_TEXT5  (code list "REPORT_AF_PILLAR_PRODUCTCATEGORY")            LDL: P_LEW_CORE.T_REF_MDM_ASSORTMENT_AREA.MDM_ASSORTMENT_AREA_ID'),
nfpo_assortment_area_name STRING(100)
OPTIONS(description='name of the NFPO asortment area            CBX:  CNT_CODELIST.CUSTOM_FIELD_TEXT3  (code list "REPORT_AF_PILLAR_PRODUCTCATEGORY")            LDL: P_LEW_CORE.T_REF_MDM_ASSORTMENT_AREA.MDM_ASSORTMENT_AREA_NAME'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_fam_grp_sid) NOT ENFORCED
) OPTIONS(description='Comment 2Do');