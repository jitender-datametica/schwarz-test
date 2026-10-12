CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_ANNAHMEVERWEIGERUNG_1
(
mandant_id
,annahmeverweigerung_id
)
AS
   SELECT
   mandant_id, annahmeverweigerung_id
   FROM dbp_view.v_l_annahmeverweigerung_1;