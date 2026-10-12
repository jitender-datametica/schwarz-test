CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_AUFTRAGSART_SPR_ZU_2 (
   mandant_id,
   system_id,
   auftragsart_id,
   spr_id,
   auftragsart_bez
) AS
-- 20230717 staeblern Umstellung auf Session Variable
SELECT

   v01.mandant_id,
   v01.system_id,
   v01.auftragsart_id,
   v01.spr_id,
   v01.auftragsart_bez
FROM
   dbp_view.v_in_auftragsart_spr_zu_2 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id;