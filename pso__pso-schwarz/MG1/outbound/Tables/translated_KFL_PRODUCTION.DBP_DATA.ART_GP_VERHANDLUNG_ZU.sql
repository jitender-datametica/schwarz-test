CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_GP_VERHANDLUNG_ZU (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH.'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
GP_ID INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
IVN_GRUPPE_ID INTEGER
OPTIONS(description='Kauflandweite eindeutige Nummer zur Einordnung von Gruppen von Atrikel-Lieferantenbeziehungen in Ländern zu konzernweiten Gruppen'),
IVN_VERHANDLUNGS_CLUSTER_ID INTEGER
OPTIONS(description='Kauflandweite eindeutige IVN Verhandlungs Cluster fasst die in der IVN schon zusammengefassten Artikel/Lieferant/Land Kombinationen\n            innerhalb der IVN zu verschiedenen IVN-Verhandlungs-Clustern (Gruppen) zusammen.\n            Alle möglichen IVN-Verhandlungs-Cluster können in allen IVN-Gruppen vorkommen.'),
IVN_SORTIMENTSGRUPPE_ID INTEGER
OPTIONS(description='Kauflandweite eindeutige Nummer die eine IVN Segmentgruppe identifiziert.\n            Die IVN-Sortimentgruppe teilt die Artikel in Gruppen ein die in verschiedenen IVN-Verhandlungsclustern\n            und verschiedenen IVN Gruppen vorkommt und ist nicht von IVN-Guppe und IVN-Verhandlungscluster abhängig.\n            Für jede Artikel-Lieferant-Land-Kombination kann nur eine IVN-Segmentgruppe zugeordnet werden.\n            '),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
QUELLSYSTEM_ID INTEGER OPTIONS(description='ID des Quellsystems.'),
PRIMARY KEY (MANDANT_ID, ART_ID, GP_ID) NOT ENFORCED
)
OPTIONS(description='Mandant - Artikel - Geschäftspartner zu IVN Gruppe, IVN Verhandlungs Cluster und IVN Sortimentsgruppe.\n             Stellt die Beziehung zwischen Artikel und Geschäftspartner pro Land für Verhandlungen da, wobei nur Geschäftspartner berücksichtigt werden, die in den Bewegungsdaten der letzten 3 Jahre im Ein- oder Verkauf auftauchen.\n             Es gibt jeweils eine eindeutige Zuordnung von mandant_id, art_id, und gp_id.\n             IVN Gruppe (nur IVN Group in Quelle),\n             IVN Verhandlungs Cluster (IVN Cluster in Quelle)\n             und IVN Sortimentgruppe (IVN Segment in Quelle)');