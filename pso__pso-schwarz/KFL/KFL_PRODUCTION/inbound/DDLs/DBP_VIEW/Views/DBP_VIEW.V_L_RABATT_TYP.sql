CREATE OR REPLACE VIEW DBP_VIEW.V_L_RABATT_TYP (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,rabatt_typ_id                            COMMENT 'ID des Rabatt Typs. Gibt die Art des gewährten Rabattes an, bspw. Normalpreis (1), Rabattpreis (2), Absoluter Rabatt (3). etc.'
)
COMMENT = 'Lookuptabelle der möglichen Arten des gewährten Rabattes.'
 AS 
    SELECT 
        mandant_id,
        rabatt_typ_id
FROM DBP_DATA.L_RABATT_TYP ;