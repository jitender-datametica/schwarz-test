CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_ANLAGE_KLASSE_SPR_ZU_EN AS
-- 22.03.2013 twie: Sprachzuordung für Anlageklassen

   SELECT
   mandant_id,
   anlage_klasse_id,
   anlage_klasse_bez_kurz,
   anlage_klasse_bez

   FROM dbp_view.v_anlage_klasse_spr_zu

   WHERE  spr_id=24
   AND anlage_klasse_bez_kurz <> 'inaktiv';