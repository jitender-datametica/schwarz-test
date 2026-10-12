/* --------------------------------------------------------------------------------
   DDL for table: t_item_promotion
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_promotion (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT            APT: Land'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key ITEM (eindeutig ueber alle Laender/Mandanten hinweg)            APT: INTEGER . Artikelnummer            DWH2.0: src_article_nr'),
promotion_dt DATE NOT NULL
OPTIONS(description='Startday in which the article is beeing promoted            APT:Werbetag'),
promotion_cy_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Calender Week in which the item is promoted (e.g. KW 08); dependent on promotion_dt             APT: Planungsebene            APT: Planungsebene'),
promotion_busyear BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Business/Fiscal Year in which the item is promoted; dependent on promotion_dt            APT: GJ             APT: GJ '),
promotion_end_dt DATE
OPTIONS(description='Endday in which the article is being promoted, only set for PV Promotions            APT:gueltig_bis'),
advertising_campaign STRING(100) COLLATE 'und:ci'
OPTIONS(description='Is the more abstract view of the Advertisment for the theme (e.g. "International Week")            APT: Kampagne'),
advertising_theme STRING(100) COLLATE 'und:ci'
OPTIONS(description='Theme of the Advertisement more specific of campaign ( e.g. "greek week", "itialian week")            APT: Thema'),
advertising_group STRING(100) COLLATE 'und:ci'
OPTIONS(description='Articlegroup (abstract) Food gesamt or Non Food            APT: Aktionsbereich'),
advertising_sub_group STRING(100) COLLATE 'und:ci'
OPTIONS(description='Article sub group (specific) (e.g. Hartware, bakeoff)            APT: Aktionsunterbereich'),
turnover_plan_val NUMERIC(18,5)
OPTIONS(description='Planned revenue on promotion            APT: Umsatz op. Plan nto. Neu            '),
item_sid_prev_promotion BIGNUMERIC(38,0)
OPTIONS(description='Surrogate Key ITEM predecessor. It is the item that is used as reference for sales, in case the promoted item has not been sold before            APT: Vorgaenger'),
promotion_time_prev_promotion STRING(20) COLLATE 'und:ci'
OPTIONS(description='Timeperiod in which the predecessor was promoted, can be CW Year or Month  Year            APT: Vorgaenger WT '),
sales_price NUMERIC(18,5)
OPTIONS(description='Salesprice of the item during the promotion            APT: VKP (Verkaufspreis)'),
sales_price_orig NUMERIC(18,5)
OPTIONS(description='Original Sales Price of the item, i.e. the item was sold at this price before the promotion. The Original Sales Price is not always defined for every promoted Item e.g. for "In/Out" Items            APT: VK (alt)'),
sales_price_comment STRING(100) COLLATE 'und:ci'
OPTIONS(description='Comment on sales price            APT: VK Bemerkung'),
promotion_comment STRING(100) COLLATE 'und:ci'
OPTIONS(description='Generell comment of promotion            APT: Bermerkung Werbung'),
item_list_type STRING(100) COLLATE 'und:ci'
OPTIONS(description='Describes whether the article which is advertised is in stock(Sortiment) or is only included for advertising in the assortment ( In/Out)            APT: Listungsart'),
promotion_store_placement_int STRING(100) COLLATE 'und:ci'
OPTIONS(description='Additional Information where the Item wil be promoted in the Store (e.g. "Gondelkopf" or "1. Gang")            APT:Filialplatzierung INTEGER '),
promotion_store_placement_nat STRING(100) COLLATE 'und:ci'
OPTIONS(description='Additional Information where the Item wil be promoted in the Store (e.g. "Gondelkopf" or "1. Gang")            APT:Filialplatzierung NAT'),
promotion_type_int STRING(100) COLLATE 'und:ci'
OPTIONS(description='classification of promotions defined by Stiftung (e.g. "Supersamstag", "Neueroffnung")            APT: Aktionsart INTEGER '),
promotion_type_nat STRING(100) COLLATE 'und:ci'
OPTIONS(description='classification of promotions defined by LIDL-Country as oppose to promotion_type_int (e.g. "Soft-PV", "LIDL-Weekend")            APT: Aktionsart NAT'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Datensatz ist im Falle deleted_fg = 1 wenn es nicht mehr im Quellsystem bekannt ist'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (client_id, item_sid, promotion_dt) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Describes the begin date of a promotion for an item, i.e. when an item (regular assortment or specific for the promotion) is sold for a lower price.             APT');