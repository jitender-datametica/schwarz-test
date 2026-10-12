CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_item_wh_stock_nfb_hist_2 (
client_id BIGNUMERIC(38) NOT NULL OPTIONS(description='WDWH:client_id'),
loc_sid BIGNUMERIC(38) NOT NULL
OPTIONS(description='WDWH:SID des Artikels im DWH - Achtung!- Hier nicht Teil des Schlüssels, da u.U.zeitvolatil'),
orig_wh_nr BIGNUMERIC(38) NOT NULL OPTIONS(description='WDWH:wh_id'),
item_sid BIGNUMERIC(38) NOT NULL
OPTIONS(description='WDWH:SID der WH-Location_2 im DWH - Achtung!- Hier nicht Teil des Schlüssels, aus Konsistenzgründen zur ITEM_SID'),
orig_item_nr BIGNUMERIC(38) NOT NULL OPTIONS(description='WDWH:item_id'),
case_size BIGNUMERIC(38) NOT NULL OPTIONS(description='WDWH:item_id'),
pos_nr BIGNUMERIC(38) NOT NULL OPTIONS(description='WDWH:pos_nr'),
pos_nr_link BIGNUMERIC(38) OPTIONS(description='Referenz auf Posionsnummer WDWH:pos_nr_link'),
nfb_type_cd BIGNUMERIC(38) NOT NULL OPTIONS(description='WDWH:nfb_type_cd'),
case_qty NUMERIC(18,5)
OPTIONS(description='mit hoher Wahrscheinlichkeit die Stückzahl f. case_size=1 sonst Preis eigentlich nicht anwendbar (falsch benannt?!); WDWH:qty_case_nfb'),
price NUMERIC(18,5) OPTIONS(description='WDWH:price_retail'),
price_net NUMERIC(18,5) OPTIONS(description='WDWH:price_retail_net'),
vat_total_val NUMERIC(18,5)
OPTIONS(description='case_qty*price*[Masterdata].vat_pct/(100+[Masterdata].vat_pct); WDWH:val_vat'),
modification_dt DATE OPTIONS(description='WDWH:dat_modification'),
delta_day_dt DATE NOT NULL OPTIONS(description='fachliches Datum; WDWH:dat_formdate'),
deleted_fg BIGNUMERIC(38) NOT NULL
OPTIONS(description='Löschflag (0/1); Logische oder physische Löschung im Quellsystem oder fachlich interpretierte Löschung'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Datum der satzändernden WAWI-TEV (bei Änderung von Attributen); historisch-technischer Satzgültigkeitsstart: WDWH:dat_dayend'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Vortag der ändernden WAWI-TEV (bei Änderung von Attributen); historisch-technisches Satzgültigkeitsende: WDWH:dat_dayend'),
dwh_last_confirm_dt DATE NOT NULL
OPTIONS(description='Datum der satzliefernden WAWI-TEV (unabhängig von Änderungen von Attributen); letzte Bestätigung der Satzexistenz im Quellsystzem'),
dwh_load_id BIGNUMERIC(38) NOT NULL
OPTIONS(description='technisch: Identifier des Ladelaufes der Einfügung oder letzten Änderung'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp der Einfügung'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp der letzten Änderung')
);