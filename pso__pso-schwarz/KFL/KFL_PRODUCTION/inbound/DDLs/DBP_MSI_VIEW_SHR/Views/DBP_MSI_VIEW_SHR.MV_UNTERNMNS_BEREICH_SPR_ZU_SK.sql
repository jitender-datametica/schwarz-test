CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_UNTERNMNS_BEREICH_SPR_ZU_SK
(
mandant_id
,unternehmens_bereich_id
,spr_id
,unternehmens_bereich_bez
)
AS
   SELECT
   v01.mandant_id, v01.unternehmens_bereich_id, v01.spr_id, v01.unternehmens_bereich_bez

   FROM dbp_view.v_unternmns_bereich_spr_zu v01
   WHERE spr_id = 108
;