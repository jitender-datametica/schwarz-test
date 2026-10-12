/* --------------------------------------------------------------------------------
   DDL for table: t_lil_gfk_category_map_sig_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_lil_gfk_category_map_sig_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
gfk_cat_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kategorie; FK auf GFK_CATEGORY'),
sub_item_grp_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Subitemgroup; FK auf SUBITEMGROUP'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten fachlichen(!) Aenderung'),
PRIMARY KEY (gfk_cat_sid, sub_item_grp_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $ Mapping-Tabelle zur Verbindung von GfK-Kategorien und Lidl-internen Kategorien auf Subitemgroup-Ebene');