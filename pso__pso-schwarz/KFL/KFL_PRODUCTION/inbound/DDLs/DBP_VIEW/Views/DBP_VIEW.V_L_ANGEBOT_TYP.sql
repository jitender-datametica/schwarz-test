CREATE OR REPLACE VIEW DBP_VIEW.V_L_ANGEBOT_TYP (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,angebot_typ_cd                           COMMENT 'Alphanumerischer Code des Angebotstyp.'
)
COMMENT = 'Lookuptabelle der möglichen Typen eines Angebotes.'
 AS 
    SELECT 
        mandant_id,
        angebot_typ_cd
FROM DBP_DATA.L_ANGEBOT_TYP ;