CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_SONDERABWICKLUNG_1
--   19.04.2010 AL View erstellt.
(
mandant_id
,sonderabwicklung_id
)
AS
   SELECT
  mandant_id, sonderabwicklung_id
   FROM dbp_view.v_l_sonderabwicklung_1
;