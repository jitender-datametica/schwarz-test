/* --------------------------------------------------------------------------------
   DDL for table: t_item_store_vat_empiric_hist
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_store_vat_empiric_hist (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mandant der DWH - i.a. assoziiert mit dem organisatorischen Zuschnitt der LIDL-Lander'),
loc_sid_store BIGNUMERIC(38,0) NOT NULL OPTIONS(description='FK zur Tabelle t_location; Storereferenz'),
vat_exception STRING(300) COLLATE 'und:ci' DEFAULT 'default' NOT NULL
OPTIONS(description='MWST-Region ("default" Standardregion, sonstige Auspragungen String: "Default-MWSt-Satze zu Sonder-MWSt-Satzen")'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='FK zur Tabelle t_item; Artikelreferenz'),
vat_pct_calc_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='MwSt-Berechnungsart; siehe t_ref_vat_pct_calc_type'),
vat_pct NUMERIC(9,5) OPTIONS(description='MWSt-Satz'),
deleted_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Loschflag - hier nicht verwendet wegen "broken timeline"'),
dwh_valid_from DATE NOT NULL OPTIONS(description='DWH-Hist-Intervall: Gultig_von'),
dwh_valid_to DATE NOT NULL OPTIONS(description='DWH-Hist-Intervall: Gultig_bis'),
dwh_last_confirm_dt DATE NOT NULL OPTIONS(description='Datum der letzten Bestatigung der Attribute der Zeile'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ladelauf-Identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp der Erstellung der Zeile'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp der Modifikation der Zeile'),
PRIMARY KEY (loc_sid_store, item_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id, dwh_valid_to
OPTIONS(description='$Revision: 00000 $ historische Kollektion der aus Point-Of-Sales (E-journal) stammenden MWSt-Satze fur ein Item in einem Store');