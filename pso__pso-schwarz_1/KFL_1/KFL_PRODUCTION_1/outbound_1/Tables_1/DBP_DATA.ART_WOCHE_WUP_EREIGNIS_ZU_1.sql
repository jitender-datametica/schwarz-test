--==============================================================
-- Table: art_woche_wup_ereignis_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_woche_wup_ereignis_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_woche_wup_ereignis_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
kjwo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
ereignis_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ereignis_1 ID (fortlaufende Nummer)'),
ereignistyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ereignistyp_1 ID, Gruppierung der Ereignisse in z.Bsp. Allgemeine Feiertage, Sonntagsöffnungen, ...'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, kjwo, wup_id, nb_id, ereignis_id, ereignistyp_id) NOT ENFORCED
)
OPTIONS(description='VIS - Vom Markt getroffene Maßnahmen z.Bsp.bei hohen Abschriften. Wird im DWH intern per TS und Makro  befüllt');