--==============================================================
-- Table: in_auftrag_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_auftrag_1
   generated from Powerdesigner on Freitag, 31. Mai 2024 09:06:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_auftrag_1 (
auftrag_id STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Auftragsnummer aus aufnr'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
auftragsart_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Auftragsart aus auart'),
geschaeftsbereich_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Der Geschaeftsbereich ist eine_1 interne Organisationseinheit, fuer den eine_1 interne Bilanz sowie Gewinn- und Verlustrechnung erstellt werden kann. Aus gsber'),
in_budget_typ_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Eindeutige ID eines Budgettyps'),
in_massnahme_typ_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Eindeutige ID eins Massnahmetyps'),
auftrag_typ_id BIGNUMERIC(38,0) OPTIONS(description='ID des Auftragstyps'),
psp_id BIGNUMERIC(38,0)
OPTIONS(description='eindeutiger numerischer Schlüssel eines PSP-Elements. Im DWH generierte PSP-Elemente haben ein negatives Vorzeichen'),
techn_platz_id STRING(30) COLLATE 'und:ci'
OPTIONS(description='Fachlicher Schlüssel des technischen Platzes aus tplnr. Referenz zur Tabelle techn_platz_per_1 (im Modell keine Darstellung der Beziehung) Wird compressed'),
werk_id BIGNUMERIC(38,0) OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
phas_techn_abschluss_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flag = 1 bei technischem Abschluss. Quelle ist phas2'),
ref_objektart_id STRING(2) COLLATE 'und:ci' DEFAULT '  ' NOT NULL
OPTIONS(description='Teilstring aus dem Quellfeld objnr. Das Feld setzt sich aus Teil 1 ( STRING) und Teil 2 (Auftragsnummer) zusammen. Hier wird nur der alpha-Teil gespeichert.'),
auftrag_kurztext STRING(40) OPTIONS(description='Kurzbeschreibung des Auftrags'),
referenz_auftrag_id STRING(20) COLLATE 'und:ci'
OPTIONS(description='Referenzauftragsnummer. If this order is derived from a previous order, then this is the ID of the previous order.'),
standort_id STRING(10) COLLATE 'und:ci'
OPTIONS(description='ID eines Standortes. Zuordnung Markt bei Pooling-Geräten (oder alphanumerischer Wert / "POOL").'),
standort_werk_id BIGNUMERIC(38,0)
OPTIONS(description='Numerischer Surrogate key für das Werk werks - Plan where order should have been executed. Most of the times it is identical to WERK_ID.'),
kostenstelle_id STRING(10) COLLATE 'und:ci'
OPTIONS(description='Eindeutiger sprechender Schlüssel der Kostenstelle, aus kostl.'),
verantw_arbeitsplatz_name STRING(10)
OPTIONS(description='Verantwortlicher Arbeitsplatz -  Main work center (SAP term)  for maintenance tasks.             A work center is an organizational unit_1 that defines where or by whom a maintenance activity is performed. Work centers can be machines, people, or production lines, for example.            In this column we have the work center that is assigned to a maintenance order at the HEADER level (on position a.k.a. "order operation" level there can be other work centers).            The "Name" is the identifier of the work place, there is no code or ID. The source system supports additional descriptions of these names, but they are not maintained by the business so as of May 2024, there is no lookup table with name-description combo'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='IMS - Auftragsstammdaten aus aufk');