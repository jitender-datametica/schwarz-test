CREATE OR REPLACE VIEW DBP_VIEW.V_L_ANGEBOT_TYP_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,angebot_typ_cd                           COMMENT 'Alphanumerischer Code des Angebotstyp.'
)
COMMENT = 'Lookuptabelle der möglichen Typen eines Angebotes.'
 AS 
    SELECT 
        mandant_id,
        angebot_typ_cd
FROM DBP_DATA.L_ANGEBOT_TYP_1 ;