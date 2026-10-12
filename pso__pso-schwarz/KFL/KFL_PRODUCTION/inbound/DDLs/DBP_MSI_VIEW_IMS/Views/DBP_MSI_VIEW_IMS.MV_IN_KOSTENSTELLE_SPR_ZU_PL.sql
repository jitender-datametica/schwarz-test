CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IN_KOSTENSTELLE_SPR_ZU_PL AS
-- 21.08.2013 twie: Sprachzuordung für Kostenarten

   SELECT

   mandant_id,
   kostenstelle_id,
   krk_id,
   kostenstelle_bez

   FROM dbp_view.v_in_kostenstelle_spr_zu_per

   WHERE spr_id = 90

   QUALIFY ROW_NUMBER() OVER (PARTITION BY kostenstelle_id, mandant_id  ORDER BY dat_bis DESC NULLS LAST) =1
;