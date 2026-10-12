CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_l_kunde_1 (
crm_kunde_id STRING(144) NOT NULL OPTIONS(description='CRM-interne ID des Kunden'),
zeit_registrierung DATETIME OPTIONS(description='Registrierungsdatum des Kunden'),
zeit_abmeldung DATETIME NOT NULL OPTIONS(description='Abmeldedatum des Kunden - ist immer gefüllt'),
kundentyp_id STRING(50) DEFAULT '-1' NOT NULL OPTIONS(description='ID des Kundentypes'),
kundenherkunft_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='ID der Kundenherkunft ( example values: 1,2,3,)'),
gender_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='ID für das Geschlecht des Kunden'),
geburtsjahr INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Geburtsjahr des Kunden '),
kunde_statusgrund_id INTEGER DEFAULT - 9999 NOT NULL
OPTIONS(description='Statusgrund-ID des Kunden (liefert Information darüber, wieso der Kunde aktiv oder inaktiv ist (aktiv_fg))'),
strasse STRING(240) DEFAULT '0' NOT NULL OPTIONS(description='Straße in welcher der Kunde wohnt'),
wohnort STRING(240) DEFAULT '0' NOT NULL OPTIONS(description='Ort in welchem der Kunde wohnt'),
plz STRING(80) DEFAULT '0' NOT NULL OPTIONS(description='Postleitzahl (PLZ) des Ortes in welchem der Kunde wohnt'),
kunde_mandant_id INTEGER NOT NULL OPTIONS(description='Land_1 des Kundenwohnorts'),
vorzugsfiliale_wup_id INTEGER NOT NULL OPTIONS(description='ID der präferierten Filiale'),
vorzugsfiliale_mandant_id INTEGER OPTIONS(description='Land_1 der präferierten Filiale'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
merge_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag, das anzeigt ob dieser Kontakt mit einem anderen Kontakt gemerged/zusammengeführt wurde'),
registrierungsfiliale_wup_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Filiale in der sich der Kunde registriert hat. Bei physischen Kunden (Anmeldung in der Filiale) kommt diese Information aus dem\"mauellen\" Registrierungsprozess. Bei digitalen Kunden (Anmeldung über App) kommt diese Information aus der App.'),
registrierungsfiliale_mandant_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Mandant_1 ID zur Registrierungsfiliale'),
registrierungsfiliale_nb_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer. Gehört zur registrierten Registrierungsfiliale.'),
aktiv_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag das anzeigt, ob der Kunde aktiv oder inaktiv ist'),
haushaltsgroesse STRING(20) OPTIONS(description='Haushaltsgröße'),
beschaeftigung_status_id INTEGER DEFAULT - 1
OPTIONS(description='Beschäftigungsstatus, sagt aus ob Kunde bspw. Schüler/in, Hausmann/frau, Angestellte/r,... ist'),
crm_cidaas_id STRING(120) DEFAULT '-9999' NOT NULL
OPTIONS(description='MS Dynamics - contact.kl_keycloakid -\n    Meldet sich  Person unter Verwendung derselben Mailadresse/Mobilnummer an zwei verschiedenen K Card Programmen an, bekommt sie zwei separate Kontakte (crm_kunde_id), Konten (crm_konto_id) und separate Karten (kundenkarte_id). Beide Kontakte werden jedoch mit derselben Cidaas ID versehen.  '),
td_insert TIMESTAMP,
td_update TIMESTAMP
) OPTIONS(description='EK_KUN - MSDynamicsCRM - CRM - Entität\"Customer\" (Kundenstamm) ');