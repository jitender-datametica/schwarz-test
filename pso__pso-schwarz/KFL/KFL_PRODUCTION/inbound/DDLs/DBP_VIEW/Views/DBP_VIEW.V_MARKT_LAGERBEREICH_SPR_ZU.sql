CREATE OR REPLACE VIEW DBP_VIEW.V_MARKT_LAGERBEREICH_SPR_ZU (
   mandant_id                               COMMENT 'Mandant im DWH.'
  ,markt_lagerbereich_id                    COMMENT 'ID des Lagerbereichs in der Filiale.'
  ,spr_id                                   COMMENT 'ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.'
  ,markt_lagerbereich_bez                   COMMENT 'Sprachabhängige Bezeichnung der Lagerbereichen in der Filiale.'
)
COMMENT = 'Diese Tabelle enthält die sprachabhänigige Bezeichnungen der Lagerbereichen in der Filiale. Wird manuell beladen.'
 AS 
    SELECT 
        mandant_id,
        markt_lagerbereich_id,
        spr_id,
        markt_lagerbereich_bez

FROM DBP_DATA.MARKT_LAGERBEREICH_SPR_ZU ;