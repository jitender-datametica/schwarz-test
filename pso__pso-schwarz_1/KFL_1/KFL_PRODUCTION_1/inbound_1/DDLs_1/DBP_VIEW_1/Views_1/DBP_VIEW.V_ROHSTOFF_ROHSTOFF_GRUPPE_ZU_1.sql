CREATE OR REPLACE VIEW DBP_VIEW.V_ROHSTOFF_ROHSTOFF_GRUPPE_ZU_1 (
   rohstoff_nr                              COMMENT 'Mintecs Interne ID des Rohstoffs.'
  ,rohstoff_gruppe_typ_id                   COMMENT 'ID des Gruppierungstyps eines Rohstoffs.'
  ,rohstoff_gruppe_name                     COMMENT 'Name der Gruppe_1 eines Rohstoffs nach Gruppierungstyp.'
  ,rohstoff_blend_kfl_cd                    COMMENT 'Ein Blend kann einem Rohstoff_1 zugeordnet werden. Diese Zuordnung ist über die Subkategorie des Rohstoffs eindeutig'
  ,rohstoff_cluster_id                      COMMENT 'Rohstoffe können für eine_1 Rohstoffgruppe einem Cluster zugeordnet werden, welches als Sortierkriterium zur Anzeige im FE verwendet werden kann. Aktuell nur für rohstoff_gruppe_typ_id = 2 verwendet.'
)
COMMENT = 'Zuordnungstabelle zwischen Rohstoff_1 und Rohstoffsgruppe nach Gruppierungstyp.'
 AS 
    SELECT 
        rohstoff_nr,
        rohstoff_gruppe_typ_id,
        rohstoff_gruppe_name,
        rohstoff_blend_kfl_cd,
        rohstoff_cluster_id

FROM DBP_DATA.ROHSTOFF_ROHSTOFF_GRUPPE_ZU_1 ;