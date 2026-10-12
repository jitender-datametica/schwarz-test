--==============================================================
-- Table: in_auftrag_rm_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_auftrag_rm_2
   generated from Powerdesigner on Freitag, 31. Mai 2024 09:12:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_auftrag_rm_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH. In der Regel länderbezogen'),
auftrag_rm_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Rückmeldung aus rueck'),
auftrag_rm_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Positionsid der Rückmeldung aus rmzhl'),
auftrag_id STRING(20) COLLATE 'und:ci' OPTIONS(description='Auftragsnummer aus aufnr'),
co_leistungsart_id STRING(7) COLLATE 'und:ci'
OPTIONS(description='ID der CO-Leistungsart der Rückmeldung aus dem Quellfeld learr. Referenztabelle ist in_l_leistungsart_2'),
storno_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Flag = 1 für stornierten Beleg aus dem Quellfeld stokz'),
storno_zaehler BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Rückmeldezähler der stornierten Rückmeldung aus dem Quellfeld stzhl'),
dat_buch DATE NOT NULL OPTIONS(description='Buchungsdatum'),
teil_end_rm STRING(1)
OPTIONS(description='Teil-/Endrückmeldung (X = Endrückmeldung, 1 = Automatische Endrückmeldung, leer = Teilrückmeldung)'),
menge_arbeit_ist BIGNUMERIC(38,5) OPTIONS(description='Istarbeit - actual work done for this order'),
menge_arbeit_ist_einh_id STRING(3)
OPTIONS(description='istarbeit Masseinheit - unit_2 in which the actual work for this order is measured'),
datzeit_durchfuehrung_ende DATETIME OPTIONS(description='Rückgemeldeter Endzeitpunkt der Durchführung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, auftrag_rm_id, auftrag_rm_pos_id) NOT ENFORCED
) OPTIONS(description='LIS - Auftrags-Rückmeldungen aus der Quelle SAP Industrie afru');