CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_L_CSR_PRODUKTGRUPPE_2
(
csr_produktgruppe_id
,csr_produktgruppe_bez
)
AS
   SELECT
  csr_produktgruppe_id, csr_produktgruppe_bez
   FROM dbp_view.v_l_csr_produktgruppe_2;