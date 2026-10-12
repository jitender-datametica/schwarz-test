CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_UNTERNMNS_BEREICH_SPR_ZU_CZ
(
mandant_id
,unternehmens_bereich_id
,spr_id
,unternehmens_bereich_bez
)
AS
   SELECT
   mandant_id, unternehmens_bereich_id, spr_id, unternehmens_bereich_bez
   FROM dbp_view.v_unternmns_bereich_spr_zu
   WHERE spr_id = 124
;