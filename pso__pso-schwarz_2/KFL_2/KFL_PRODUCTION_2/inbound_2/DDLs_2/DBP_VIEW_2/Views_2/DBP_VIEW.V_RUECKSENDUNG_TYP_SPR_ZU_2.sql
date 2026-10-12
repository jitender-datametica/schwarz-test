CREATE OR REPLACE VIEW DBP_VIEW.V_RUECKSENDUNG_TYP_SPR_ZU_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,ruecksendung_typ_kz                      COMMENT 'Code für die Art_2 der Rücksendung.'
  ,spr_id                                   COMMENT 'Sprache im DWH'
  ,ruecksendung_typ_bez                     COMMENT 'Bezeichnung der Retourenart eines von der Filiale zurückgegebenen Artikels in unterschiedlichen Sprachen.'
)
COMMENT = 'Sprachabhängige Bezeichnung des Rücksendungstypen'
 AS 
    SELECT 
        mandant_id,
        ruecksendung_typ_kz,
        spr_id,
        ruecksendung_typ_bez

FROM DBP_DATA.RUECKSENDUNG_TYP_SPR_ZU_2 ;