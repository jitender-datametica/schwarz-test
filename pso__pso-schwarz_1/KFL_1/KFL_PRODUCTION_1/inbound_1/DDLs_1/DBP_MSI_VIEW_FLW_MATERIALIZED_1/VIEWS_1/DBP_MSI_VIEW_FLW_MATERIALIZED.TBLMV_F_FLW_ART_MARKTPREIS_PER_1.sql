create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.TBLMV_F_FLW_ART_MARKTPREIS_PER_1(
	MANDANT_ID,
	IN_ART_ID,
	WERK_ID,
	FLW_VERSION_ID,
	MENGE,
	NICHT_RELEVANT_FG,
	PJWO,
	PJWO_VW,
	DEFAULT_WRG,
	WRG_ID,
	BRUTTOPREIS,
	DAT_AENDERUNG
) as
   SELECT
   v01.mandant_id, 
   v01.flw_art_id AS in_art_id, 
   v01.werk_id, 
   v01.flw_version_id, 
   v01.menge, 
   v01.nicht_relevant_fg, 
   v02.pjwo, 
   v02.pjwo_vw,
   v100.default_wrg,
   v01.wrg_id,
   v01.bruttopreis,
   v01.dat_aenderung


   FROM dbp_view.v_flw_art_marktpreis_per_1 v01

   JOIN
   (
   SELECT
   v001.dat, v001.pjwo, v001.wtag_id, v002.pjwo AS pjwo_vw
   FROM dbp_view.v_tag_1 v001

   JOIN dbp_view.v_tag_1 v002
   ON v001.dat - 7 = v002.dat
   AND v001.dat <= CURRENT_DATE + 7
   GROUP BY 1,2,3,4
   ) v02
   ON v02.dat = v01.dat_von  --Datensatz nur noch einer Woche_1 zuordnen (in der dat_von liegt), dat_bis ist nicht mehr relevant
   AND v02.wtag_id = 6 --nur Datensaetze beruecksichtigen, die ab Samstag gueltig sind

   -- Ermittlung der default Waehrung

   JOIN
   dbp_view.v_mandant_1 v100
   ON v01.mandant_id = v100.mandant_id;