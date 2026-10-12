-- somit würde jemand mit Sprache DE keine KMO Daten sehen

-- 11.02.2016 twie: Sprachtabelle  Ausgabegrund für Gutschein

-- nicht auf spr_id filtern, da für jeden Mandant nur eine spr_id vorhanden ist

-- Sprachtabelle pro Land erst nutzbar, wenn auch mehrere Sprachen pro Eintrag gepflegt sind.

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_ausgabegrund_spr_zu (ausgeber_id, mandant_id, ausgeber_bez)
AS -- nur GEKU relevante
 SELECT ausgeber_id,
 mandant_id,
 ausgeber_bez
FROM kfl_production_dbp_view.v_ausgeber_spr_zu
WHERE ausgeber_id = 'KDM004'
 OR ausgeber_id = 'KDM005';