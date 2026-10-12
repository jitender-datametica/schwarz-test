DROP TABLE IF EXISTS kfl_production_dbp_data.udf_prognose;
CREATE OR REPLACE TABLE kfl_production_dbp_data.udf_prognose (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH.'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
diagnose_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Diagnoseidentifikator (Regelwerk für die Prognose).'),
dat_prognoselauf DATE NOT NULL OPTIONS(description='Datum des Prognoselaufs (ENTRY_DATE).'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT.'),
prognose_horizont INTEGER NOT NULL
OPTIONS(description='Prognosehorizont: für wie viele Tage gab es prognostizierte Mengen (wie viele Felder von QUANTITY_01 - bis QUANTITY_80 waren gefüllt).'),
menge_prognose_af NUMERIC(29,3) DEFAULT 0 OPTIONS(description='Aktionsfreier Bedarf in Basismengeneinheit.'),
menge_prognose_sa NUMERIC(29,3) DEFAULT 0 OPTIONS(description='Werbebedarf in Basismengeneinheit.'),
menge_prognose_gesteuert NUMERIC(29,3) DEFAULT 0
OPTIONS(description='Manuell gesteuerte Prognose in Basismengeneinheit.'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
prognose_trennung_cd STRING(3)
OPTIONS(description='Eindeutige Kennzeichnung der übergeordneten Trennung der Prognosen auf Markt/Artikel/Tag-Ebene. Sie dient der Unterscheidung zwischen ungesteuerten und gesteuerten Prognosen, die aus PMR-Daten ermittelt und während der Beladung angereichert werden. Mögliche Werte sind AF (Aktionsfrei), SA (Sonderaktion) oder BBY (Bonusbuy/K-Card). Dies ist relevant, da zukünftig die Prognosetrennung nicht mehr über Angebots-IDs in SAP erfolgt, sondern über diese Attribut-Logik im DWH abgebildet wird.'),
prognose_feingliederung_id INTEGER
OPTIONS(description='Eindeutige Kennzeichnung der weiteren, feineren Gliederung der Prognosen auf Markt/Artikel/Tag-Ebene, basierend auf der Logik der prognose_trennung_cd. Sie präzisiert die Prognose-Trennung und wird aus PMR-Daten ermittelt und während der Beladung angereichert. Mögliche Werte:\n            -1= nicht definiert\n            1= Nur Prospekt\n            2= Prospekt + K-Card\n            3= KDN-only\n            4= KDP-only\n            5= BBY KMO\n            6= Prospekt + BBY KMO'),
PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat_prognoselauf, dat) NOT ENFORCED
) CLUSTER BY mandant_id, dat_prognoselauf, dat
OPTIONS(description='SCM - Prognosewerte aus SAP UDF - Transparente Tabelle ZUDF_TS_DWH.\n             Die Tabelle UDF_PROGNOSE enthält die durch das SAP-Quellsystem UDF berechneten Abverkaufsprognosen aller prognoserelevanten Artikel-Markt-Tag-Kombinationen.\n             Die Prognoserelevanz definiert sich dabei über bestimmte Stammdaten-Konstellationen (wie z.B. Dispomerkmal und Postenkennzeichen).\n             Die Prognosen werden mit jedem Prognoselauf (dat_prognoselauf) neu berechnet und stehen für einen Gültigkeitstag (dat) dadurch mehrfach zur Verfügung – hierbei wird stets der Wert für den aktuellsten Gültigkeitstag (dat) für die Ermittlung der Autodispo-Bestellmengen verwendet. Die Prognosen liegen sowohl für den aktionsfreien Bedarf (menge_prognose_af) als auch für den Werbebedarf (menge_prognose_sa) sowie inklusive manueller Prognosesteuerungen (menge_prognose_gesteuert) vor.');