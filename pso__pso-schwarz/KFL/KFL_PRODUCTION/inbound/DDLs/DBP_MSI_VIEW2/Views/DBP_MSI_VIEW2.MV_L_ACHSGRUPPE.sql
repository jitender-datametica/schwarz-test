CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_ACHSGRUPPE
(
mandant_id
,achsgruppe_id
,produktgruppe_id
)
AS
   SELECT
  mandant_id, achsgruppe_id, produktgruppe_id
   FROM dbp_view.v_l_achsgruppe
   WHERE mandant_id =1;