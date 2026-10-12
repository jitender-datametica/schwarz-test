CREATE OR REPLACE VIEW dbp_msi_view_scm.mv_art_auslieferungsgruppe_per_2(
	MANDANT_ID,
	ART_ID,
	AUSLIEFERUNGSGRUPPE_ID,
	DAT_VON,
	DAT_BIS
) AS
    SELECT v01.mandant_id
      ,v01.art_id
      ,v01.auslieferungsgruppe_id
      ,v01.dat_von
      ,v01.dat_bis
    FROM DBP_VIEW.v_art_auslieferungsgruppe_per_2 v01;