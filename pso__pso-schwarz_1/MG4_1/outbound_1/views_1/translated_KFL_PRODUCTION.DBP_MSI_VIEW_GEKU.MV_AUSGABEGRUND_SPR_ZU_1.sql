-- somit würde jemand mit Sprache DE keine KMO Daten sehen

-- 11.02.2016 twie: Sprachtabelle  Ausgabegrund für Gutschein_1

-- nicht auf spr_id filtern, da für jeden Mandant_1 nur eine_1 spr_id vorhanden ist

-- Sprachtabelle pro Land_1 erst nutzbar, wenn auch mehrere Sprachen pro Eintrag gepflegt sind.

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_ausgabegrund_spr_zu_1 (ausgeber_id, mandant_id, ausgeber_bez)
AS -- nur GEKU relevante
 SELECT ausgeber_id,
 mandant_id,
 ausgeber_bez
FROM kfl_production_dbp_view.v_ausgeber_spr_zu_1
WHERE ausgeber_id = 'KDM004'
 OR ausgeber_id = 'KDM005';