CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_PRODUKTGRUPPE
(
mandant_id
,produktgruppe_id
,platzierungswg_id
)
AS
   SELECT
  mandant_id, produktgruppe_id, platzierungswg_id
   FROM dbp_view.v_l_produktgruppe
   WHERE mandant_id =1;