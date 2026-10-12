--==============================================================
-- Table: amx_revisor
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_revisor
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_revisor (
revisor_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description=' Revisor wurde aus Datenschutzgründen ausgebaut und darf nicht ohne Rücksprache mit SBIT wieder eingebaut werden. Eindeutige ID des Prüfers aus dem Quellfeld autitor.id'),
revisor_anrede STRING(40) DEFAULT ' ' NOT NULL OPTIONS(description='Anrede aus dem Quellfeld salutation'),
revisor_nachname STRING(40) DEFAULT ' ' NOT NULL OPTIONS(description='Nachname aus dem Quellfeld lastname'),
revisor_vorname STRING(40) DEFAULT ' ' NOT NULL OPTIONS(description='Vorname aus dem Quellfeld firstname'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (revisor_id) NOT ENFORCED
)
OPTIONS(description='VIS audimex - Revisor wurde aus Datenschutzgründen ausgebaut und darf nicht ohne Rücksprache mit SBIT wieder eingebaut werden. Die Tabelle amx_pruefer enthält die  Stammdaten der Prüfer Aus der Quelle audimex.auditor');