/* --------------------------------------------------------------------------------
   DDL for table: t_pick_list_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pick_list_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse, FK auf LOCATION_2'),
pick_list_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kommisionierscheinnummer'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Kommissionierscheindatum'),
pick_area_id BIGNUMERIC(38,0) OPTIONS(description='Lagerzone / Kommissionierungsbereich'),
pick_order_cd STRING(20) COLLATE 'und:ci' OPTIONS(description='? Auftragsnummer'),
loc_sid_store BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Store, fuer den die Ware kommissioniert wird, FK auf LOCATION_2'),
store_order_tmsp DATETIME NOT NULL OPTIONS(description='Kundenbestelldatum/-uhrzeit'),
plan_method_cd STRING(20) COLLATE 'und:ci' OPTIONS(description='? Verplanungsart: KOMZON, KOMAUF, KOMBAT'),
plan_status_cd STRING(20) COLLATE 'und:ci' OPTIONS(description='? Status_2: Fertig, Warten, Bereit, ...'),
plan_host_status_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='? Host Status_2: Fertig, Senden, Neu, Storno, Rvanfrage'),
merged_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='? Verschmolzen: 1=ja, 0=nein'),
performance_statistic_avail_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='Leistungsstatistik erstellt?: OK, OFFEN'),
pick_priority_id BIGNUMERIC(38,0) OPTIONS(description='Prioritaet des Kommissionierungsscheins'),
tour_client_cd STRING(20) COLLATE 'und:ci' OPTIONS(description='? (nicht die bekannte client_id)'),
tour_cd STRING(20) COLLATE 'und:ci' OPTIONS(description='? Tournummmer'),
destination_field_cd STRING(20) COLLATE 'und:ci' OPTIONS(description='? Feld'),
chain_cd STRING(20) COLLATE 'und:ci' OPTIONS(description='?'),
chain_seq BIGNUMERIC(38,0) OPTIONS(description='?'),
chain_logic_id BIGNUMERIC(38,0) OPTIONS(description='?'),
delivery_tmsp DATETIME OPTIONS(description='Liefer-Zeitpunkt'),
supply_tmsp DATETIME NOT NULL OPTIONS(description='Bereitstellungs-Zeitpunkt'),
pick_target_start_tmsp DATETIME NOT NULL OPTIONS(description='Kommissionierung Soll-Startzeitpunkt'),
pick_start_dt DATE NOT NULL OPTIONS(description='Kommissionierung Startdatum'),
pick_start_tmsp DATETIME NOT NULL OPTIONS(description='Kommissionierung Startzeitpunkt'),
pick_end_tmsp DATETIME NOT NULL OPTIONS(description='Kommissionierung Endzeitpunkt'),
target_pick_time_cnt BIGNUMERIC(38,0) OPTIONS(description='Soll-Dauer fur Kommissionierung'),
act_pick_time_cnt BIGNUMERIC(38,0) OPTIONS(description='Ist-Dauer fur Kommissionierung'),
position_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl der zu kommissionierenden Positionen'),
position_processed_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl bearbeiteter Positionen'),
target_pick_case_qty NUMERIC(18,5) NOT NULL OPTIONS(description='? Summe Soll-HE'),
act_pick_case_qty NUMERIC(18,5) NOT NULL OPTIONS(description='? Summe Ist-HE'),
target_pick_te_qty NUMERIC(18,5) NOT NULL OPTIONS(description='? Soll Anzahl TE'),
act_pick_te_qty NUMERIC(18,5) NOT NULL OPTIONS(description='? Ist Anzahl TE'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, loc_sid, pick_list_id, dwh_cal_dt) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. Kommissionierliste - Kopf             Liste von Artikeln, die fuer eine_2 Filialbelieferung kommissioniert werden.             Jede Position auf der Liste enthaelt Infos zu jeweils einem Artikel_2 (siehe t_pick_list_pos_2).             ...             WAWI-DWH: t_picking_planhead');