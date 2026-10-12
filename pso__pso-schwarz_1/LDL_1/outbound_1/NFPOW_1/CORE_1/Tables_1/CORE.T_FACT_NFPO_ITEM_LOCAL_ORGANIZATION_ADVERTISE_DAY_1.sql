/* --------------------------------------------------------------------------------
   DDL for table: t_fact_nfpo_item_local_organization_advertise_day_1
   generated from Powerdesigner on Friday, 3 May 2024 10:21:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_fact_nfpo_item_local_organization_advertise_day_1 (
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''Surrogate Key NFPO ITEM_1 INSTANCE.
            CBX: CNT_ITEM.REF_NO
            LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_SID'''),
nfpo_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''Surrogate key internal organization.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID'''),
adv_dt DATE NOT NULL OPTIONS(description='Werbetermin'),
adv_seq BIGNUMERIC(38,0) OPTIONS(description='lfd Nr. Werbetermin zum Artikel_1 im Land_1'),
nfpo_total_item_org_order_qty BIGNUMERIC(38,5) OPTIONS(description='Bestellmenge CBX Artikel_1 Land_1'),
nfpo_pseudo_split_item_org_order_qty BIGNUMERIC(38,5)
OPTIONS(description='Nur formell geteilte Bestellmenge pro Werbetermin, CBX Artikel_1 Land. nfpo_total_item_org_order_qty / max(adv_seq)'),
nfpo_adv_stock_qty BIGNUMERIC(38,5) OPTIONS(description='Aktionsmenge WT aus Sparte'),
nfpo_adv_store_cnt BIGNUMERIC(38,0) OPTIONS(description='Filialanzahl in der Aktion_1 (errechnet)'),
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
nfpo_adv_sales_1_margin_euro_val BIGNUMERIC(38,5)
OPTIONS(description='EK-Kalk-Volumen realisiert bis WT, Differenz aus net sales_1 value und net purch value. net purch value ist adjust sales_1 qty * item_org_order_purch_net_euro_price (WBP Land_1)'),
nfpo_adv_sales_3_margin_euro_val BIGNUMERIC(38,5)
OPTIONS(description='EK-Kalk-Volumen realisiert bis WT+2, Differenz aus net sales_1 value und net purch value. net purch value ist adjust sales_1 qty * item_org_order_purch_net_euro_price (WBP Land_1)'),
nfpo_adv_sales_7_margin_euro_val BIGNUMERIC(38,5)
OPTIONS(description='EK-Kalk-Volumen realisiert bis WT+6, Differenz aus net sales_1 value und net purch value. net purch value ist adjust sales_1 qty * item_org_order_purch_net_euro_price (WBP Land_1)'),
nfpo_adv_sales_14_margin_euro_val BIGNUMERIC(38,5)
OPTIONS(description='EK-Kalk-Volumen realisiert bis WT+13, Differenz aus net sales_1 value und net purch value. net purch value ist adjust sales_1 qty * item_org_order_purch_net_euro_price (WBP Land_1)'),
nfpo_adv_sales_21_margin_euro_val BIGNUMERIC(38,5)
OPTIONS(description='EK-Kalk-Volumen realisiert bis WT+20, Differenz aus net sales_1 value und net purch value. net purch value ist adjust sales_1 qty * item_org_order_purch_net_euro_price (WBP Land_1)'),
nfpo_total_adv_sales_margin_euro_val BIGNUMERIC(38,5),
nfpo_avg_adv_sales_net_euro_price BIGNUMERIC(38,5) OPTIONS(description='Durchschnitts-Nettoverkaufspreis WT gesamt'),
nfpo_avg_adv_sales_gross_euro_price BIGNUMERIC(38,5) OPTIONS(description='Durchschnitts-Bruttoverkaufspreis WT gesamt'),
nfpo_item_org_order_purch_net_euro_price BIGNUMERIC(38,5)
OPTIONS(description='Netto-Einkaufspreis WT realisiert  (WBP Artikel_1 Land_1 CBX)'),
nfpo_min_target_sales_gross_euro_price BIGNUMERIC(38,5) OPTIONS(description='ZVP aus CBX am Artikel_1'),
nfpo_adv_stock_purch_net_euro_val BIGNUMERIC(38,5)
OPTIONS(description='Mit dem Landes-Einkaufspreis (WBP (nfpo_item_org_order_purch_net_euro_price)) bewertete Aktionsmenge'),
nfpo_planned_adv_stock_sales_gross_euro_val BIGNUMERIC(38,5),
nfpo_mdn_adv_sales_vat_rate BIGNUMERIC(38,5)
OPTIONS(description='''Median-VAT-Rate (MWST) WT gesamt (aus den Sparten-Quelldaten)
            Lidl provides median by store from PIT.
            Kaufland provides VAT history per country.
            Lidl Digital ?'''),
nfpo_avg_adv_sales_margin_rate BIGNUMERIC(38,5)
OPTIONS(description='Durchschnitts-EK-Kalk-Rate realisiert WT gesamt: margin_val/sales_net_val)'),
nfpo_avg_adv_sales_margin_euro_price BIGNUMERIC(38,5)
OPTIONS(description='Durchschnitts-EK-Kalk pro Stück realisiert WT gesamt (margin_val/adjust_sales_qty)'),
nfpo_prev_item_1_total_item_org_order_qty BIGNUMERIC(38,5)
OPTIONS(description='Bestellmenge CBX Artikel_1 Land_1 Vorgänger 1'),
nfpo_prev_item_1_adv_stock_qty BIGNUMERIC(38,5) OPTIONS(description='Aktionsmenge WT aus Sparte Vorgänger 1'),
nfpo_prev_item_1_adv_store_cnt BIGNUMERIC(38,0) OPTIONS(description='Filialanzahl in der Aktion_1 (errechnet)'),
nfpo_prev_item_1_org_order_purch_net_euro_price BIGNUMERIC(38,5)
OPTIONS(description='Netto-Einkaufspreis WT realisiert  (WBP Artikel_1 Land_1 CBX) Vorgänger 1'),
nfpo_prev_item_1_adjust_adv_sales_7_qty BIGNUMERIC(38,5)
OPTIONS(description='Abverkauf bereinigt kumuliert bis WT+6 Vorgänger 1'),
nfpo_prev_item_1_adjust_adv_sales_21_qty BIGNUMERIC(38,5)
OPTIONS(description='Abverkauf bereinigt kumuliert bis WT+20 Vorgänger 1'),
nfpo_prev_item_1_total_adjust_adv_sales_qty BIGNUMERIC(38,5),
nfpo_prev_item_1_adjust_adv_return_7_qty BIGNUMERIC(38,5) OPTIONS(description='Rückgaben bis WT+6 Vorgänger 1'),
nfpo_prev_item_1_adjust_adv_sales_7_net_euro_val BIGNUMERIC(38,5)
OPTIONS(description='Nettoumsatz bereinigt bis WT+6 Vorgänger 1'),
nfpo_prev_item_1_total_adjust_adv_sales_gross_euro_val BIGNUMERIC(38,5),
nfpo_prev_item_1_avg_adv_sales_gross_euro_price BIGNUMERIC(38,5)
OPTIONS(description='Durchschnitts-Bruttoverkaufspreis WT gesamt Vorgänger 1'),
nfpo_planned_item_org_adv_sales_gross_euro_price BIGNUMERIC(38,5)
OPTIONS(description='Planverkaufspreis aus der Organisation (ADP, extra KFL-Extrakt) wenn verfügbar'),
nfpo_planned_item_org_adv_stock_qty BIGNUMERIC(38,5)
OPTIONS(description='Planaktionsmenge aus der Organisation (ADP) wenn verfügbar'),
nfpo_planned_item_org_adv_store_cnt BIGNUMERIC(38,0)
OPTIONS(description='Planzahl Filialen aus der Organisation (ADP, extra KFL-Extrakt) wenn verfügbar'),
nfpo_adjust_adv_sales_21_gross_euro_val BIGNUMERIC(38,5) OPTIONS(description='Bruttoumsatz bereinigt bis WT+20'),
nfpo_prev_item_1_adjust_adv_sales_21_gross_euro_val BIGNUMERIC(38,5)
OPTIONS(description='Bruttoumsatz bereinigt bis WT+20 Vorgänger 1'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_BUYER.DWH_CREATED'''),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_BUYER.DWH_UPDATED'''),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (nfpo_item_sid, nfpo_org_sid, adv_dt) NOT ENFORCED
) OPTIONS(description='Comment 2Do');