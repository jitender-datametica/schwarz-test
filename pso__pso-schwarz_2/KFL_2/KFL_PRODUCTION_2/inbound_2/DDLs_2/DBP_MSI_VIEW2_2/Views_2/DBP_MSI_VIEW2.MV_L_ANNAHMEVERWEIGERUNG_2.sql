CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_ANNAHMEVERWEIGERUNG_2
(
mandant_id
, annahmeverweigerung_id
)
AS
   SELECT
  mandant_id, annahmeverweigerung_id

   FROM dbp_view.v_l_annahmeverweigerung_2
   WHERE mandant_id = 1;