CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_WOCHE_START_MITTWOCH(
	dat,
	dat_vj,
	kjwo,
	kjwo_vj,
	akt_wo
) AS
   SELECT
   dat+2,
   dat_vj+2,
   kjwo,
   kjwo_vj,
   akt_wo
   FROM dbp_view.v_tag;