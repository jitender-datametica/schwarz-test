CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.vis_monat_bestand_wg_log_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
gjmo BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Geschäftsjahresmonat, beginnend bei 1 im März, Format JJJJMM            '),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig);            Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter)            Regel: Neuer Artikel_2 -> Counter +1'),
log_time_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP() NOT NULL,
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='VIS Ladehilfstabelle - dient zur Beladung der Tabelle vis_monat_bestand_wg_2');