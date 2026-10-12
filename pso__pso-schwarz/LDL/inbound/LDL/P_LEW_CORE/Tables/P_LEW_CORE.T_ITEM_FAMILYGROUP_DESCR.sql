/* --------------------------------------------------------------------------------
   DDL for table: t_item_familygroup_descr
   generated from Powerdesigner on Montag, 28. August 2023 13:29:05
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_FAMILYGROUP_DESCR (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT;
            CBX: Static 7 (Stiftung);
            ESB: Static 7 (Stiftung);',
   item_fam_grp_sid                    NUMBER(38,0)     NOT NULL COMMENT 'Item Familygroup; FK auf ITEM FAMILYGROUP;
            SAP-Retail: wrf_matgrp_strct.node;
            SAP-BW: z_ds_wrf_matgrp_strct.node;
            CBX: Item.ldlArticleGroup.custText1;
            ESB: cbxItem.itemFamilyGroup.code;',
   lang_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Sprache; FK auf REPORT LANGUAGE;
            SAP-Retail: wrf_matgrp_strct.spras;
            SAP-BW: z_ds_wrf_matgrp_strct.spras;
            CBX: Static @;
            ESB: Static @;',
   lang_cd                             VARCHAR(20)      COMMENT 'Sprache - Code;
            SAP-Retail: wrf_matgrp_strct.spras;
            SAP-BW: z_ds_wrf_matgrp_strct.spras;
            CBX: Static @;
            ESB: Static @;',
   item_fam_grp_descr                  VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Artikelfamilie - Bezeichnung;
            SAP-Retail: wrf_matgrp_strct.ltext;
            SAP-BW: z_ds_wrf_matgrp_strct.ltext;
            ELWIS: t_s_itm_hier_node_descr.descr_short;
            CBX: Item.ldlArticleGroup.custText3;
            ESB: cbxItem.itemFamilyGroup.name;',
   item_fam_grp_descr_long             VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Artikelfamilie - Bezeichnung - lang;
            SAP-Retail: wrf_matgrp_strct.ltextlg;
            SAP-BW: z_ds_wrf_matgrp_strct.ltextlg;
            ELWIS: t_s_itm_hier_node_descr.descr_long;
            CBX: Item.ldlArticleGroup.custText3;
            ESB: cbxItem.itemFamilyGroup.name;',
   item_fam_grp_descr_caps             VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Artikelfamilie - Bezeichnung - Gro?buchstaben;
            SAP-Retail: wrf_matgrp_strct.ltextg;
            SAP-BW: z_ds_wrf_matgrp_strct.ltextg;
            ELWIS: t_s_itm_hier_node_descr.descr_caps;
            CBX: Item.ldlArticleGroup.custText3;
            ESB: upper-case(cbxItem.itemFamilyGroup.name);',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_FAMILYGROUP_DESCR PRIMARY KEY (item_fam_grp_sid, lang_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. IFAD; Sprachabhaengige Bezeichnung der Item Familygroup;
             SAP-Retail: wrf_matgrp_strct;
             SAP-BW: z_ds_wrf_matgrp_strct; Filter auf HIER_ID = "L1" 
             ELWIS: t_s_itm_hier_node_descr;
             CBX: Item.ldlArticleGroup;
             ESB: cbxItem.itemFamilyGroup;';
