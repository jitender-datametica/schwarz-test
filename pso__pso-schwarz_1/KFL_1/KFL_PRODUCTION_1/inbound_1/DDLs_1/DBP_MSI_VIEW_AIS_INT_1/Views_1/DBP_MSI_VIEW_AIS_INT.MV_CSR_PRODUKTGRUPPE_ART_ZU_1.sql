CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_CSR_PRODUKTGRUPPE_ART_ZU_1
(
mandant_id
,art_id
,csr_produktgruppe_id
)
AS
   SELECT
  mandant_id, art_id, csr_produktgruppe_id
   FROM dbp_view.v_csr_produktgruppe_art_zu_1;