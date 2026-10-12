--==============================================================
-- Table: aktion_werbemengen_einholung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktion_werbemengen_einholung_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aktion_werbemengen_einholung_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennung einer Aktion_1 aus der Quelle wakh.aktnr'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
schlagwort STRING(40) COLLATE 'und:ci' OPTIONS(description='Schlagwörter. Z.B. AME alle Häuser 2017'),
dat_von DATE OPTIONS(description='Abverkauf an Endverbraucher ab'),
dat_bis DATE OPTIONS(description='Abverkauf an Endverbraucher bis'),
status_einholung_id BIGNUMERIC(38,0) OPTIONS(description='Status_1 der Einholung'),
status_einholung_markt_kz STRING(1) COLLATE 'und:ci' OPTIONS(description='Status_1 der Einholung im Markt'),
dat_rueckmeldung DATE OPTIONS(description='Rückmeldedatum Betrieb'),
dat_bis_rueckmeldung DATE OPTIONS(description='letzter Rückmeldetermin für die Aktionsbekanntmachung'),
dat_aktionsbekanntmachung DATE OPTIONS(description='Datum der Aktionsbekanntmachung'),
anzahl_artikel_offen BIGNUMERIC(38,0) OPTIONS(description='Anzahl Artikel_1 offen - Status_1 2'),
anzahl_artikel_gesamt BIGNUMERIC(38,0) OPTIONS(description='Anzahl Artikel_1 gesamt - auf WGR Ebene'),
aktion_typ_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Aktionstyp'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, wg_id, arthiertyp_id) NOT ENFORCED
) OPTIONS(description='VIS - Artikel_1/Aktionen auf WGR-level für Filiale - SAP RET - ZEK_WGR_MARKT');