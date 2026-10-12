CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_WOCHE_START_SONNTAG_1(
    dat,
	dat_vj,
	kjwo,
	kjwo_vj,
	akt_wo
) AS
   SELECT
   dat+6,
   dat_vj+6,
   kjwo,
   kjwo_vj,
   akt_wo
   FROM dbp_view.v_tag_1;