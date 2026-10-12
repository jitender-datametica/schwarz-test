CREATE OR REPLACE VIEW DBP_VIEW.V_TEMPERATUR_SPR_ZU (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,temperatur_id                            COMMENT 'Kennzeichen für den Temperaturbereich, z.Bsp. 3'
  ,spr_id                                   COMMENT 'ID der Sprache'
  ,temperatur_bez                           COMMENT 'Bezeichnung für den Temperaturbereich, z.Bsp. Gefrierware'
)
COMMENT = 'TP2_AIS - Sprachabhängige Bezeichnungen der Temperaturkennzeichen'
 AS 
    SELECT 
        mandant_id,
        temperatur_id,
        spr_id,
        temperatur_bez

FROM DBP_DATA.TEMPERATUR_SPR_ZU ;