CREATE OR REPLACE VIEW DBP_VIEW.V_RABATT_TYP_SPR_ZU_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,spr_id                                   COMMENT 'ID der Sprache'
  ,rabatt_typ_id                            COMMENT 'ID des Rabatt Typs. Gibt die Art_1 des gewährten Rabattes an, bspw. Normalpreis (1), Rabattpreis (2), Absoluter Rabatt (3). etc.'
  ,rabatt_typ_bez                           COMMENT 'Sprachabhängige Bezeichnung des Rabatttyps.'
)
COMMENT = 'Tabelle für sprachabhängige Bezeichnungen des Rabatttyps'
 AS 
    SELECT 
        mandant_id,
        spr_id,
        rabatt_typ_id,
        rabatt_typ_bez

FROM DBP_DATA.RABATT_TYP_SPR_ZU_1 ;