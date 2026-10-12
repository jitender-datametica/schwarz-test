CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_BERICHTS_POS_INVEST_1 AS
-- 22.03.2013 twie: Lookup für Berichtspositionen Investitionen
-- 07.08.2013 twie: neue Gruppe_1 80 (AIB) zugeordnet
-- 14.07.2016 twie: Nachtrag AP0001938 ahk_aufwand_id nicht mehr manuell zuordnen, kommt aus Tabelle, siehe mv_l_berichts_pos_inv_grp_1

   SELECT
   berichts_position_invest_id,
   berichts_pos_invest_grp_id

   FROM dbp_view.v_l_berichts_pos_invest_1
;