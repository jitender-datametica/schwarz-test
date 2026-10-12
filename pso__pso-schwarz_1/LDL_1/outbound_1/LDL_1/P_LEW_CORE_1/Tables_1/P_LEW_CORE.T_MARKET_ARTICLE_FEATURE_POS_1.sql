CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_article_feature_pos_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
region_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Region_1; FK auf REGION_1'),
period_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Periode; FK auf PERIOD'),
assort_cat_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kategorie; FK auf ASSORT_CATEGORY'),
assort_cat_family_sid BIGNUMERIC(38,0) OPTIONS(description='Category Family; FK to ASSORT_CATEGORY.'),
assort_cat_subfamily_sid BIGNUMERIC(38,0) OPTIONS(description='Category SubFamily; FK to ASSORT_CATEGORY.'),
curr_cd STRING(160) NOT NULL OPTIONS(description='Basiswaehrung fuer Waehrungsumrechnung; FK auf CURRENCY'),
rank_pos BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ranking des Produkts'),
product_name STRING(2400) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Produktnamens'),
manufacturer STRING(2400) COLLATE 'und:ci' OPTIONS(description='Hersteller des Produkts'),
brand_1 STRING(800) COLLATE 'und:ci' OPTIONS(description='Produktmarke'),
brand_type_txt STRING(1000)
OPTIONS(description='Text description in local language of the Item_1 / Article Brand_1 with regards to its market positioning.            - Marke i.e. normal overall retail market brand_1             - Eigenmarke/Handelsmarke (brand_1 created and distributed by specific retailer, i.e. Lidl, ALDI or DM)            - Rest - other brands or Unknown            In other languages values may differ.'),
pack_size STRING(800) COLLATE 'und:ci' OPTIONS(description='Packungsgroesse des referenzierten Produkts'),
ean_1 STRING(32000) COLLATE 'und:ci' OPTIONS(description='EAN_1 (europaeische Artikelnummer) des Produkts'),
category_family STRING(2400) COLLATE 'und:ci' OPTIONS(description='Family-Kategorie (FAM)'),
category_subfamily_name STRING(100)
OPTIONS(description='Assortment Category Subfamily Name - most detailed level of Assortment Category Hierarchy.            i.e.:            - Category UWG 81 Cosmetics            - Category Family 50 Oralcare            - Category Subfamily 53 Toothpaste'),
feature1_content STRING(2400) COLLATE 'und:ci' OPTIONS(description='Zusaetzliche Produktmerkmale'),
feature2_content STRING(2400) COLLATE 'und:ci' OPTIONS(description='Zusaetzliche Produktmerkmale'),
feature3_content STRING(2400) COLLATE 'und:ci' OPTIONS(description='Zusaetzliche Produktmerkmale'),
feature4_content STRING(2400) COLLATE 'und:ci' OPTIONS(description='Zusaetzliche Produktmerkmale'),
feature5_content STRING(2400) COLLATE 'und:ci' OPTIONS(description='Zusaetzliche Produktmerkmale'),
feature6_content STRING(2400) COLLATE 'und:ci' OPTIONS(description='Zusaetzliche Produktmerkmale'),
feature7_content STRING(2400) COLLATE 'und:ci' OPTIONS(description='Zusaetzliche Produktmerkmale'),
feature8_content STRING(2400) COLLATE 'und:ci' OPTIONS(description='Zusaetzliche Produktmerkmale'),
feature9_content STRING(2400) COLLATE 'und:ci' OPTIONS(description='Zusaetzliche Produktmerkmale'),
feature10_content STRING(2400) COLLATE 'und:ci' OPTIONS(description='Zusaetzliche Produktmerkmale'),
feature11_content STRING(2400) COLLATE 'und:ci' OPTIONS(description='Zusaetzliche Produktmerkmale'),
feature12_content STRING(2400) COLLATE 'und:ci' OPTIONS(description='Zusaetzliche Produktmerkmale'),
feature13_content STRING(2400) COLLATE 'und:ci' OPTIONS(description='Zusaetzliche Produktmerkmale'),
feature14_content STRING(2400) COLLATE 'und:ci' OPTIONS(description='Zusaetzliche Produktmerkmale'),
turnover_val NUMERIC(18,5) OPTIONS(description='Hochgerechneter Umsatz'),
turnover_prom_val NUMERIC(18,5) OPTIONS(description='Werbevermarktung des jeweiligen Produkts'),
promotion_share_pct NUMERIC(18,5) OPTIONS(description='Anteil der Promotion an dem Gesamtumsatzl'),
trip_cnt NUMERIC(18,5)
OPTIONS(description='Die Anzahl aller Kassenbons (Besuche), die waehrend eines Zeitraums durch den Kauf der Warengruppe/des Produkts durch die Shopper_1 entstanden sind'),
buyer_cnt NUMERIC(18,5)
OPTIONS(description='Die Person, die die Produkte tatsaechlich im Geschaeft kauft. Ein Kaeufer ist nicht unbedingt der Verbraucher, d.h. der Kaeufer kauft Tiernahrung, konsumiert sie aber nicht'),
extrapol_package_cnt NUMERIC(18,5) OPTIONS(description='Extrapoliertes Volumen in Packungen'),
avg_price_per_pack_val NUMERIC(18,5) OPTIONS(description='Durchschnittspreis, der pro Packung erzielt wird'),
packs_per_trip_cnt NUMERIC(18,5) OPTIONS(description='Verkaufte Anzahl Packungen pro Besuch'),
penetrate_cum_abs_pct NUMERIC(18,5)
OPTIONS(description='Prozentsatz der Lidl-Kunden, die mit diesem Produkt und allen Produkten vorher erreicht werden konne (Produktranking => siehe seq)'),
penetrate_cum_rel_pct NUMERIC(18,5)
OPTIONS(description='Prozentsatz der Kaeufer, die dieses Produkt oder eines der oben genannten Produkte kaufen (Produktranking => siehe seq)'),
penetrate_diff_cum_rel_pct NUMERIC(18,5)
OPTIONS(description='Prozentsatz der Kaeufer, die dieses Produkt kaufen. Differenz zwischen der "kumulierten Kaeuferdurchdringung" dieser Zeile und der Zeile davor (Produktranking => siehe seq)'),
penetrate_single_rel_pct NUMERIC(18,5)
OPTIONS(description='Prozentsatz der Kaeufer (von Anzahl der Kaeufer im Sortiment), die dieses Produkt mindestens einmal gekauft haben'),
penetrate_exclusive_rel_pct NUMERIC(18,5)
OPTIONS(description='Prozentsatz der Kaeufer (von Anzahl der Kaeufer im Sortiment), die dieses Produkt ausschliesslich gekauft haben'),
exclusive_buyer_assortment_pct NUMERIC(18,5)
OPTIONS(description='Prozentsatz der Kaeufer, die dieses Produkt gekauft haben, und kein Produkt des Rankings vorher'),
assortment_depth_per_buyer_cnt NUMERIC(18,5)
OPTIONS(description='Anzahl der Produkte, die im Durchschnitt von den oben genannten Produkten gekauft wurden, von Kaeufern, die dieses Produkt gekauft haben'),
turnover_cum_all_pct NUMERIC(18,5)
OPTIONS(description='Kumulierter Wert aller Produkte, die von Kaeufern gekauft wurden, die dieses Produkt oder eines der oben genannten Produkte gekauft haben (Produktranking => siehe seq), im Verhaeltnis zum Gesamtwert der gesamten Kategorie'),
turnover_cum_product_pct NUMERIC(18,5)
OPTIONS(description='Kumulierter Wert des Produkts oder eines der oben genannten Produkte (Produktranking => siehe seq) im Verhaeltnis zum Gesamtwert der gesamten Kategorie'),
total_market_turnover_val NUMERIC(18,5),
total_market_promotion_share_pct NUMERIC(18,5),
total_market_extrapol_package_cnt NUMERIC(18,5),
lidl_turnover_val NUMERIC(18,5),
lidl_promotion_share_pct NUMERIC(18,5),
lidl_extrapol_package_cnt NUMERIC(18,5),
competitor1_turnover_val NUMERIC(18,5),
competitor1_promotion_share_pct NUMERIC(18,5),
competitor1_extrapol_package_cnt NUMERIC(18,5),
competitor2_turnover_val NUMERIC(18,5),
competitor2_promotion_share_pct NUMERIC(18,5),
competitor2_extrapol_package_cnt NUMERIC(18,5),
retailer_sid_comp1 BIGNUMERIC(38,0) OPTIONS(description='Einzelhaendler; FK auf RETAILER'),
retailer_sid_comp2 BIGNUMERIC(38,0) OPTIONS(description='Einzelhaendler; FK auf RETAILER'),
weight_type_txt STRING(1000)
OPTIONS(description='Text in local language defines whether specific article / item_1 being sold in the retail store as a piece or a custom weight quantity.            i.e.            - Packs             - Kilogram/Gram            '),
deleted_fg BIGNUMERIC(38,0) OPTIONS(description='0/1-Flag; 1 = Satz ist nicht korrekt; 0 = Satz ist korrekt'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat'),
dwh_created TIMESTAMP NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung'),
dwh_updated TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten fachlichen(!) Aenderung'),
PRIMARY KEY (client_id, region_sid, period_sid, assort_cat_sid, rank_pos) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $ Marktforschungsanalyse auf Artikelbasis');