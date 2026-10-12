/* --------------------------------------------------------------------------------
   DDL for table: t_item_promotion
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_PROMOTION CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT
            APT: Land',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key ITEM (eindeutig ueber alle Laender/Mandanten hinweg)
            APT: Int. Artikelnummer
            DWH2.0: src_article_nr',
   promotion_dt                        DATE             NOT NULL COMMENT 'Startday in which the article is beeing promoted
            APT:Werbetag',
   promotion_cy_week                   NUMBER(38,0)     NOT NULL COMMENT 'Calender Week in which the item is promoted (e.g. KW 08); dependent on promotion_dt
             APT: Planungsebene
            APT: Planungsebene',
   promotion_busyear                   NUMBER(38,0)     NOT NULL COMMENT 'Business/Fiscal Year in which the item is promoted; dependent on promotion_dt
            APT: GJ 
            APT: GJ ',
   promotion_end_dt                    DATE             COMMENT 'Endday in which the article is being promoted, only set for PV Promotions
            APT:gueltig_bis',
   advertising_campaign                VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Is the more abstract view of the Advertisment for the theme (e.g. "International Week")
            APT: Kampagne',
   advertising_theme                   VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Theme of the Advertisement more specific of campaign ( e.g. "greek week", "itialian week")
            APT: Thema',
   advertising_group                   VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Articlegroup (abstract) Food gesamt or Non Food
            APT: Aktionsbereich',
   advertising_sub_group               VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Article sub group (specific) (e.g. Hartware, bakeoff)
            APT: Aktionsunterbereich',
   turnover_plan_val                   NUMBER(18,5)     COMMENT 'Planned revenue on promotion
            APT: Umsatz op. Plan nto. Neu
            ',
   item_sid_prev_promotion             NUMBER(38,0)     COMMENT 'Surrogate Key ITEM predecessor. It is the item that is used as reference for sales, in case the promoted item has not been sold before
            APT: Vorgaenger',
   promotion_time_prev_promotion       VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Timeperiod in which the predecessor was promoted, can be CW Year or Month  Year
            APT: Vorgaenger WT ',
   sales_price                         NUMBER(18,5)     COMMENT 'Salesprice of the item during the promotion
            APT: VKP (Verkaufspreis)',
   sales_price_orig                    NUMBER(18,5)     COMMENT 'Original Sales Price of the item, i.e. the item was sold at this price before the promotion. The Original Sales Price is not always defined for every promoted Item e.g. for "In/Out" Items
            APT: VK (alt)',
   sales_price_comment                 VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Comment on sales price
            APT: VK Bemerkung',
   promotion_comment                   VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Generell comment of promotion
            APT: Bermerkung Werbung',
   item_list_type                      VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Describes whether the article which is advertised is in stock(Sortiment) or is only included for advertising in the assortment ( In/Out)
            APT: Listungsart',
   promotion_store_placement_int       VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Additional Information where the Item wil be promoted in the Store (e.g. "Gondelkopf" or "1. Gang")
            APT:Filialplatzierung INT',
   promotion_store_placement_nat       VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Additional Information where the Item wil be promoted in the Store (e.g. "Gondelkopf" or "1. Gang")
            APT:Filialplatzierung NAT',
   promotion_type_int                  VARCHAR(100)     COLLATE 'en-ci' COMMENT 'classification of promotions defined by Stiftung (e.g. "Supersamstag", "Neueroffnung")
            APT: Aktionsart INT',
   promotion_type_nat                  VARCHAR(100)     COLLATE 'en-ci' COMMENT 'classification of promotions defined by LIDL-Country as oppose to promotion_type_int (e.g. "Soft-PV", "LIDL-Weekend")
            APT: Aktionsart NAT',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Datensatz ist im Falle deleted_fg = 1 wenn es nicht mehr im Quellsystem bekannt ist',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_PROMOTION PRIMARY KEY (client_id, item_sid, promotion_dt) NOT ENFORCED 
)  COMMENT = 'Describes the begin date of a promotion for an item, i.e. when an item (regular assortment or specific for the promotion) is sold for a lower price.
             APT';

