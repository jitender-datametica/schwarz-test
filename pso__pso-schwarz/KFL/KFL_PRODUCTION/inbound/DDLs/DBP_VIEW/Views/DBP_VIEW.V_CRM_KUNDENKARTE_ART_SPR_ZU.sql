CREATE OR REPLACE VIEW DBP_VIEW.V_CRM_KUNDENKARTE_ART_SPR_ZU (
   crm_kundenkarte_art_id                   COMMENT 'Art der Kundenkarte (Ausprägungen: 1 für digital, 2 für physisch, default 1), nicht zu verwechseln mit ods_bon_kopf.kundenkarte_typ_id das kennzeichnet, ob der Bon mit Payback- (1) oder Kundenkarte (2) erzeugt wurde.'
  ,spr_id                                   COMMENT 'ID der Sprache'
  ,crm_kundenkarte_art_bez                  COMMENT 'Bezeichnung des Kundenkartentyps.'
)
COMMENT = 'EK-KUN - CosmosDB CRM - Sprachzuordnungstabelle zu Art der Kundenkarte.'
 AS 
    SELECT 
        crm_kundenkarte_art_id,
        spr_id,
        crm_kundenkarte_art_bez

FROM DBP_DATA.CRM_KUNDENKARTE_ART_SPR_ZU ;