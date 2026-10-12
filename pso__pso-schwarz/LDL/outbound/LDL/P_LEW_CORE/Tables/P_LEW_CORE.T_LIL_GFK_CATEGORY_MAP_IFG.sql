/* --------------------------------------------------------------------------------
   DDL for table: t_lil_gfk_category_map_ifg
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_lil_gfk_category_map_ifg (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
gfk_cat_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kategorie; FK auf GFK_CATEGORY'),
sub_item_grp_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Subitemgroup; FK auf SUBITEMGROUP'),
item_fam_grp_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Item Familygroup; FK auf ITEM_FAMILYGROUP'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten fachlichen(!) Aenderung'),
PRIMARY KEY (gfk_cat_sid, sub_item_grp_sid, item_fam_grp_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $ Mapping-Tabelle zur Verbindung von GfK-Kategorien und Lidl-internen Kategorien auf Familygroup-Ebene');