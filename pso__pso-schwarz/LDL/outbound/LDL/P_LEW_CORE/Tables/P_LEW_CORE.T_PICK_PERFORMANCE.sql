/* --------------------------------------------------------------------------------
   DDL for table: t_pick_performance
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pick_performance (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key LOCATION (eindeutig ueber alle Laender/Mandanten hinweg)'),
pick_list_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kommisionsscheinnummer'),
dwh_cal_dt DATE NOT NULL
OPTIONS(description='Zuordnungs-Datum der Leistung (identisch zu pick_list_dt, was letztlich der Tag ist, an dem die Liste per Tagesabschluss verarbeitet wurde)'),
performance_tmsp DATETIME NOT NULL OPTIONS(description='Zuordnungs-Zeitpunkt der Leistung'),
performance_type_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Leistungs-Art: MIN15, STD, MON, TAG, JAHR'),
performance_grp_cd STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Leistungs-Gruppe: Funk, Unknown'),
performance_cd STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='? Leistung: KOM, SUM'),
pick_area_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lagerzone'),
transport_method_cd STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Transportmittel, mit dem komm. wurde'),
target_time_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Vorgabe Kommissionier-Dauer'),
working_time_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='? Arbeits-Dauer'),
lead_time_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='? Vorlauf-Dauer'),
lag_time_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='? Nachlauf-Dauer'),
break_time_cnt NUMERIC(18,5) NOT NULL OPTIONS(description='? Pausen-Dauer'),
extra_time_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='? Sonstige-Zeit-Dauer'),
days_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Tage'),
hours_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Std'),
staff_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl MA'),
break_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Pause'),
order_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Bestellungen'),
position_total_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Kommissionier-Positionen'),
target_pick_te_qty NUMERIC(18,5) NOT NULL OPTIONS(description='? Anzahl TE'),
act_pick_te_qty NUMERIC(18,5) NOT NULL OPTIONS(description='? Tatsaechliche '),
target_pick_case_qty NUMERIC(18,5) NOT NULL OPTIONS(description='? '),
act_pick_case_qty NUMERIC(18,5) NOT NULL OPTIONS(description='? '),
total_weight_gross_qty NUMERIC(18,5) NOT NULL OPTIONS(description='Gesamtgewicht brutto'),
total_weight_net_qty NUMERIC(18,5) NOT NULL OPTIONS(description='Gesamtgewicht netto'),
act_handhe_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='?'),
act_entry_thm_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='?'),
act_orig_thm_cnt NUMERIC(18,5) NOT NULL OPTIONS(description='?'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, loc_sid, pick_list_id, performance_tmsp, pick_area_id, dwh_cal_dt) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. Kommissionierleistung(en) pro Kommissionierschein             Die originale Granularitaet Kommissionierer wurde auf die vorliegende Granularitaet verdichtet             ...             WAWI-DWH: t_picking_performance');