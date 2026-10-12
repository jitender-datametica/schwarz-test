CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_austr_gebiet_tag_1 (
wmd_austraeger_gebiet_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines Austrägergebiets'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_1-TT'),
auflage INTEGER NOT NULL OPTIONS(description='Auflage in Stück'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wmd_austraeger_gebiet_uid, dat) NOT ENFORCED
) OPTIONS(description='GEKU - hier werden die Auflagen aus der Tabelle geku_austr_gebiet_1 historisiert abgelegt');