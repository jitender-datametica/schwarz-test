/* --------------------------------------------------------------------------------
   DDL for table: t_fact_nfpo_advertise_theme_pillar_channel_2
   generated from Powerdesigner on Donnerstag, 14. März 2024 14:53:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_fact_nfpo_advertise_theme_pillar_channel_2 (
nfpo_adv_theme_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''Surrogate Key NFPO ADVERTISING THEME.
            CBX: CNT_PROJECT.REF_NO
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.MDM_AD_THEME_SID'''),
nfpo_pillar_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''surrogate key, identifier of the pillar in CBX, alternative item_2 grouping, groups item_2 family groups
            CBX:Item_2/ldlPillar
            ESB:cbxItem/pillar'''),
nfpo_main_pillar_cd STRING(100) NOT NULL
OPTIONS(description='''code of the main pillar
            CBX: CNT_CODELIST.CODE (code list \'PRODUCT_CATEGORY\')'''),
sales_channel_cd STRING(100) NOT NULL OPTIONS(description='Code for the sales_2 channel.'),
nfpo_total_item_org_order_qty BIGNUMERIC(38,5) OPTIONS(description='Bestellmentge aus CBX'),
nfpo_adv_stock_qty BIGNUMERIC(38,5) OPTIONS(description='Aktionsmenge WT aus Sparte'),
nfpo_adv_store_cnt BIGNUMERIC(38,0) OPTIONS(description='Filialanzahl in der Aktion_2 (errechnet)'),
nfpo_adjust_adv_sales_0_qty BIGNUMERIC(38,5) OPTIONS(description='Vorbestellungen vor WT'),
nfpo_adjust_adv_sales_1_qty BIGNUMERIC(38,5) OPTIONS(description='Abverkauf bereinigt kumuliert bis WT'),
nfpo_adjust_adv_sales_3_qty BIGNUMERIC(38,5) OPTIONS(description='Abverkauf bereinigt kumuliert bis WT+2'),
nfpo_adjust_adv_sales_7_qty BIGNUMERIC(38,5) OPTIONS(description='Abverkauf bereinigt kumuliert bis WT+6'),
nfpo_adjust_adv_sales_14_qty BIGNUMERIC(38,5) OPTIONS(description='Abverkauf bereinigt kumuliert bis WT+13'),
nfpo_adjust_adv_sales_21_qty BIGNUMERIC(38,5) OPTIONS(description='Abverkauf bereinigt kumuliert bis WT+20'),
nfpo_total_adjust_adv_sales_qty BIGNUMERIC(38,5),
nfpo_adjust_adv_return_0_qty BIGNUMERIC(38,5)
OPTIONS(description='Rückgaben vor WT (sollte immer 0 sein, evtl. Stornierungen für OS)'),
nfpo_adjust_adv_return_1_qty BIGNUMERIC(38,5) OPTIONS(description='Rückgaben bis WT'),
nfpo_adjust_adv_return_3_qty BIGNUMERIC(38,5) OPTIONS(description='Rückgaben bis WT+2'),
nfpo_adjust_adv_return_7_qty BIGNUMERIC(38,5) OPTIONS(description='Rückgaben bis WT+6'),
nfpo_adjust_adv_return_14_qty BIGNUMERIC(38,5) OPTIONS(description='Rückgaben bis WT+13'),
nfpo_adjust_adv_return_21_qty BIGNUMERIC(38,5) OPTIONS(description='Rückgaben bis WT+20'),
nfpo_adjust_adv_sales_0_net_euro_val BIGNUMERIC(38,5) OPTIONS(description='Nettowert Vorbestellungen vor WT'),
nfpo_adjust_adv_sales_1_net_euro_val BIGNUMERIC(38,5) OPTIONS(description='Nettoumsatz bereinigt bis WT'),
nfpo_adjust_adv_sales_3_net_euro_val BIGNUMERIC(38,5) OPTIONS(description='Nettoumsatz bereinigt bis WT+2'),
nfpo_adjust_adv_sales_7_net_euro_val BIGNUMERIC(38,5) OPTIONS(description='Nettoumsatz bereinigt bis WT+6'),
nfpo_adjust_adv_sales_14_net_euro_val BIGNUMERIC(38,5) OPTIONS(description='Nettoumsatz bereinigt bis WT+13'),
nfpo_adjust_adv_sales_21_net_euro_val BIGNUMERIC(38,5) OPTIONS(description='Nettoumsatz bereinigt bis WT+20'),
nfpo_total_adjust_adv_sales_net_euro_val BIGNUMERIC(38,5),
nfpo_total_adjust_adv_sales_gross_euro_val BIGNUMERIC(38,5),
nfpo_adv_sales_7_margin_euro_val BIGNUMERIC(38,5) OPTIONS(description='EK-Kalk-Volumen realisiert bis WT+6'),
nfpo_expected_item_org_order_purch_net_euro_price BIGNUMERIC(38,5)
OPTIONS(description='''erwarteter EK-Preis (ermittelt mit Durchfallogik) Komponenten müssen da sein!
            WBP Land_2:nfpo_item_org_order_purch_net_euro_price
            WBP Land_2 DE Stationär:nfpo_item_de_order_purch_net_euro_price
            WBP Artikel_2:nfpo_item_order_purch_net_euro_price
            EK01_2:Scenario 1:  nfpo_item_selection_purch_net_euro_price'''),
nfpo_expected_item_org_order_purch_net_euro_val BIGNUMERIC(38,5)
OPTIONS(description='Einkaufsvolumen erwartet: Bestellmenge * erwarteter EK-Preis, von org level aggregiert'),
nfpo_min_target_sales_gross_euro_price BIGNUMERIC(38,5) OPTIONS(description='ZVP aus CBX am Artikel_2'),
nfpo_expected_item_org_order_sales_net_euro_val BIGNUMERIC(38,5)
OPTIONS(description='Verkaufsvolumen erwartet: Bestellmenge * erwarteter VK_2-Preis'),
nfpo_expected_item_org_order_margin_rate BIGNUMERIC(38,5)
OPTIONS(description='Erwartete marge: 80: aus EK aktuell, ZVP und VAT-Rate (fest 19%). Gewicht bei Aggregation:Bestellmenge'),
nfpo_item_org_order_purch_net_euro_price BIGNUMERIC(38,5) OPTIONS(description='WBP aus CBX pro Artikel_2 und  Land_2'),
nfpo_planned_item_org_order_purch_net_euro_val BIGNUMERIC(38,5)
OPTIONS(description='WBP Land_2 (ohne Durchfalllogik) * Bestellmenge: \'EK Volumen\''),
nfpo_avg_adv_sales_gross_euro_price BIGNUMERIC(38,5) OPTIONS(description='Durchschnitts-Bruttoverkaufspreis WT gesamt'),
nfpo_avg_adv_sales_margin_rate BIGNUMERIC(38,5)
OPTIONS(description='Durchschnitts-EK-Kalk-Rate realisiert WT gesamt, Aggregation mit Gewichtung Aktionsmenge!'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_BUYER.DWH_CREATED'''),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_BUYER.DWH_UPDATED'''),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_adv_theme_sid, nfpo_pillar_sid, nfpo_main_pillar_cd, sales_channel_cd) NOT ENFORCED
)
OPTIONS(description='This fact table holds aggregated metrics on the level advertise theme, pillar, main pillar and sales_2 channel. It is the basis for theme level reporting without item_2 details.');