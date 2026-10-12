CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TS_ROHSTOFF_MONITORING_ANZEIGE_2 (
   rohstoff_nr                              COMMENT 'Mintecs Interne ID des Rohstoffs.'
  ,rohstoff_kategorie_kfl_name              COMMENT 'Kaufland interne Kategorische Zuordnung des Rohstoffs.'
  ,rohstoff_kfl_bez                         COMMENT 'Kaufland interne Bezeichnung des Rohstoffs.'
  ,rohstoff_subkategorie_kfl_name           COMMENT 'Kaufland interne Subkategorische Zuordnung des Rohstoffs.'
  ,rohstoff_blend_kfl_txt                   COMMENT 'Gemischtes Mineralölprodukt, das aus verschiedene Rohstoffe entsteht.'
  ,rohstoff_qualitaet_txt                   COMMENT 'Beschreibung der Qualität des Rohstoffs.'
  ,rohstoff_quell_bez                       COMMENT 'Enthält Informationen zur Quelle des Rohstoffes.'
  ,rohstoff_cluster_id                      COMMENT 'Rohstoffe können für eine_2 Rohstoffgruppe einem Cluster zugeordnet werden, welches als Sortierkriterium zur Anzeige im FE verwendet werden kann. Aktuell nur für rohstoff_gruppe_typ_id = 2 verwendet.'
  ,dat_anzeige_von                          COMMENT 'Gibt an, ab welchem Datum die Zuordnung zwischen den Rohstoffengruppen in die Rohstoffberichte gültig ist.'
  ,dat_anzeige_bis                          COMMENT 'Gibt an, bis zu welchem Datum die Zuordnung zwischen den Rohstoffengruppen in die Rohstoffberichte gültig ist.'
)
COMMENT = 'KFL Informationen über Rohstoff.'
 AS 
    SELECT 
        rohstoff_nr,
        rohstoff_kategorie_kfl_name,
        rohstoff_kfl_bez,
        rohstoff_subkategorie_kfl_name,
        rohstoff_blend_kfl_txt,
        rohstoff_qualitaet_txt,
        rohstoff_quell_bez,
        rohstoff_cluster_id,
        dat_anzeige_von,
        dat_anzeige_bis

FROM DBP_MSI_DATA.TS_ROHSTOFF_MONITORING_ANZEIGE_2 ;