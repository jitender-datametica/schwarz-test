CREATE OR REPLACE TABLE kfl_production_dbp_data.cpr_cl_punkt_termin_1 (
checkliste_punkt_id STRING(32) NOT NULL OPTIONS(description='Eindeutige ID eines Checklistenpunkts'),
cpr_suchfeld STRING(40) NOT NULL OPTIONS(description='Aus der Quelle geliefertes Suchfeld'),
suchfeld_bez STRING(60) OPTIONS(description='zusätzliche Bezeichnung'),
ok_fg INTEGER OPTIONS(description='Kennzeichnung gültiger Termin. gleich 1, wenn ok'),
dat_ende_ist DATE NOT NULL
OPTIONS(description='tatsächliches Endedatum. Das Erreichen dieses Datums triggert die Speicherung des Datensatzes'),
cl_punkt_bez STRING(40) NOT NULL
OPTIONS(description='Sprachabhängige Bezeichnung zur ID im Suchfeld des Checklistenpunkts'),
cl_punkt_langtext STRING(320) OPTIONS(description='Sprachabhängiger Langtext eines Checklistenpunkts'),
cpr_checkliste_id STRING(32) OPTIONS(description='unique ID der Checkliste'),
checkliste_nr STRING(30) NOT NULL OPTIONS(description='zusaetzliche ID pro Checkliste, entspricht cpr_ext_id_cl'),
cpr_checkliste_bez STRING(40) NOT NULL OPTIONS(description='Sprachabhängige Bezeichnung der Checkliste'),
cpr_checkliste_langtext STRING(320) OPTIONS(description='Sprachabhängiger Langtext zur Checkliste'),
projekt_phase_id STRING(32) OPTIONS(description='unique ID der Phase'),
phasenart_id STRING(20) OPTIONS(description='Schlüssel der Phasenart, z.Bsp P7-Planung'),
teil_massn_fg INTEGER OPTIONS(description='Dieses Flag kennzeichnet eine_1 Teilmassnahme'),
teil_massnahme_id STRING(30) OPTIONS(description='eindeutige ID der Teilmassnahme'),
einzel_massnahme STRING(30) OPTIONS(description='Einelmassnahme'),
cpr_phase_bez STRING(40) NOT NULL OPTIONS(description='Sprachabhängige Beschreibung der Projektphase'),
cpr_phase_langtext STRING(320) OPTIONS(description='Sprachabhängiger Langtext zur Projektphase'),
projekt_id STRING(32) NOT NULL OPTIONS(description='Eindeutige ID des Projekts'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH. Deutschland ist Mandant_1 1'),
land_id STRING(2) NOT NULL OPTIONS(description='Land_1, auf das sich das Projekt bezieht'),
techn_platz_id STRING(30)
OPTIONS(description='Der technische Platz ist eine_1 von Kaufland Facility Management verwaltete Einheit'),
projekt_nr STRING(30) NOT NULL OPTIONS(description='eindeutige Projektnummer pro Projekt und Sprache'),
massnahme_id STRING(20) OPTIONS(description='Kennzeichnung einer Massnahme, z.Bsp. KB'),
wup_id INTEGER OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
cpr_standort STRING(40) OPTIONS(description='Kann den Namen eines Standortes enthalten, z.Bsp. Heilbronn'),
cpr_filialtyp_bez STRING(30) OPTIONS(description='Bezeichnung, z.Bsp. HH, KL'),
investor_eigenobj STRING(10) OPTIONS(description='Angabe zum Eigentumsverhältnis, z.Bsp. Miete'),
cpr_general_planer STRING(40) OPTIONS(description='Generalplaner Name'),
cpr_objekt_steurer STRING(40) OPTIONS(description='Objektsteuerer Name'),
cpr_projekt_bez STRING(40) NOT NULL OPTIONS(description='Sprachabhängige Projektbeschreibung'),
cpr_projekt_langtext STRING(320) OPTIONS(description='Sprachabhängiger Langtext zum Projekt'),
spr_id INTEGER NOT NULL OPTIONS(description='Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.'),
dat_extrakt DATE NOT NULL OPTIONS(description='Erstellungsdatum des Satzes'),
cpr_phase_version_id STRING(10)
OPTIONS(description='Version (Kundenfeld) einer Phase aus zz_ppo_version. Inhalt z.Bsp. 1.1'),
cpr_phase_version_dat DATE OPTIONS(description='Datum_ab einer Version aus zz_ppo_datum_vom'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (checkliste_punkt_id, cpr_suchfeld) NOT ENFORCED
) OPTIONS(description='IOS - Archivtabelle fuer die abgeschlossenen Projekte mit den Endterminen. Denormalisiert');