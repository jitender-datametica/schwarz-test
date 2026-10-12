CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_BERICHTS_POS_INV_SPR_ZU AS
-- 22.03.2013 twie: Sprachzuordung für Berichtspositionen Investitionen

   SELECT
   berichts_position_invest_id,
   berichts_position_invest_bez

   FROM dbp_view.v_berichts_pos_invest_spr_zu

   WHERE  spr_id=22
;