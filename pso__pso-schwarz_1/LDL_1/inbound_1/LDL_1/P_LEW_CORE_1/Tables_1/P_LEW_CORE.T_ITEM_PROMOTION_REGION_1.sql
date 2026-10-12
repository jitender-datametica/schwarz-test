/* --------------------------------------------------------------------------------
   DDL for table: t_item_promotion_region_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_PROMOTION_REGION_1 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT
            APT: Land_1',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key ITEM_1 (eindeutig ueber alle Laender/Mandanten hinweg)
            APT: Int. Artikelnummer
            DWH2.0: src_article_nr',
   promotion_dt                        DATE             NOT NULL COMMENT 'Startday in which the article is beeing advertised
            APT: Werbetag',
   region_cd                           VARCHAR(100)     NOT NULL COLLATE 'en-ci' COMMENT 'Region_1 where the Article will be advertised (Short Term of Region_1 in WFM) e.g. "SEZ", "WEI"
            APT: Werberegion',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Datensatz ist im Falle deleted_fg = 1 wenn es nicht mehr im Quellsystem bekannt ist',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_PROMOTION_REGION PRIMARY KEY (client_id, item_sid, promotion_dt, region_cd) NOT ENFORCED 
)  COMMENT = 'Region_1 Relation to the promoted Item_1
             APT: Werberegion';

