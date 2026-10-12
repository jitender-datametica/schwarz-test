CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_L_UNTERNMNS_BEREICH
(
mandant_id
,unternehmens_bereich_id
)
AS
   SELECT
   v01.mandant_id, v01.unternehmens_bereich_id

   FROM dbp_view.v_l_unternmns_bereich v01



;