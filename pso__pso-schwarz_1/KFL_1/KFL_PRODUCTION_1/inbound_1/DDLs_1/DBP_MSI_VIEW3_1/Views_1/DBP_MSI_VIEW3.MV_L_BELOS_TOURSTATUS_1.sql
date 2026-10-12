CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_BELOS_TOURSTATUS_1
--   19.04.2010 AL View erstellt.
(
mandant_id
,belos_tourstatus_id
)
AS
   SELECT
  mandant_id, belos_tourstatus_id
   FROM dbp_view.v_l_belos_tourstatus_1;