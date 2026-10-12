CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_BERICHTS_POS_INVG_SPR_ZU AS
-- 04.04.2013 twie: Sprachzuordung für Gruppe Berichtspositionen Investitionen

   SELECT
   berichts_pos_invest_grp_id,
   berichts_pos_invest_grp_bez

   FROM dbp_view.v_berichts_pos_inv_grp_spr_zu

   WHERE  spr_id=22
;