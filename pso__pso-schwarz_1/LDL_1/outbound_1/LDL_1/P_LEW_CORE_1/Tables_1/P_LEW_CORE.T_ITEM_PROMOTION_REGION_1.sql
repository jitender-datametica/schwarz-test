/* --------------------------------------------------------------------------------
   DDL for table: t_item_promotion_region_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_promotion_region_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT            APT: Land_1'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key ITEM_1 (eindeutig ueber alle Laender/Mandanten hinweg)            APT: INTEGER . Artikelnummer            DWH2.0: src_article_nr'),
promotion_dt DATE NOT NULL
OPTIONS(description='Startday in which the article is beeing advertised            APT: Werbetag'),
region_cd STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Region_1 where the Article will be advertised (Short Term of Region_1 in WFM) e.g. "SEZ", "WEI"            APT: Werberegion'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Datensatz ist im Falle deleted_fg = 1 wenn es nicht mehr im Quellsystem bekannt ist'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (client_id, item_sid, promotion_dt) NOT ENFORCED
) OPTIONS(description='Region_1 Relation to the promoted Item_1             APT: Werberegion');