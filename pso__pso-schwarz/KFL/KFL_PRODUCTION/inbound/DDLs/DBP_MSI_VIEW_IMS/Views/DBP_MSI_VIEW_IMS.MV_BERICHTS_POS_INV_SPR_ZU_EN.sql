CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_BERICHTS_POS_INV_SPR_ZU_EN AS
--22.03.2013 twie: Sprachzuordung für Berichtspositionen Investitionen
--27.06.2013 twie: wenn keine Landessprache (ls) vorhanden ist, de ausgeben

   SELECT
   de.berichts_position_invest_id,
   COALESCE(ls.berichts_position_invest_bez, de.berichts_position_invest_bez) AS berichts_position_invest_bez

   FROM dbp_view.v_berichts_pos_invest_spr_zu  de
   LEFT OUTER JOIN
   (
   SELECT *
   FROM dbp_view.v_berichts_pos_invest_spr_zu
   WHERE spr_id = 24
   ) ls
   ON de.berichts_position_invest_id = ls.berichts_position_invest_id

   WHERE de.spr_id = 22
   ;