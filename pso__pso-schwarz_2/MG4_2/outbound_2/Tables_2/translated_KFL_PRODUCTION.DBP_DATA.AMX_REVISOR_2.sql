CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_revisor_2 (
revisor_id INTEGER NOT NULL
OPTIONS(description=' Revisor wurde aus Datenschutzgründen ausgebaut und darf nicht ohne Rücksprache mit SBIT wieder eingebaut werden. Eindeutige ID des Prüfers aus dem Quellfeld autitor.id'),
revisor_anrede STRING(40) DEFAULT ' ' NOT NULL OPTIONS(description='Anrede aus dem Quellfeld salutation'),
revisor_nachname STRING(40) DEFAULT ' ' NOT NULL OPTIONS(description='Nachname aus dem Quellfeld lastname'),
revisor_vorname STRING(40) DEFAULT ' ' NOT NULL OPTIONS(description='Vorname aus dem Quellfeld firstname'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (revisor_id) NOT ENFORCED
)
OPTIONS(description='VIS audimex - Revisor wurde aus Datenschutzgründen ausgebaut und darf nicht ohne Rücksprache mit SBIT wieder eingebaut werden. Die Tabelle amx_pruefer enthält die  Stammdaten der Prüfer Aus der Quelle audimex.auditor');