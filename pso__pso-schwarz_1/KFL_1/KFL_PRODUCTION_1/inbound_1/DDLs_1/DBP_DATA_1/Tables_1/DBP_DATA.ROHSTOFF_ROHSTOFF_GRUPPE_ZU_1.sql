--==============================================================
-- Table: rohstoff_rohstoff_gruppe_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rohstoff_rohstoff_gruppe_zu_1
   generated from Powerdesigner on Donnerstag, 25. September 2025 18:01:42
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ROHSTOFF_ROHSTOFF_GRUPPE_ZU_1 (
   rohstoff_nr                         VARCHAR(20)      NOT NULL COMMENT 'Mintecs Interne ID des Rohstoffs.',
   rohstoff_gruppe_typ_id              NUMBER(38,0)     NOT NULL COMMENT 'ID des Gruppierungstyps eines Rohstoffs.',
   rohstoff_gruppe_name                VARCHAR(100)     NOT NULL COMMENT 'Name der Gruppe_1 eines Rohstoffs nach Gruppierungstyp.',
   rohstoff_blend_kfl_cd               VARCHAR(100)      COMMENT 'Ein Blend kann einem Rohstoff_1 zugeordnet werden. Diese Zuordnung ist über die Subkategorie des Rohstoffs eindeutig',
   rohstoff_cluster_id                 NUMBER(38,0)     COMMENT 'Rohstoffe können für eine_1 Rohstoffgruppe einem Cluster zugeordnet werden, welches als Sortierkriterium zur Anzeige im FE verwendet werden kann. Aktuell nur für rohstoff_gruppe_typ_id = 2 verwendet.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ROHSTOFF_ROHSTOFF_GRUPPE_ZU PRIMARY KEY (rohstoff_nr, rohstoff_gruppe_typ_id, rohstoff_gruppe_name) NOT ENFORCED
)  COMMENT = 'Zuordnungstabelle zwischen Rohstoff_1 und Rohstoffsgruppe nach Gruppierungstyp.';
