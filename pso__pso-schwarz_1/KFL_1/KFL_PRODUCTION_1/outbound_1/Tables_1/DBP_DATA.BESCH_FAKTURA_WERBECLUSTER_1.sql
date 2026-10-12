--==============================================================
-- Table: besch_faktura_werbecluster_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_faktura_werbecluster_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_faktura_werbecluster_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
kjwo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahreswoche, Format JJJJWW'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='"Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig);                        Output: 7stellige L&S-ID + Counter = 9stellige ArtikelID. WWNNNNPCC (Warengruppe, Nummer, Prüfziffer, Counter)                        Regel: Neuer Artikel_1 -> Counter +1"            '),
faktura_menge_af_1fw NUMERIC(18,3) NOT NULL OPTIONS(description='Fakturamenge BME AF der ersten Folgewerbewoche'),
faktura_menge_af_2fw NUMERIC(18,3) NOT NULL OPTIONS(description='Fakturamenge BME AF der zweiten Folgewerbewoche'),
faktura_menge_af_3fw NUMERIC(18,3) NOT NULL OPTIONS(description='Fakturamenge BME AF der dritten Folgewerbewoche'),
faktura_menge_af_6vw NUMERIC(18,3) NOT NULL OPTIONS(description='Fakturamenge BME AF der sechsten Vorwerbewoche'),
faktura_menge_sa_1vw NUMERIC(18,3) NOT NULL OPTIONS(description='Fakturamenge BME SA der ersten Vorwerbewoche'),
faktura_menge_sa_ww NUMERIC(18,3) NOT NULL OPTIONS(description='Fakturamenge BME SA der aktuellen Werbewoche'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, kjwo, wg_id, art_id) NOT ENFORCED
) OPTIONS(description='AIS - Aggregat für Fakturmengen auf Wochenebene - MULTISET');