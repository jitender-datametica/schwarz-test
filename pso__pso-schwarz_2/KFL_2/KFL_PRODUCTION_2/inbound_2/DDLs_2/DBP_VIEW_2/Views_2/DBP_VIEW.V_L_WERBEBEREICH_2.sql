CREATE OR REPLACE VIEW DBP_VIEW.V_L_WERBEBEREICH_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,werbebereich_cd                          COMMENT 'Code des Werbebereichs.'
  ,werbebereich_bez                         COMMENT 'Werbebereich - Bezeichnung.'
)
COMMENT = 'Bündelung von mehreren werbeteams zu einem Bereich.'
 AS 
    SELECT 
        mandant_id,
        werbebereich_cd,
        werbebereich_bez

FROM DBP_DATA.L_WERBEBEREICH_2 ;