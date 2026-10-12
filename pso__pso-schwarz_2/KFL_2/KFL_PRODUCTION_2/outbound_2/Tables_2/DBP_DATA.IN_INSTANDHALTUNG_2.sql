--==============================================================
-- Table: in_instandhaltung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_instandhaltung_2
   generated from Powerdesigner on Freitag, 31. Mai 2024 09:13:23
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_instandhaltung_2 (
auftrag_id STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Auftragsnummer aus aufnr'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH. In der Regel länderbezogen'),
instandhaltung_leistungsart_id STRING(3) COLLATE 'und:ci' DEFAULT '   ' NOT NULL
OPTIONS(description='Instandhaltungs-Leistungsart aus dem Quellfeld ilart'),
in_kunde_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH generierter Surrogate Key für die Kundennummer aus SAP'),
qual_meldung_id INTEGER NOT NULL OPTIONS(description='ID der Qualitätsmeldung aus qmnum'),
tp_objekt_id BIGNUMERIC(38,0) OPTIONS(description='Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_2'),
auftragskategorie_id BIGNUMERIC(38,0)
OPTIONS(description='Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_2'),
wart_plan_id BIGNUMERIC(38,0) OPTIONS(description='Wartungsplan'),
wart_plan_abruf_id BIGNUMERIC(38,0) OPTIONS(description='Nummer des Wartungsplanabrufes'),
wart_plan_pos_id BIGNUMERIC(38,0) OPTIONS(description='Wartungsposition aus dem Wartungsplan'),
dat_bezug DATE OPTIONS(description='Bezugsdatum des Instandhaltungsplan(IH)-Auftrages'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
)
OPTIONS(description='LIS - Instandhaltung aus der Quelle SAP Industrie afih.             Table IN_AUFTRAG_2 has ALL types of orders (header table) whereas IN_INSTANDHALTUNG_2 only contains additional information for orders regarding maintenance and  repair              A record in IN_ INSTANDHALTUNG always has a corresponding record in IN_AUFTRAG_2');