--==============================================================
-- Table: eps_druck_statistik_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: eps_druck_statistik_per_1
   generated from Powerdesigner on Freitag, 17. März 2023 11:13:03
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.eps_druck_statistik_per_1 (
eps_druck_statistik_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines Druckauftrags in der Druck-Statistik'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
kl_art_id BIGNUMERIC(38,0)
OPTIONS(description='7-stellige Artikelnummer bestehend aus 2 Stellen: Warengruppe 4 Stellen: Artikelnummer 1 Stelle: Prüfziffer'),
druck_anlass_id STRING(2) COLLATE 'und:ci' OPTIONS(description='Anlass des Drucks; (z.B. PE (Preiserhöhung).'),
datzeit_anforderung DATETIME OPTIONS(description='Zeitpunkt zu dem der Printjob gedruckt werden soll'),
datzeit_druck DATETIME OPTIONS(description='Zeitstempel, wann das Ettikett gerduckt wurde'),
containertyp_id BIGNUMERIC(38,0) OPTIONS(description='ID des Druckgrund (z.B. aus MDE, Änderungsdienst, Nachdruck,….)'),
layout_groesse_id BIGNUMERIC(38,0) OPTIONS(description='ID der Layoutgröße; (z.B. 1 = Mini, 9 = A4, …)'),
papierart_id BIGNUMERIC(38,0) OPTIONS(description='ID der Papierart; (z.B. 3 = weiss A4, 200 = neon-orange A4, …)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (eps_druck_statistik_id, mandant_id) NOT ENFORCED
) OPTIONS(description='VIS - Druckstatistik aus EPS (printstatitics)');