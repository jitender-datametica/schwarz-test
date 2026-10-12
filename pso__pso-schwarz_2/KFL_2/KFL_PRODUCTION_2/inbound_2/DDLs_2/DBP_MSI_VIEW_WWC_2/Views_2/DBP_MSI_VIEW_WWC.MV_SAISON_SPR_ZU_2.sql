CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_SAISON_SPR_ZU_2
(
mandant_id
,SAISO
,spr_id
,saison_bez
)
AS

   SELECT
   v01.mandant_id, v01.saison_id AS SAISO, v01.spr_id, v01.saison_bez

   FROM dbp_view.v_saison_spr_zu_2 v01
   WHERE spr_id = 22
;