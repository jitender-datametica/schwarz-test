CREATE OR REPLACE VIEW DBP_VIEW.V_L_WERBETEAM_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,werbeteam_cd                             COMMENT 'Code des Werbeteams'
  ,werbebereich_cd                          COMMENT 'Code des Werbebereichs'
  ,werbeteam_bez                            COMMENT 'Werbeteam - Bezeichnung'
)
COMMENT = 'Fachlich verantwortliche Personen (auch Planer genannt) die für eine_2 Kategorie an Artikel_2 die über die WGs identifziert werden, die Werbungen in Deutschland planen.
'
 AS 
    SELECT 
        mandant_id,
        werbeteam_cd,
        werbebereich_cd,
        werbeteam_bez

FROM DBP_DATA.L_WERBETEAM_2 ;