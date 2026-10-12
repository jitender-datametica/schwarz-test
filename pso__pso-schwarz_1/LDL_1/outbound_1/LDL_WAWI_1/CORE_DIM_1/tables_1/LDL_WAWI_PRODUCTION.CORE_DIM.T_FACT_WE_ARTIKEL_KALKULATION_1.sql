CREATE OR REPLACE TABLE core_dim.t_fact_we_artikel_kalkulation_1 (
wawi_instanz_kzl STRING(3) NOT NULL
OPTIONS(description='WaWi Instanz, WEKOPF.WAWI_INSTANZ_KZL (only in the consolidated layer)'),
we_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WEKOPF.ID'),
gesellschaft_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WEKOPF.GESELLSCHAFTSNR'),
lagerort_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WEKOPF.LAGERORTNR'),
artikel_nr STRING(100) NOT NULL OPTIONS(description='WEPOS.ARTIKELNR'),
we_datum DATE NOT NULL OPTIONS(description='WEKOPF.WEDATUM'),
kred_nr STRING(100) NOT NULL
OPTIONS(description='WEKOPF.KREDNR - The incoming goods supplier_1 here can deviate from the supplier_1 on the invoice.'),
waehrung_kbez STRING(3) NOT NULL
OPTIONS(description='WAEHRUNGSKNZ.WAEHRKBEZ - CROSS JOIN LDL_WAWI.WEPOS.WAEHRUNGSKNZ_1 and WAEHRUNGSKNZ.WAEHRUNGSKNZ_1'),
we_menge BIGNUMERIC(38,5) OPTIONS(description='WEPOS_1 Berechnet - WE Menge - WE Stk./KG'),
we_bewertet_vk_brutto_wert BIGNUMERIC(38,5)
OPTIONS(description='WEPOS.SUMVKPNORM - VK_1 brutto - WE bewertet mit VK_1 Brutto '),
we_bewertet_vk_netto_ohne_pfand_wert BIGNUMERIC(38,5)
OPTIONS(description='WEPOS_1 berechnet - VK_1 Netto ohne Pfand - WE Bewertet mit VK_1 Netto'),
we_bewertet_ek_netto_inkl_sk_wert BIGNUMERIC(38,5)
OPTIONS(description='WEPOS.SUMEKPLAND - EK Netto inkl. SK - EK Volumen (in LW)'),
we_bewertet_ek_netto_ohne_sk_wert BIGNUMERIC(38,5) OPTIONS(description='WEPOS_1 - EK-Netto ohne SK - WE EK-Netto ohne SK'),
PRIMARY KEY (wawi_instanz_kzl, gesellschaft_nr, we_id, lagerort_nr, artikel_nr) NOT ENFORCED
)
OPTIONS(description='Faktentabelle auf Ebene Wareneingangsartikel. Aggregation von Wareneingangsposition auf Wareneingangsartikel.');