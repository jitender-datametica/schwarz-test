/* --------------------------------------------------------------------------------
   DDL for table: t_item_familygroup_hist_1
   generated from Powerdesigner on Montag, 9. Oktober 2023 16:39:17
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_FAMILYGROUP_HIST_1 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT;
            CBX: Static 7 (Stiftung);
            ESB: Static 7 (Stiftung);',
   item_fam_grp_sid                    NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key ITEM_1 FAMILYGROUP;
            CBX: Item.ldlArticleGroup.custText1;
            ESB: cbxItem.itemFamilyGroup.code;',
   sub_item_grp_sid                    NUMBER(38,0)     COMMENT 'Subitemgroup; FK auf SUBITEMGROUP;
            SAP-Retail: wrf_matgrp_struc.parent;
            SAP-BW: z_ds_wrf_matgrp_struc.parent;
            CBX: NULL;
            ESB: NULL;',
   sub_item_grp_cd                     VARCHAR(20)      COMMENT 'Knotennummer der Suitemgroup aus SAP-Hierachie (= t_subitemgroup.src_node);
            SAP-Retail: wrf_matgrp_struc.parent;
            SAP-BW: z_ds_wrf_matgrp_struc.parent;
            CBX: Item.ldlArticleGroup.custText5;
            ESB: cbxItem.itemFamilyGroup.groupCode;',
   mdm_assortment_area_id              NUMBER(38,0)     COMMENT 'code of the NFPO assortment area
            CBX:  CNT_CODELIST.CUSTOM_FIELD_TEXT5  (code list ''REPORT_AF_PILLAR_PRODUCTCATEGORY'')',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Item_1 Familygroup ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_FAMILYGROUP_HIST PRIMARY KEY (item_fam_grp_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. FAMGH; 2. Ebene der Artikelhierarchie. Direkt oberhalb des Artikels;';
