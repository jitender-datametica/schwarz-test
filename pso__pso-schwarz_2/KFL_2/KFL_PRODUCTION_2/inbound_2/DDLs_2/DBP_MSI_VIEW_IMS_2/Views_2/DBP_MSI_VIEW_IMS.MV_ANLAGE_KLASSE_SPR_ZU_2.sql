CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_ANLAGE_KLASSE_SPR_ZU_2 AS
-- 22.03.2013 twie: Sprachzuordung für Anlageklassen
-- 19.08.2013 twie: in en und KMO kein Fallback auf de, BED stellt sicher, dass Landessprache immer vorhanden
-- 20.08.2013/Gia

   SELECT
   mandant_id,
   anlage_klasse_id,
   anlage_klasse_bez_kurz,
   anlage_klasse_bez

   FROM dbp_view.v_anlage_klasse_spr_zu_2

   WHERE  spr_id=22
   AND anlage_klasse_bez_kurz <> 'inaktiv'
;