CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_MANDANT_EMPFAENGER_SPR_ZU_1
(
mandant_id_empfaenger,
mandant_bez_empfaenger,
mandant_kbez_empfaenger,
mandant_sort_id_empfaenger
)
AS
   SELECT
  mandant_id,
   mandant_bez,
   mandant_kbez,
   mandant_sort_id
   FROM dbp_view.v_mandant_1;