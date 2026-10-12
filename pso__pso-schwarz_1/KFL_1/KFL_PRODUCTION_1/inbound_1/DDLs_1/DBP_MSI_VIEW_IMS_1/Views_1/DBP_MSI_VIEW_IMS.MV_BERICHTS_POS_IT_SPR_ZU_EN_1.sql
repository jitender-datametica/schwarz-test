CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_BERICHTS_POS_IT_SPR_ZU_EN_1 AS
-- 22.03.2013 twie: Sprachzuordung für Berichtspositionen IT
-- 23.04.2013 AL: bechits_position_it_char_id
-- 27.06.2013 twie: wenn keine Landessprache (ls) vorhanden ist, de ausgeben

   SELECT
   de.berichts_position_it_id,
   CASE WHEN de.berichts_position_it_id < 10
   THEN '0' || CAST (de.berichts_position_it_id AS CHAR(1))
   ELSE CAST(de.berichts_position_it_id AS CHAR(2))
   END   AS berichts_position_it_char_id,
   COALESCE(ls.berichts_position_it_bez, de.berichts_position_it_bez) AS berichts_position_it_bez

   FROM dbp_view.v_berichts_pos_it_spr_zu_1    de
   LEFT OUTER JOIN
   (
   SELECT *
   FROM dbp_view.v_berichts_pos_it_spr_zu_1
   WHERE spr_id = 24
   ) ls
   ON de.berichts_position_it_id = ls.berichts_position_it_id

   WHERE de.spr_id = 22
   ;