CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_BERICHTS_POS_INVG_SPR_ZU_1 AS
-- 04.04.2013 twie: Sprachzuordung für Gruppe_1 Berichtspositionen Investitionen

   SELECT
   berichts_pos_invest_grp_id,
   berichts_pos_invest_grp_bez

   FROM dbp_view.v_berichts_pos_inv_grp_spr_zu_1

   WHERE  spr_id=22
;