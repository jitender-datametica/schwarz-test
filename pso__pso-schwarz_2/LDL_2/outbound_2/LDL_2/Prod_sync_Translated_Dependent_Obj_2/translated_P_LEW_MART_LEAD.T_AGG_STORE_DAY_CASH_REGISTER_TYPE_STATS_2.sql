CREATE OR REPLACE TABLE ldl_p_lew_mart_lead.t_agg_store_day_cash_register_type_stats_2 (
client_id INTEGER NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
loc_sid INTEGER NOT NULL OPTIONS(description='Filiale; FK auf LOCATION_2; '),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Belegdatum / BON Datum; WAWI-DWH'),
register_type_cd STRING(100) NOT NULL
OPTIONS(description='TIL: Standard Till; SCO: Self-Check-Out ; SSC: Self-Scanning'),
sco_open_time_sec_total INTEGER NOT NULL
OPTIONS(description='Open Time in seconds between first scan of the day until last scan of the day in SCO-Zone; 0 for TIL'),
dur_prepare_sec_total INTEGER OPTIONS(description='tbd'),
dur_wait_sec_total INTEGER NOT NULL
OPTIONS(description='Waiting time in seconds; 0 for SCO and SSC; source: receiptline'),
dur_scan_sec_total INTEGER NOT NULL OPTIONS(description='Scan time in seconds; source: receiptline'),
dur_pay_sec_total INTEGER NOT NULL OPTIONS(description='Pay time in seconds; source: receiptline'),
dur_proc_sec_total INTEGER NOT NULL OPTIONS(description='Wait + Scan + Pay time; source receiptline'),
sales_pieces_total NUMERIC(29,5) NOT NULL OPTIONS(description='Sales_2 Pieces (Abverkauf Gesamt)'),
customer_count_total INTEGER NOT NULL OPTIONS(description='Sales_2 Pieces (Abverkauf Gesamt)'),
dwh_load_id INTEGER NOT NULL OPTIONS(description='DWH load Identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH'),
aspect_id INTEGER OPTIONS(description='Gesellschaftstyp: 1=BGES, 2=VGES'),
sco_active INTEGER OPTIONS(description='Anzahl aktiver SCOs oder SSCs'),
sales_pieces_total_og NUMERIC(29,5) OPTIONS(description='Sales_2 Pieces (Abverkauf Obst+Gemüse)'),
sales_pieces_total_bakeoff NUMERIC(29,5) OPTIONS(description='Sales_2 Pieces (Abverkauf Bake-Off)'),
cashier_performance INTEGER OPTIONS(description='Cashier Performance (Kassierleistung)')
) OPTIONS(description='Kassierleistung');