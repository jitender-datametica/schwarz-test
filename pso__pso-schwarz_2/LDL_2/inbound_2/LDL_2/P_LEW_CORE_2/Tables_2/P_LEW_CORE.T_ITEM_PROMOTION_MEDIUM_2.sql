/* --------------------------------------------------------------------------------
   DDL for table: t_item_promotion_medium_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_PROMOTION_MEDIUM_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT
            APT: Land_2',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key ITEM_2 (eindeutig ueber alle Laender/Mandanten hinweg)
            APT: Int. Artikelnummer
            DWH2.0: src_article_nr',
   promotion_dt                        DATE             NOT NULL COMMENT 'Startday in which the article is beeing advertised
            APT: Werbetag',
   advertising_medium_cd               VARCHAR(100)     NOT NULL COLLATE 'en-ci' COMMENT 'Medium in which the article is advertised, e.g. "Handzettel", "instore", "online"
            APT: Werbemittel',
   advertising_medium_pos              VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Position of advertising in the medium (e.g. Page Number in which the item_2 is beeing promoted in the Medium)
            APT: Position Werbemittel',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Datensatz ist im Falle deleted_fg = 1 wenn es nicht mehr im Quellsystem bekannt ist',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_PROMOTION_MEDIUM PRIMARY KEY (client_id, item_sid, promotion_dt, advertising_medium_cd) NOT ENFORCED 
)  COMMENT = 'Medium Relation to the promoted Item_2
             APT: Werbemittel';

