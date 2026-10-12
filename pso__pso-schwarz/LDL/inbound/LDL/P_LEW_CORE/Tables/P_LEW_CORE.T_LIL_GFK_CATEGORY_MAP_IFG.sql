/* --------------------------------------------------------------------------------
   DDL for table: t_lil_gfk_category_map_ifg
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_LIL_GFK_CATEGORY_MAP_IFG CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   gfk_cat_sid                         NUMBER(38,0)     NOT NULL COMMENT 'Kategorie; FK auf GFK_CATEGORY',
   sub_item_grp_sid                    NUMBER(38,0)     NOT NULL COMMENT 'Subitemgroup; FK auf SUBITEMGROUP',
   item_fam_grp_sid                    NUMBER(38,0)     NOT NULL COMMENT 'Item Familygroup; FK auf ITEM_FAMILYGROUP',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten fachlichen(!) Aenderung',   
   CONSTRAINT PK_T_LIL_GFK_CATEGORY_MAP_IFG PRIMARY KEY (gfk_cat_sid, sub_item_grp_sid, item_fam_grp_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $ Mapping-Tabelle zur Verbindung von GfK-Kategorien und Lidl-internen Kategorien auf Familygroup-Ebene';

