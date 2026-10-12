--==============================================================
-- Table: ts_autodispo_dif_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_autodispo_dif_2
   generated from Powerdesigner on Freitag, 30. April 2021 16:01:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_autodispo_dif_2 (
mandant_id_kunde BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 Markt'),
wup_id_kunde BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Markt'),
nb_id_kunde BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetrieb Markt'),
mandant_id_vz BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 VZ'),
wup_id_vz BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Verteilzentrum'),
nb_id_vz BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetrieb VZ'),
frische_manager_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Leiter Frische'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2  - Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
vs_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Region_2  - ID der Vertriebsschiene. Vertriebs-Sicht auf die wup_2 Objekte'),
vkl_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Verkaufsleiter'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
art_gruppe_id STRING(5) DEFAULT '-1   ' NOT NULL
OPTIONS(description='Artikelgruppe  - ID der Artikel_2-Gruppierung (System generiert im DWH)'),
dat_von DATE NOT NULL OPTIONS(description='Gueltig Von  :  Datum im Format JJJJ-MM_2-TT'),
dat_bis DATE NOT NULL OPTIONS(description='Gueltig Bis   :  Datum im Format JJJJ-MM_2-TT'),
sa_af_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SA oder AF (Sonderaktion oder Aktionsfrei) SA/AF steuerung -> SA, AF oder beides'),
dif_funktion_id STRING(1) NOT NULL OPTIONS(description='DIF Funktion (I/U/D)'),
dif_typ_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DIF Typ (Mult., Add., Abs.)'),
menge_einh_id STRING(3) NOT NULL OPTIONS(description='Mengeneinheit'),
dif_status_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DIF Status_2 '),
dif_wert NUMERIC(18,3) NOT NULL OPTIONS(description='DIF Wert'),
dif_kommentar STRING(100) OPTIONS(description='DIF Kommentar'),
dif_timestamp DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL,
art_cluster_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Artikelcluster ID'),
wup_cluster_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Marktcluster ID'),
werbegruppe_fleisch STRING(10) DEFAULT '-1' NOT NULL OPTIONS(description='Werbegruppe Fleisch'),
dateiname STRING(255) DEFAULT ' ' OPTIONS(description='Dateiname (bei Sharepoint-Upload)'),
dat_upload DATE OPTIONS(description='Datum (bei Sharepoint-Upload)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Transaction Service Table for Autodispo Report');