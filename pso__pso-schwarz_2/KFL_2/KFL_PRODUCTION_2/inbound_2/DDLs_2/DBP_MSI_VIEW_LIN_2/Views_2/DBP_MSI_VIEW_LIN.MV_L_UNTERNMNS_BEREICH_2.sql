CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_L_UNTERNMNS_BEREICH_2
(
mandant_id
,unternehmens_bereich_id
)
AS
   SELECT
   mandant_id, unternehmens_bereich_id
   FROM dbp_view.v_l_unternmns_bereich_2
;