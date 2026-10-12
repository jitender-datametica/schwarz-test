CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_PLATZIERUNGSWG_1
(
mandant_id
,platzierungswg_id
,platzierungswg_nr
)
AS
   SELECT
  mandant_id, platzierungswg_id, platzierungswg_nr
   FROM dbp_view.v_l_platzierungswg_1
   WHERE mandant_id =1;