CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_GESCHAEFTSBEREICH_SPR_ZU_EN AS
-- 17.05.2013 twie: Sprachzuordung für Geschäftsbereich
-- 20.08.2013 twie: in en und KMO kein Fallback auf de, BED stellt sicher, dass Landessprache immer vorhanden

   SELECT
   mandant_id,
   geschaeftsbereich_id,
   geschaeftsbereich_bez

   FROM dbp_view.v_geschaeftsbereich_spr_zu

   WHERE  spr_id=24
;