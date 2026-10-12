create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ART_AUSLIEFERUNGSGRUPPE_PER(
	MANDANT_ID,
	ART_ID,
	AUSLIEFERUNGSGRUPPE_ID,
	DAT_VON,
	DAT_BIS
) as
    SELECT v01.mandant_id
      ,v01.art_id
      ,v01.auslieferungsgruppe_id
      ,v01.dat_von
      ,v01.dat_bis
    FROM DBP_VIEW.v_art_auslieferungsgruppe_per v01;