--==============================================================
-- Table: tp_objekt_adresse_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tp_objekt_adresse_zu_per
   generated from Powerdesigner on Freitag, 31. Mai 2024 09:28:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tp_objekt_adresse_zu_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH. In der Regel länderbezogen'),
tp_objekt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk'),
standort_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID eines Standorts. Entspricht bei Bestandsmärkten der Marktnummer,  bei zukünftigen Standorten eine Nummer bzw. bei Dummy-Standorten XXXX'),
tp_objekt_sort_id STRING(30) NOT NULL OPTIONS(description='Equipment - Sortierfeld'),
dat_von DATE NOT NULL OPTIONS(description='Datum (von) - Date when record became valid'),
dat_bis DATE OPTIONS(description='Datum (bis) - Date when record expired, and is no logner valid'),
instandhaltung_werk_id BIGNUMERIC(38,0)
OPTIONS(description='Numerischer Surrogate key für das Werk werks. Plant where the equipment should be serviced. e. g. small fork lifters used in the stores are taken to the DCs for maintenance+repairs.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (tp_objekt_sort_id, mandant_id, werk_id, tp_objekt_id, dat_von) NOT ENFORCED
) OPTIONS(description='Adressdaten zum Equipment aus SAP Industry (Tabelle EQUI_ADDR)');