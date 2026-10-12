CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_PRODUKTGRUPPE_SPR_ZU_2

(
mandant_id
,produktgruppe_id
,spr_id
,produktgruppe_bez
)
AS
   SELECT
  mandant_id, produktgruppe_id, spr_id, produktgruppe_bez
   FROM dbp_view.v_produktgruppe_spr_zu_2
   WHERE mandant_id =1
   AND spr_id = 22;