--==============================================================
-- Table: leergut_einweg_dat_abrechnung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: leergut_einweg_dat_abrechnung
   generated from Powerdesigner on Donnerstag, 5. Juni 2025 07:41:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.leergut_einweg_dat_abrechnung (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
leergutautomat_schluessel_id STRING(30) NOT NULL OPTIONS(description='ID des Leergutautomaten. Eindeutig im Land'),
datzeit_verarbeitung DATETIME NOT NULL
OPTIONS(description='Zeitstempel, wann die Daten bei ESB verarbeitet worden sind. In einigen Fällen werden die Daten eines Automaten an zwei verschiedenen Tagen im System verarbeitet, daher wurde diese Spalte als Primärschlüssel hinzugefügt.'),
dat_ruecknahme DATE NOT NULL
OPTIONS(description='Tag der Rücknahme (Reportingdatum) ist der Tag, an dem der Kunde die Einwegflaschen im Automaten abgegeben hat.'),
einweg_typ_kz STRING(1) NOT NULL
OPTIONS(description='Kennzeichen für Eigen-Einwegpfand (E) oder Fremd-Einwegpfand (F). Eigen-Einwegpfand bezieht sich auf Einwegpfandflaschen, die von der von Kaufland stammen.'),
leergutautomat_id STRING(30) NOT NULL OPTIONS(description='ID des Leergutautomaten. Eindeutig in der Filiale.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
menge_einweg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Menge der geschredderten Einwegpfandflaschen.'),
dat_tagesabschluss DATE NOT NULL OPTIONS(description='Tag des Tagesabschlusses (Business date).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, leergutautomat_schluessel_id, dat_ruecknahme, einweg_typ_kz, datzeit_verarbeitung) NOT ENFORCED
)
OPTIONS(description='Die Tabelle beinhaltet die Menge der geschredderten EINWEG Pfandflaschen. Sie betrifft nur Leergut Einweg. Daten kommen über ESB. Es werden immer die Daten geliefert, die "gestern" verarbeitet worden sind. Inhalltlich sind das die Daten vom Vor-Vortag.');