CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.transportauftrag_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
transport_beleg_id INTEGER NOT NULL,
lagernummer_id STRING(3) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat_erstellung DATE,
zeit_erstellung BIGNUMERIC(38,0),
dat_quittierung DATE,
transportart_id STRING(1) COLLATE 'und:ci',
system_id BIGNUMERIC(38,0) DEFAULT 14 NOT NULL,
lvs_bewart_id BIGNUMERIC(38,0),
lief_beleg_id INTEGER DEFAULT 0 NOT NULL,
ta_prio BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
dat_prio_upd DATE,
zeit_prio_upd BIGNUMERIC(38,0),
kj_lief_beleg BIGNUMERIC(38,0),
anz_pos_ta STRING(4) OPTIONS(description='Aktuelle Anzahl Positionen im TA'),
datzeit_start_ta TIMESTAMP OPTIONS(description='Zeitstempel Beginn TA'),
datzeit_end_ta TIMESTAMP OPTIONS(description='Zeitstempel Ende TA'),
referenznummer INTEGER OPTIONS(description='Referenznummer'),
dat_bereitstellung DATE OPTIONS(description='Bereitstelldatum'),
datzeit_bereitstellung TIMESTAMP OPTIONS(description='Bereitstellzeit'),
wg_verkett_id BIGNUMERIC(38,0) OPTIONS(description='Warengruppenverkettungskennzeichen'),
werbeware_id STRING(1) COLLATE 'und:ci' OPTIONS(description='Werbung/Normalware'),
lief_pal_typ_id STRING(1) COLLATE 'und:ci' OPTIONS(description='Palettentyp der Lieferung'),
dat_lief_soll DATE OPTIONS(description='Lieferdatum'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) CLUSTER BY mandant_id, dat_quittierung
OPTIONS(description='TP408_LVS - In dieser Tabelle sind die Transportaufträge aus der SAP Quelle LTAK enthalten. - MULTISET');