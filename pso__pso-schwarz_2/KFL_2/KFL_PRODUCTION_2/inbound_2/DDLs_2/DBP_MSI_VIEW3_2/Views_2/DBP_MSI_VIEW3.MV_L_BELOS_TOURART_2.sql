CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_BELOS_TOURART_2
--   19.04.2010 AL View erstellt.
(
mandant_id
,belos_tourart_id
)
AS
   SELECT
  mandant_id, belos_tourart_id
   FROM dbp_view.v_l_belos_tourart_2
;