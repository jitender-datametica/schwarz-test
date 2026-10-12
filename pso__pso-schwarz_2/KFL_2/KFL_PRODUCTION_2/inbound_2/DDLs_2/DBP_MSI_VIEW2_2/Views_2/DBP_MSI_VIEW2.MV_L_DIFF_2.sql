CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_DIFF_2

(
mandant_id
,diff_id
)
AS
   SELECT
   mandant_id, diff_id
   FROM dbp_view.v_l_kz_differenz_2
   WHERE mandant_id = 1;