create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_AUSGABEGRUND_SPR_ZU(
	AUSGEBER_ID,
	MANDANT_ID,
	AUSGEBER_BEZ
) as
-- 11.02.2016 twie: Sprachtabelle  Ausgabegrund für Gutschein
-- nicht auf spr_id filtern, da für jeden Mandant nur eine spr_id vorhanden ist
-- somit würde jemand mit Sprache DE keine KMO Daten sehen
-- Sprachtabelle pro Land erst nutzbar, wenn auch mehrere Sprachen pro Eintrag gepflegt sind.
    
   SELECT

   ausgeber_id
   ,mandant_id
   ,ausgeber_bez

   FROM dbp_view.v_ausgeber_spr_zu

   --nur GEKU relevante
   WHERE (ausgeber_id = 'KDM004'
   OR ausgeber_id = 'KDM005' );