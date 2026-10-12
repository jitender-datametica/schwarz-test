--==============================================================
-- Table: l_ssm_treiber
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_ssm_treiber
   generated from Powerdesigner on Montag, 30. Januar 2023 18:38:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ssm_treiber (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
treiber_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID des Sollstunden-Modell-Treiber (Einflussgrößen auf den Personalaufwand /Tätigkeit des Marktmitarbeiter)'),
dat_von DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT - Datum ab Gültigkeit'),
dat_bis DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT'),
treiber_bez STRING(50) DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des Sollstunden-Modell-Treiber (Einflussgrößen auf den Personalaufwand /Tätigkeit des Marktmitarbeiter)'),
aufgabe_tages_versatz BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl des Tagesversatzes, um wie viel der Treiber in die Tabelle ssm_wup_tag_treiber übernommen werden soll.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, treiber_id) NOT ENFORCED
)
OPTIONS(description='VIS - Lookuptabelle für die Treiber (Einflussgrößen auf den Personalaufwand im Markt) im Sollstunden-Modell');