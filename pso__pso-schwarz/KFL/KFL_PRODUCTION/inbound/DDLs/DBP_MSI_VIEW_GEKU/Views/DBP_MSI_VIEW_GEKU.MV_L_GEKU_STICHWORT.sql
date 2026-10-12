CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_L_GEKU_STICHWORT
(
geku_stichwort_uid
)
AS
--17.09.2013 twie: Anlage Lookup Stichwort

   SELECT
   geku_stichwort_uid
   FROM dbp_view.v_l_geku_stichwort;