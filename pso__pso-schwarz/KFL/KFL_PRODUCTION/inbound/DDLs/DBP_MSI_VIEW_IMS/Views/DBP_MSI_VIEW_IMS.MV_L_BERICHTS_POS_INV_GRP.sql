CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_BERICHTS_POS_INV_GRP AS
-- 22.03.2013 twie: Lookup für Gruppe Berichtspositionen Investition
-- 07.08.2013 twie: neue Gruppe 80 (AIB) zugeordnet
-- 06.04.2016 twie: ahk_aufwand_id aus Tabelle, nicht mehr in View ermitteln
--   Viewlogik bisher CASE WHEN berichts_pos_invest_grp_id in (-1,10,20,30,40,50) then 1
--   WHEN berichts_pos_invest_grp_id in (60,70) then 0
--   WHEN berichts_pos_invest_grp_id in (80) then 2
--   ELSE -1 END AS ahk_aufwand_id

   SELECT
   berichts_pos_invest_grp_id,
   ahk_aufwand_id

   FROM dbp_view.v_l_berichts_pos_inv_grp;