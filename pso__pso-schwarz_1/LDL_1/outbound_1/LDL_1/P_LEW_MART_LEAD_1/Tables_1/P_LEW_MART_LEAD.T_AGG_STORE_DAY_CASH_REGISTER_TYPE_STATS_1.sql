/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0   31-03-2025   Stefan Sockel   First Version of new Kassierleistungs-Aggregate
# 1.1   08.05.2025   Aparna Rayanki  Added DWH_LOAD_ID while changing load script from Full to Delta
# 1.2   23.05.2025   Marvin Rekovsky Added ASPECT_ID
#                                       
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_store_day_cash_register_type_stats_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filiale; FK auf LOCATION_1; '),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Belegdatum / BON Datum; WAWI-DWH'),
aspect_id BIGNUMERIC(38,0) OPTIONS(description='Gesellschaftstyp: 1=BGES, 2=VGES'),
register_type_cd STRING(100) NOT NULL
OPTIONS(description='TIL: Standard Till; SCO: Self-Check-Out ; SSC: Self-Scanning'),
sco_open_time_sec_total BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Open Time in seconds between first scan of the day until last scan of the day in SCO-Zone; 0 for TIL'),
dur_prepare_sec_total BIGNUMERIC(38,0) OPTIONS(description='tbd'),
dur_wait_sec_total BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Waiting time in seconds; 0 for SCO and SSC; source: receiptline'),
dur_scan_sec_total BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Scan time in seconds; source: receiptline'),
dur_pay_sec_total BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Pay time in seconds; source: receiptline'),
dur_proc_sec_total BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Wait + Scan + Pay time; source receiptline'),
sales_pieces_total NUMERIC(18,5) NOT NULL OPTIONS(description='Sales_1 Pieces (Abverkauf Gesamt)'),
customer_count_total BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sales_1 Pieces (Abverkauf Gesamt)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH load Identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH')
) OPTIONS(description='Kassierleistung');