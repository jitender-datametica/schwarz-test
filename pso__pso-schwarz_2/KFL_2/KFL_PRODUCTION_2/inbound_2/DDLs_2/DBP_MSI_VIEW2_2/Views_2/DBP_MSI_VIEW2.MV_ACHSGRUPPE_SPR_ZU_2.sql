CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ACHSGRUPPE_SPR_ZU_2
(
mandant_id
,achsgruppe_id
,spr_id
,achsgruppe_bez
)
AS
   SELECT
  mandant_id, achsgruppe_id, spr_id, achsgruppe_bez
   FROM dbp_view.v_achsgruppe_spr_zu_2
   WHERE mandant_id =1
   AND spr_id = 22;