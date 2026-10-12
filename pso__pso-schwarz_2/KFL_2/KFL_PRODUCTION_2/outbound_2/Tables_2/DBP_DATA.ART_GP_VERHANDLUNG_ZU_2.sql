--==============================================================
-- Table: art_gp_verhandlung_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gp_verhandlung_zu_2
   generated from Powerdesigner on Mittwoch, 3. Januar 2024 14:39:52
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_gp_verhandlung_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
ivn_gruppe_id BIGNUMERIC(38,0)
OPTIONS(description='Kauflandweite eindeutige Nummer zur Einordnung von Gruppen von Atrikel-Lieferantenbeziehungen in Ländern zu konzernweiten Gruppen'),
ivn_verhandlungs_cluster_id BIGNUMERIC(38,0)
OPTIONS(description='Kauflandweite eindeutige IVN Verhandlungs Cluster fasst die in der IVN schon zusammengefassten Artikel_2/Lieferant/Land_2 Kombinationen             innerhalb der IVN zu verschiedenen IVN-Verhandlungs-Clustern (Gruppen) zusammen.            Alle möglichen IVN-Verhandlungs-Cluster können in allen IVN-Gruppen vorkommen.'),
ivn_sortimentsgruppe_id BIGNUMERIC(38,0)
OPTIONS(description='Kauflandweite eindeutige Nummer die eine_2 IVN Segmentgruppe identifiziert.            Die IVN-Sortimentgruppe teilt die Artikel_2 in Gruppen ein die in verschiedenen IVN-Verhandlungsclustern            und verschiedenen IVN Gruppen vorkommt und ist nicht von IVN-Guppe und IVN-Verhandlungscluster abhängig.            Für jede Artikel_2-Lieferant-Land_2-Kombination kann nur eine_2 IVN-Segmentgruppe zugeordnet werden.             '),
quellsystem_id BIGNUMERIC(38,0) OPTIONS(description='ID des Quellsystems.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, gp_id) NOT ENFORCED
)
OPTIONS(description='Mandant_2 - Artikel_2 - Geschäftspartner zu IVN Gruppe_2, IVN Verhandlungs Cluster und IVN Sortimentsgruppe.             Stellt die Beziehung zwischen Artikel_2 und Geschäftspartner pro Land_2 für Verhandlungen da, wobei nur Geschäftspartner berücksichtigt werden, die in den Bewegungsdaten der letzten 3 Jahre im Ein- oder Verkauf auftauchen.             Es gibt jeweils eine_2 eindeutige Zuordnung von mandant_id, art_id, und gp_id.             IVN Gruppe_2 (nur IVN Group in Quelle),              IVN Verhandlungs Cluster (IVN Cluster in Quelle)              und IVN Sortimentgruppe (IVN Segment in Quelle)');