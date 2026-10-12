/* --------------------------------------------------------------------------------
   DDL for table: t_fact_nfpo_item_local_organization_advertise_day_2
   generated from Powerdesigner on Friday, 3 May 2024 10:21:09
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_NFPO_ITEM_LOCAL_ORGANIZATION_ADVERTISE_DAY_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO ITEM_2 INSTANCE.
            CBX: CNT_ITEM.REF_NO
            LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_SID',
   nfpo_org_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key internal organization.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID',
   adv_dt                              DATE             NOT NULL COMMENT 'Werbetermin',
   adv_seq                             NUMBER(38,0)     COMMENT 'lfd Nr. Werbetermin zum Artikel_2 im Land_2',
   nfpo_total_item_org_order_qty       NUMBER(38,5)     COMMENT 'Bestellmenge CBX Artikel_2 Land_2',
   nfpo_pseudo_split_item_org_order_qty NUMBER(38,5)     COMMENT 'Nur formell geteilte Bestellmenge pro Werbetermin, CBX Artikel_2 Land. nfpo_total_item_org_order_qty / max(adv_seq)',
   nfpo_adv_stock_qty                  NUMBER(38,5)     COMMENT 'Aktionsmenge WT aus Sparte',
   nfpo_adv_store_cnt                  NUMBER(38,0)     COMMENT 'Filialanzahl in der Aktion_2 (errechnet)',
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
   nfpo_adv_sales_1_margin_euro_val    NUMBER(38,5)     COMMENT 'EK-Kalk-Volumen realisiert bis WT, Differenz aus net sales_2 value und net purch value. net purch value ist adjust sales_2 qty * item_org_order_purch_net_euro_price (WBP Land_2)',
   nfpo_adv_sales_3_margin_euro_val    NUMBER(38,5)     COMMENT 'EK-Kalk-Volumen realisiert bis WT+2, Differenz aus net sales_2 value und net purch value. net purch value ist adjust sales_2 qty * item_org_order_purch_net_euro_price (WBP Land_2)',
   nfpo_adv_sales_7_margin_euro_val    NUMBER(38,5)     COMMENT 'EK-Kalk-Volumen realisiert bis WT+6, Differenz aus net sales_2 value und net purch value. net purch value ist adjust sales_2 qty * item_org_order_purch_net_euro_price (WBP Land_2)',
   nfpo_adv_sales_14_margin_euro_val   NUMBER(38,5)     COMMENT 'EK-Kalk-Volumen realisiert bis WT+13, Differenz aus net sales_2 value und net purch value. net purch value ist adjust sales_2 qty * item_org_order_purch_net_euro_price (WBP Land_2)',
   nfpo_adv_sales_21_margin_euro_val   NUMBER(38,5)     COMMENT 'EK-Kalk-Volumen realisiert bis WT+20, Differenz aus net sales_2 value und net purch value. net purch value ist adjust sales_2 qty * item_org_order_purch_net_euro_price (WBP Land_2)',
   nfpo_total_adv_sales_margin_euro_val NUMBER(38,5),
   nfpo_avg_adv_sales_net_euro_price   NUMBER(38,5)     COMMENT 'Durchschnitts-Nettoverkaufspreis WT gesamt',
   nfpo_avg_adv_sales_gross_euro_price NUMBER(38,5)     COMMENT 'Durchschnitts-Bruttoverkaufspreis WT gesamt',
   nfpo_item_org_order_purch_net_euro_price NUMBER(38,5)     COMMENT 'Netto-Einkaufspreis WT realisiert  (WBP Artikel_2 Land_2 CBX)',
   nfpo_min_target_sales_gross_euro_price NUMBER(38,5)     COMMENT 'ZVP aus CBX am Artikel_2',
   nfpo_adv_stock_purch_net_euro_val   NUMBER(38,5)     COMMENT 'Mit dem Landes-Einkaufspreis (WBP (nfpo_item_org_order_purch_net_euro_price)) bewertete Aktionsmenge',
   nfpo_planned_adv_stock_sales_gross_euro_val NUMBER(38,5),
   nfpo_mdn_adv_sales_vat_rate         NUMBER(38,5)     COMMENT 'Median-VAT-Rate (MWST) WT gesamt (aus den Sparten-Quelldaten)
            Lidl provides median by store from PIT.
            Kaufland provides VAT history per country.
            Lidl Digital ?',
   nfpo_avg_adv_sales_margin_rate      NUMBER(38,5)     COMMENT 'Durchschnitts-EK-Kalk-Rate realisiert WT gesamt: margin_val/sales_net_val)',
   nfpo_avg_adv_sales_margin_euro_price NUMBER(38,5)     COMMENT 'Durchschnitts-EK-Kalk pro Stück realisiert WT gesamt (margin_val/adjust_sales_qty)',
   nfpo_prev_item_1_total_item_org_order_qty NUMBER(38,5)     COMMENT 'Bestellmenge CBX Artikel_2 Land_2 Vorgänger 1',
   nfpo_prev_item_1_adv_stock_qty      NUMBER(38,5)     COMMENT 'Aktionsmenge WT aus Sparte Vorgänger 1',
   nfpo_prev_item_1_adv_store_cnt      NUMBER(38,0)     COMMENT 'Filialanzahl in der Aktion_2 (errechnet)',
   nfpo_prev_item_1_org_order_purch_net_euro_price NUMBER(38,5)     COMMENT 'Netto-Einkaufspreis WT realisiert  (WBP Artikel_2 Land_2 CBX) Vorgänger 1',
   nfpo_prev_item_1_adjust_adv_sales_7_qty NUMBER(38,5)     COMMENT 'Abverkauf bereinigt kumuliert bis WT+6 Vorgänger 1',
   nfpo_prev_item_1_adjust_adv_sales_21_qty NUMBER(38,5)     COMMENT 'Abverkauf bereinigt kumuliert bis WT+20 Vorgänger 1',
   nfpo_prev_item_1_total_adjust_adv_sales_qty NUMBER(38,5),
   nfpo_prev_item_1_adjust_adv_return_7_qty NUMBER(38,5)     COMMENT 'Rückgaben bis WT+6 Vorgänger 1',
   nfpo_prev_item_1_adjust_adv_sales_7_net_euro_val NUMBER(38,5)     COMMENT 'Nettoumsatz bereinigt bis WT+6 Vorgänger 1',
   nfpo_prev_item_1_total_adjust_adv_sales_gross_euro_val NUMBER(38,5),
   nfpo_prev_item_1_avg_adv_sales_gross_euro_price NUMBER(38,5)     COMMENT 'Durchschnitts-Bruttoverkaufspreis WT gesamt Vorgänger 1',
   nfpo_planned_item_org_adv_sales_gross_euro_price NUMBER(38,5)     COMMENT 'Planverkaufspreis aus der Organisation (ADP, extra KFL-Extrakt) wenn verfügbar',
   nfpo_planned_item_org_adv_stock_qty NUMBER(38,5)     COMMENT 'Planaktionsmenge aus der Organisation (ADP) wenn verfügbar',
   nfpo_planned_item_org_adv_store_cnt NUMBER(38,0)     COMMENT 'Planzahl Filialen aus der Organisation (ADP, extra KFL-Extrakt) wenn verfügbar',
   nfpo_adjust_adv_sales_21_gross_euro_val NUMBER(38,5)     COMMENT 'Bruttoumsatz bereinigt bis WT+20',
   nfpo_prev_item_1_adjust_adv_sales_21_gross_euro_val NUMBER(38,5)     COMMENT 'Bruttoumsatz bereinigt bis WT+20 Vorgänger 1',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_BUYER.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_BUYER.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',
   dwh_node_cd                         VARCHAR(20)      NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',   
   CONSTRAINT PK_T_FACT_NFPO_ITEM_LOCAL_ORGANIZATION_ADVERTISE_DAY PRIMARY KEY (nfpo_item_sid, nfpo_org_sid, adv_dt) NOT ENFORCED 
)  COMMENT = 'Comment 2Do';
