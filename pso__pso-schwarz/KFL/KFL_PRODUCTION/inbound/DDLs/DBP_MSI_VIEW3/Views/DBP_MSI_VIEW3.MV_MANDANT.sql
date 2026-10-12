CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_MANDANT
(mandant_id,
mandant_bez,
mandant_kbez,
mandant_sap_id,
default_wrg,
mandant_sort_id,
spaet_lief_tage
)
AS
   SELECT
  mandant_id,
   mandant_bez,
   mandant_kbez,
   mandant_sap_id,
   default_wrg,
   mandant_sort_id,
   spaet_lief_tage
   FROM dbp_view.v_mandant;