CREATE OR REPLACE VIEW DBP_VIEW.V_L_RABATT_TYP_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,rabatt_typ_id                            COMMENT 'ID des Rabatt Typs. Gibt die Art_2 des gewährten Rabattes an, bspw. Normalpreis (1), Rabattpreis (2), Absoluter Rabatt (3). etc.'
)
COMMENT = 'Lookuptabelle der möglichen Arten des gewährten Rabattes.'
 AS 
    SELECT 
        mandant_id,
        rabatt_typ_id
FROM DBP_DATA.L_RABATT_TYP_2 ;