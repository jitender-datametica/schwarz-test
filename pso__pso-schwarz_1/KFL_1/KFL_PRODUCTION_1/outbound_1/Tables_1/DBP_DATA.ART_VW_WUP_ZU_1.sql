--==============================================================
-- Table: art_vw_wup_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_vw_wup_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_vw_wup_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
vw_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Vertriebsweges'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
rabatt_zul_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flag zeigt an, ob ein Rabatt zulässig ist. Aus rbzul. Zulääsig = 1, sonst 0'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, vw_id, art_id) NOT ENFORCED
) OPTIONS(description='AIS_KMO - Artikel_1-Markt_Vertriebsweg Tabelle aus der Quelle wlk2_1');