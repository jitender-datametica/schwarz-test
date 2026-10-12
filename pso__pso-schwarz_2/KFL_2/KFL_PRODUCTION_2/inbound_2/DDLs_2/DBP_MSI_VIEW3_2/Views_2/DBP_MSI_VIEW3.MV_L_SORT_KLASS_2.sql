CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_SORT_KLASS_2
(
mandant_id
, klassifizierung_id
)
AS
   SELECT
   mandant_id, klassifizierung_id
   FROM dbp_view.v_l_sort_klass_2;