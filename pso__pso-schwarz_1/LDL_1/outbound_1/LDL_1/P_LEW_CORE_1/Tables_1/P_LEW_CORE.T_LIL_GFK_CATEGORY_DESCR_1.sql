/* --------------------------------------------------------------------------------
   DDL for table: t_lil_gfk_category_descr_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_lil_gfk_category_descr_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the client'),
gfk_cat_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key GFK_CATEGORY'),
lang_cd STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Sprache - Code'),
gfk_cat_name STRING(100) COLLATE 'und:ci' OPTIONS(description='Beschreibung GfK-Sub-Kategorie'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten fachlichen(!) Aenderung'),
PRIMARY KEY (gfk_cat_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $ Mehrsprachige Bezeichnungen der Warengruppen-Kategorien fur t_market_subgroup_1 und t_market_household_loyalty_1');