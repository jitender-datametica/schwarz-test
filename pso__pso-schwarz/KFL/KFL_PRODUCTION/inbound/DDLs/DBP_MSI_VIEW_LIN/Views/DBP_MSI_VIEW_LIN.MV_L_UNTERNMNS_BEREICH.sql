CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_L_UNTERNMNS_BEREICH
(
mandant_id
,unternehmens_bereich_id
)
AS
   SELECT
   mandant_id, unternehmens_bereich_id
   FROM dbp_view.v_l_unternmns_bereich
;