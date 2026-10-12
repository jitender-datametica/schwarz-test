CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_ITEM_FAMILYGROUP_HIST_1
(
   client_id                            COMMENT 'DWH-Mandant_1; FK auf CLIENT;
            CBX: Static 7 (Stiftung);
            ESB: Static 7 (Stiftung);'
   ,item_fam_grp_sid                    COMMENT 'Surrogate Key ITEM_1 FAMILYGROUP;
            CBX: Item.ldlArticleGroup.custText1;
            ESB: cbxItem.itemFamilyGroup.code;'
   ,sub_item_grp_sid                    COMMENT 'Subitemgroup; FK auf SUBITEMGROUP;
            SAP-Retail: wrf_matgrp_struc.parent;
            SAP-BW: z_ds_wrf_matgrp_struc.parent;
            CBX: NULL;
            ESB: NULL;'
   ,sub_item_grp_cd                     COMMENT 'Knotennummer der Suitemgroup aus SAP-Hierachie (= t_subitemgroup.src_node);
            SAP-Retail: wrf_matgrp_struc.parent;
            SAP-BW: z_ds_wrf_matgrp_struc.parent;
            CBX: Item.ldlArticleGroup.custText5;
            ESB: cbxItem.itemFamilyGroup.groupCode;'
   ,mdm_assortment_area_id              COMMENT 'code of the NFPO assortment area
            CBX:  CNT_CODELIST.CUSTOM_FIELD_TEXT5  (code list ''REPORT_AF_PILLAR_PRODUCTCATEGORY'')'
   ,deleted_fg                          COMMENT 'Item_1 Familygroup ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen'
   ,dwh_valid_from                      COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'
   ,dwh_valid_to                        COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'
   ,dwh_load_id                         COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'
   ,dwh_created                         COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'
   ,dwh_updated                         COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH'
) COMMENT = '$Revision: 0000 $. FAMGH; 2. Ebene der Artikelhierarchie. Direkt oberhalb des Artikels;'
AS 
    SELECT 
        client_id
        ,item_fam_grp_sid
        ,sub_item_grp_sid
        ,sub_item_grp_cd
        ,mdm_assortment_area_id
        ,deleted_fg
        ,dwh_valid_from
        ,dwh_valid_to
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated

FROM P_LEW_CORE.T_ITEM_FAMILYGROUP_HIST_1 ;
