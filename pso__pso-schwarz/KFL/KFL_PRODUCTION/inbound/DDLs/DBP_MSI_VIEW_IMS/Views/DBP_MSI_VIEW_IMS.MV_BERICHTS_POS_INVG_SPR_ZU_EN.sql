CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_BERICHTS_POS_INVG_SPR_ZU_EN AS
-- 04.04.2013 twie: Sprachzuordung für Gruppe Berichtspositionen Investitionen
-- 27.06.2013 twie: wenn keine Landessprache (ls) vorhanden ist, de ausgeben

   SELECT
   de.berichts_pos_invest_grp_id,
   COALESCE(ls.berichts_pos_invest_grp_bez, de.berichts_pos_invest_grp_bez) AS berichts_pos_invest_grp_bez

   FROM dbp_view.v_berichts_pos_inv_grp_spr_zu de
   LEFT OUTER JOIN
   (
   SELECT *
   FROM dbp_view.v_berichts_pos_inv_grp_spr_zu
   WHERE spr_id = 24
   ) ls
   ON de.berichts_pos_invest_grp_id = ls.berichts_pos_invest_grp_id

   WHERE de.spr_id = 22
   ;