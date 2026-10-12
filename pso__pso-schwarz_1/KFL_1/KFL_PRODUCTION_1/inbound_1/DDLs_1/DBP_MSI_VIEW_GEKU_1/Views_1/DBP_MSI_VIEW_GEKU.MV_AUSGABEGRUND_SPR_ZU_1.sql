CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_AUSGABEGRUND_SPR_ZU_1
AS
-- 11.02.2016 twie: Sprachtabelle  Ausgabegrund für Gutschein_1
-- nicht auf spr_id filtern, da für jeden Mandant_1 nur eine_1 spr_id vorhanden ist
-- somit würde jemand mit Sprache DE keine KMO Daten sehen
-- Sprachtabelle pro Land_1 erst nutzbar, wenn auch mehrere Sprachen pro Eintrag gepflegt sind.
    
   SELECT

   ausgeber_id
   ,mandant_id
   ,ausgeber_bez

   FROM dbp_view.v_ausgeber_spr_zu_1

   --nur GEKU relevante
   WHERE (ausgeber_id = 'KDM004'
   OR ausgeber_id = 'KDM005' );