CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.BACK_VORGABE_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
WUP_CLUSTER_ID INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines Wup_2 Clusters. Wird im DWH erzeugt'),
WUG_CLUSTER_ID INTEGER NOT NULL
OPTIONS(description='Eindeutige ID eines WGI-Cluster. Surrogate-Key, wird im DWH erstellt'),
BACK_DREHKLASSE_ID STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der für den Backshop definierten Drehklasse, z.Bsp. LD'),
AKTION_FG INTEGER NOT NULL OPTIONS(description='Aktion_2-Flag. ! = Aktion_2, 0 = nicht in Aktion_2'),
KEY_BC_BEZ STRING(100) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='In der Quelle der sprechende Schlüssel der Tabelle aus dem Element key_bc. Wird compressed'),
AUFSCHLAG_ZEIT NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='Aufschlag Uhrzeit aus auf_uz'),
ANT_MAG NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='Anteil Minimum am Gesamt aus ant_mag'),
FAKTOR_IST NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='Faktor auf Ist aus fak_ist'),
MIN_GESAMT_FS NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='Minimum Gesamt Frühstart aus min_gf'),
ANT_MIN_FS NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='Anteil Minimum Frühstart aus ant_mf'),
PROGNOSEART STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL
OPTIONS(description='Prognoseart, z.Bsp. fc_max. Ist bisher im Modell nicht abgebildet, fc_max entspricht menge_prognose_max in der Tabelle fur_prognose_2 aus prog_art'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, WUP_CLUSTER_ID, WUG_CLUSTER_ID, AKTION_FG) NOT ENFORCED
) OPTIONS(description='VIS Backshop - Parameter für den Backplan aus der Quelltabelle zek_bake_cntrl');