CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_BERICHTS_POS_IT_RWI_SPR_ZU AS
--17.09.2013 AL neu erstellt analog .mv_berichts_pos_it_spr_zu

   SELECT

   berichts_position_it_id AS  berichts_position_it_rwi_id,
   CASE WHEN berichts_position_it_id < 10
   THEN '0' || CAST (berichts_position_it_id AS CHAR(1))
   ELSE CAST(berichts_position_it_id AS CHAR(2))
   END   AS berichts_position_it_char_id,
   berichts_position_it_bez

   FROM dbp_view.v_berichts_pos_it_spr_zu

   WHERE  spr_id=22;