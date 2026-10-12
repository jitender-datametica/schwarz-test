/* --------------------------------------------------------------------------------
   DDL for table: t_lil_gfk_category_map_sig
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_LIL_GFK_CATEGORY_MAP_SIG CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   gfk_cat_sid                         NUMBER(38,0)     NOT NULL COMMENT 'Kategorie; FK auf GFK_CATEGORY',
   sub_item_grp_sid                    NUMBER(38,0)     NOT NULL COMMENT 'Subitemgroup; FK auf SUBITEMGROUP',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten fachlichen(!) Aenderung',   
   CONSTRAINT PK_T_LIL_GFK_CATEGORY_MAP_SIG PRIMARY KEY (gfk_cat_sid, sub_item_grp_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $ Mapping-Tabelle zur Verbindung von GfK-Kategorien und Lidl-internen Kategorien auf Subitemgroup-Ebene';

