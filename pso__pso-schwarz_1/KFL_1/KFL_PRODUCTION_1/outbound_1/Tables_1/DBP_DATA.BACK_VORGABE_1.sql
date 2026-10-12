--==============================================================
-- Table: back_vorgabe_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: back_vorgabe_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.back_vorgabe_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_cluster_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID eines Wup_1 Clusters. Wird im DWH erzeugt'),
wug_cluster_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID eines WGI-Cluster. Surrogate-Key, wird im DWH erstellt'),
back_drehklasse_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der für den Backshop definierten Drehklasse, z.Bsp. LD'),
aktion_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Aktion_1-Flag. ! = Aktion_1, 0 = nicht in Aktion_1'),
key_bc_bez STRING(100) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='In der Quelle der sprechende Schlüssel der Tabelle aus dem Element key_bc. Wird compressed'),
aufschlag_zeit NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='Aufschlag Uhrzeit aus auf_uz'),
ant_mag NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='Anteil Minimum am Gesamt aus ant_mag'),
faktor_ist NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='Faktor auf Ist aus fak_ist'),
min_gesamt_fs NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='Minimum Gesamt Frühstart aus min_gf'),
ant_min_fs NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='Anteil Minimum Frühstart aus ant_mf'),
prognoseart STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL
OPTIONS(description='Prognoseart, z.Bsp. fc_max. Ist bisher im Modell nicht abgebildet, fc_max entspricht menge_prognose_max in der Tabelle fur_prognose_1 aus prog_art'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_cluster_id, wug_cluster_id, aktion_fg) NOT ENFORCED
) OPTIONS(description='VIS Backshop - Parameter für den Backplan aus der Quelltabelle zek_bake_cntrl');