CREATE OR REPLACE TABLE core_dim.t_fact_invoice_kalkulation_1 (
wawi_instanz_kzl STRING(3) NOT NULL
OPTIONS(description='WaWi Instanz, T316_INVOICEHEAD.WAWI_INSTANZ_KZL (only in the consolidated layer)'),
invoice_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='T316_INVOICEHEAD.C316_INVOICEID'),
record_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='T316_INVOICEHEAD.C316_RECORDTYPE'),
gesellschaft_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='T316_INVOICEHEAD.C316_WHNR'),
kred_nr STRING(100) NOT NULL
OPTIONS(description='T316_INVOICEHEAD.C316_SUPPLIERNR - The invoice supplier_1 here can deviate from the incoming goods supplier.'),
we_datum DATE NOT NULL
OPTIONS(description='WEPOS.WEDATUM - CROSS JOIN LDL_WAWI.T316_INVOICEHEAD.C316_INVOICEID and WEPOS.RA_POSNR'),
waehrung_kbez STRING(3) NOT NULL
OPTIONS(description='WAEHRUNGSKNZ.WAEHRKBEZ - CROSS JOIN LDL_WAWI.T316_INVOICEHEAD.C316_CURRENCYCODE and WAEHRUNGSKNZ.WAEHRUNGSKNZ_1'),
akzeptierte_differenz_ek_netto_wert BIGNUMERIC(38,5)
OPTIONS(description='T318_INVOICEDETWH.C318_DIFFVALUE - Akzeptierte Differenzen (RP011) EK Netto - Akzeptierte Differenzen RePrü'),
nicht_pruefbare_differenz_ek_netto_wert BIGNUMERIC(38,5)
OPTIONS(description='T317 / T318 berechnet - Nicht prüfbare Positionen (RSH16) EK Netto in LW - Nicht prüfbare Positionen RePrü'),
zu_klaerende_differenz_ek_netto_wert BIGNUMERIC(38,5)
OPTIONS(description='WEPOS_1 / T316 / T318 berechnet - Zu klärende Differenzen (RSH18) in EK Netto - Zu klärende Differenzen RePrü'),
zu_klaerende_differenz_vk_netto_wert BIGNUMERIC(38,5)
OPTIONS(description='WEPOS_1 / T318 berechnet - Zu klärende Differenzen (RSH18) in VK_1 Netto - Zu klärende Differenzen RePrü'),
PRIMARY KEY (wawi_instanz_kzl, invoice_id, record_type_id) NOT ENFORCED
) OPTIONS(description='Faktentabelle auf Ebene Rechnungskopf für Lieferantenrechnungen.');