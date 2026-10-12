--==============================================================
-- Table: art_gp_verhandlung_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gp_verhandlung_zu
   generated from Powerdesigner on Mittwoch, 3. Januar 2024 14:39:52
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_GP_VERHANDLUNG_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   ivn_gruppe_id                       INTEGER     COMMENT 'Kauflandweite eindeutige Nummer zur Einordnung von Gruppen von Atrikel-Lieferantenbeziehungen in Ländern zu konzernweiten Gruppen',
   ivn_verhandlungs_cluster_id         INTEGER     COMMENT 'Kauflandweite eindeutige IVN Verhandlungs Cluster fasst die in der IVN schon zusammengefassten Artikel/Lieferant/Land Kombinationen 
            innerhalb der IVN zu verschiedenen IVN-Verhandlungs-Clustern (Gruppen) zusammen.
            Alle möglichen IVN-Verhandlungs-Cluster können in allen IVN-Gruppen vorkommen.',
   ivn_sortimentsgruppe_id             INTEGER     COMMENT 'Kauflandweite eindeutige Nummer die eine IVN Segmentgruppe identifiziert.
            Die IVN-Sortimentgruppe teilt die Artikel in Gruppen ein die in verschiedenen IVN-Verhandlungsclustern
            und verschiedenen IVN Gruppen vorkommt und ist nicht von IVN-Guppe und IVN-Verhandlungscluster abhängig.
            Für jede Artikel-Lieferant-Land-Kombination kann nur eine IVN-Segmentgruppe zugeordnet werden. 
            ',
   quellsystem_id                      INTEGER     COMMENT 'ID des Quellsystems.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_GP_VERHANDLUNG_ZU PRIMARY KEY (mandant_id, art_id, gp_id) NOT ENFORCED
)  COMMENT = 'Mandant - Artikel - Geschäftspartner zu IVN Gruppe, IVN Verhandlungs Cluster und IVN Sortimentsgruppe.
             Stellt die Beziehung zwischen Artikel und Geschäftspartner pro Land für Verhandlungen da, wobei nur Geschäftspartner berücksichtigt werden, die in den Bewegungsdaten der letzten 3 Jahre im Ein- oder Verkauf auftauchen.
             Es gibt jeweils eine eindeutige Zuordnung von mandant_id, art_id, und gp_id.
             IVN Gruppe (nur IVN Group in Quelle), 
             IVN Verhandlungs Cluster (IVN Cluster in Quelle) 
             und IVN Sortimentgruppe (IVN Segment in Quelle)';
