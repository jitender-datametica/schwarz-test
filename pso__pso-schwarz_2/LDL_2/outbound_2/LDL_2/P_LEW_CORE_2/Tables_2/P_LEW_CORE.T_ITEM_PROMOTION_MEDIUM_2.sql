/* --------------------------------------------------------------------------------
   DDL for table: t_item_promotion_medium_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_promotion_medium_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT            APT: Land_2'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key ITEM_2 (eindeutig ueber alle Laender/Mandanten hinweg)            APT: INTEGER . Artikelnummer            DWH2.0: src_article_nr'),
promotion_dt DATE NOT NULL
OPTIONS(description='Startday in which the article is beeing advertised            APT: Werbetag'),
advertising_medium_cd STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Medium in which the article is advertised, e.g. "Handzettel", "instore", "online"            APT: Werbemittel'),
advertising_medium_pos STRING(100) COLLATE 'und:ci'
OPTIONS(description='Position of advertising in the medium (e.g. Page Number in which the item_2 is beeing promoted in the Medium)            APT: Position Werbemittel'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Datensatz ist im Falle deleted_fg = 1 wenn es nicht mehr im Quellsystem bekannt ist'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (client_id, item_sid, promotion_dt) NOT ENFORCED
) OPTIONS(description='Medium Relation to the promoted Item_2             APT: Werbemittel');