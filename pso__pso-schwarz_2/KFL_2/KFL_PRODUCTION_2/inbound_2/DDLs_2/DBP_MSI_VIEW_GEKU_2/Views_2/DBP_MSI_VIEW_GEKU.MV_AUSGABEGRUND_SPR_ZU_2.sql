CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_AUSGABEGRUND_SPR_ZU_2
AS
-- 11.02.2016 twie: Sprachtabelle  Ausgabegrund für Gutschein_2
-- nicht auf spr_id filtern, da für jeden Mandant_2 nur eine_2 spr_id vorhanden ist
-- somit würde jemand mit Sprache DE keine KMO Daten sehen
-- Sprachtabelle pro Land_2 erst nutzbar, wenn auch mehrere Sprachen pro Eintrag gepflegt sind.
    
   SELECT

   ausgeber_id
   ,mandant_id
   ,ausgeber_bez

   FROM dbp_view.v_ausgeber_spr_zu_2

   --nur GEKU relevante
   WHERE (ausgeber_id = 'KDM004'
   OR ausgeber_id = 'KDM005' );