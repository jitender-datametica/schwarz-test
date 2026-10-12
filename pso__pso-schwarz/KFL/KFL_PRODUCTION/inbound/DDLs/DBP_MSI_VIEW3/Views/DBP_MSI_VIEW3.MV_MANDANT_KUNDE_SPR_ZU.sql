CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_MANDANT_KUNDE_SPR_ZU
(mandant_id_kunde,
mandant_bez_kunde,
mandant_kbez_kunde,
mandant_sort_id_kunde
)
AS
   SELECT
  mandant_id,
   mandant_bez,
   mandant_kbez,
   mandant_sort_id
   FROM dbp_view.v_mandant;