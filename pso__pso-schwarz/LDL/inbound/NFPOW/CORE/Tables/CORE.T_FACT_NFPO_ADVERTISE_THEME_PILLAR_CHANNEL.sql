/* --------------------------------------------------------------------------------
   DDL for table: t_fact_nfpo_advertise_theme_pillar_channel
   generated from Powerdesigner on Donnerstag, 14. März 2024 14:53:20
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_NFPO_ADVERTISE_THEME_PILLAR_CHANNEL DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_adv_theme_sid                  NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO ADVERTISING THEME.
            CBX: CNT_PROJECT.REF_NO
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.MDM_AD_THEME_SID',
   nfpo_pillar_sid                     NUMBER(38,0)     NOT NULL COMMENT 'surrogate key, identifier of the pillar in CBX, alternative item grouping, groups item family groups
            CBX:Item/ldlPillar
            ESB:cbxItem/pillar',
   nfpo_main_pillar_cd                 VARCHAR(100)     NOT NULL COMMENT 'code of the main pillar
            CBX: CNT_CODELIST.CODE (code list ''PRODUCT_CATEGORY'')',
   sales_channel_cd                    VARCHAR(100)     NOT NULL COMMENT 'Code for the sales channel.',
   nfpo_total_item_org_order_qty       NUMBER(38,5)     COMMENT 'Bestellmentge aus CBX',
   nfpo_adv_stock_qty                  NUMBER(38,5)     COMMENT 'Aktionsmenge WT aus Sparte',
   nfpo_adv_store_cnt                  NUMBER(38,0)     COMMENT 'Filialanzahl in der Aktion (errechnet)',
   nfpo_adjust_adv_sales_0_qty         NUMBER(38,5)     COMMENT 'Vorbestellungen vor WT',
   nfpo_adjust_adv_sales_1_qty         NUMBER(38,5)     COMMENT 'Abverkauf bereinigt kumuliert bis WT',
   nfpo_adjust_adv_sales_3_qty         NUMBER(38,5)     COMMENT 'Abverkauf bereinigt kumuliert bis WT+2',
   nfpo_adjust_adv_sales_7_qty         NUMBER(38,5)     COMMENT 'Abverkauf bereinigt kumuliert bis WT+6',
   nfpo_adjust_adv_sales_14_qty        NUMBER(38,5)     COMMENT 'Abverkauf bereinigt kumuliert bis WT+13',
   nfpo_adjust_adv_sales_21_qty        NUMBER(38,5)     COMMENT 'Abverkauf bereinigt kumuliert bis WT+20',
   nfpo_total_adjust_adv_sales_qty     NUMBER(38,5),
   nfpo_adjust_adv_return_0_qty        NUMBER(38,5)     COMMENT 'Rückgaben vor WT (sollte immer 0 sein, evtl. Stornierungen für OS)',
   nfpo_adjust_adv_return_1_qty        NUMBER(38,5)     COMMENT 'Rückgaben bis WT',
   nfpo_adjust_adv_return_3_qty        NUMBER(38,5)     COMMENT 'Rückgaben bis WT+2',
   nfpo_adjust_adv_return_7_qty        NUMBER(38,5)     COMMENT 'Rückgaben bis WT+6',
   nfpo_adjust_adv_return_14_qty       NUMBER(38,5)     COMMENT 'Rückgaben bis WT+13',
   nfpo_adjust_adv_return_21_qty       NUMBER(38,5)     COMMENT 'Rückgaben bis WT+20',
   nfpo_adjust_adv_sales_0_net_euro_val NUMBER(38,5)     COMMENT 'Nettowert Vorbestellungen vor WT',
   nfpo_adjust_adv_sales_1_net_euro_val NUMBER(38,5)     COMMENT 'Nettoumsatz bereinigt bis WT',
   nfpo_adjust_adv_sales_3_net_euro_val NUMBER(38,5)     COMMENT 'Nettoumsatz bereinigt bis WT+2',
   nfpo_adjust_adv_sales_7_net_euro_val NUMBER(38,5)     COMMENT 'Nettoumsatz bereinigt bis WT+6',
   nfpo_adjust_adv_sales_14_net_euro_val NUMBER(38,5)     COMMENT 'Nettoumsatz bereinigt bis WT+13',
   nfpo_adjust_adv_sales_21_net_euro_val NUMBER(38,5)     COMMENT 'Nettoumsatz bereinigt bis WT+20',
   nfpo_total_adjust_adv_sales_net_euro_val NUMBER(38,5),
   nfpo_total_adjust_adv_sales_gross_euro_val NUMBER(38,5),
   nfpo_adv_sales_7_margin_euro_val    NUMBER(38,5)     COMMENT 'EK-Kalk-Volumen realisiert bis WT+6',
   nfpo_expected_item_org_order_purch_net_euro_price NUMBER(38,5)     COMMENT 'erwarteter EK-Preis (ermittelt mit Durchfallogik) Komponenten müssen da sein!
            WBP Land:nfpo_item_org_order_purch_net_euro_price
            WBP Land DE Stationär:nfpo_item_de_order_purch_net_euro_price
            WBP Artikel:nfpo_item_order_purch_net_euro_price
            EK01:Scenario 1:  nfpo_item_selection_purch_net_euro_price',
   nfpo_expected_item_org_order_purch_net_euro_val NUMBER(38,5)     COMMENT 'Einkaufsvolumen erwartet: Bestellmenge * erwarteter EK-Preis, von org level aggregiert',
   nfpo_min_target_sales_gross_euro_price NUMBER(38,5)     COMMENT 'ZVP aus CBX am Artikel',
   nfpo_expected_item_org_order_sales_net_euro_val NUMBER(38,5)     COMMENT 'Verkaufsvolumen erwartet: Bestellmenge * erwarteter VK-Preis',
   nfpo_expected_item_org_order_margin_rate NUMBER(38,5)     COMMENT 'Erwartete marge: 80: aus EK aktuell, ZVP und VAT-Rate (fest 19%). Gewicht bei Aggregation:Bestellmenge',
   nfpo_item_org_order_purch_net_euro_price NUMBER(38,5)     COMMENT 'WBP aus CBX pro Artikel und  Land',
   nfpo_planned_item_org_order_purch_net_euro_val NUMBER(38,5)     COMMENT 'WBP Land (ohne Durchfalllogik) * Bestellmenge: ''EK Volumen''',
   nfpo_avg_adv_sales_gross_euro_price NUMBER(38,5)     COMMENT 'Durchschnitts-Bruttoverkaufspreis WT gesamt',
   nfpo_avg_adv_sales_margin_rate      NUMBER(38,5)     COMMENT 'Durchschnitts-EK-Kalk-Rate realisiert WT gesamt, Aggregation mit Gewichtung Aktionsmenge!',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_BUYER.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_BUYER.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_FACT_NFPO_ADVERTISE_THEME_PILLAR_CHANNEL PRIMARY KEY (nfpo_adv_theme_sid, nfpo_pillar_sid, nfpo_main_pillar_cd, sales_channel_cd) NOT ENFORCED 
)  COMMENT = 'This fact table holds aggregated metrics on the level advertise theme, pillar, main pillar and sales channel. It is the basis for theme level reporting without item details.';
