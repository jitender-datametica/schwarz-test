create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_BESTELLDATEN_2(
	MANDANT_ID,
	LIEF_BELEG_ID,
	LIEF_TYP_ID,
	DAT_LIEF_SOLL,
	LIEF_BELEG_POS_ID,
	WERK_ID,
	IN_ART_ID,
	IN_ART_NR,
	BASISMENGE_EINH_ID,
	VERK_MENGE_EINH_ID,
	NETTOGEW,
	DAT_MAT_BEREITSTLLG,
	DAT_PRODUKTION,
	IN_KUNDE_ID,
	VERKAUFS_BELEG_ID,
	VERKAUFS_BELEG_POS_ID,
	MENGE_AUFTRAG_VME_KUM,
	MENGE_BES_BME_KUM,
	MENGE_BES_BME_KUM_KG,
	STUECKLISTE_ID,
	STUECKLISTE_POS_ID,
	STUECKLISTE_TYP_ID,
	MENGE_BASIS,
	KOMPONENTENMENGE,
	KOMPONENTENMENGE_EINH_ID,
	STUECKLISTE_POS_TYP_ID,
	IN_ART_ID_SEK,
	IN_ART_NR_SEK,
	ART_BEZ_SEK
) as
   SELECT
   v01.mandant_id, 
   v01.lief_beleg_id, 
   v01.lief_typ_id, 
   v01.dat_lief_soll, 
   v01.lief_beleg_pos_id, 
   v01.werk_id, 
   v01.in_art_id AS in_art_id, 
   v01.in_art_nr AS in_art_nr, 
   v01.basismenge_einh_id, 
   v01.verk_menge_einh_id, 
   v01.nettogew, 
   v01.dat_mat_bereitstllg, 
   v01.dat_produktion, 
   v01.in_kunde_id AS in_kunde_id, 
   v01.verkaufs_beleg_id, 
   v01.verkaufs_beleg_pos_id, 
   v01.menge_auftrag_vme_kum, 
   v01.menge_bes_bme_kum, 
   v01.menge_bes_bme_kum_kg, 
   v07.stueckliste_id, 
   v07.stueckliste_pos_id, 
   v07.stueckliste_typ_id, 
   v07.menge_basis, 
   v07.komponentenmenge, 
   v07.komponentenmenge_einh_id, 
   v07.stueckliste_pos_typ_id, 
   v07.flw_art_id_sek AS in_art_id_sek, 
   v07.flw_art_nr_sek AS in_art_nr_sek, 
   v07.art_bez_sek

   
   FROM
   DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_F_BESTELLDATEN_2 v01

   
   LEFT OUTER JOIN
   (
   SELECT
   v05.mandant_id, v05.stueckliste_id, v05.werk_id, v05.flw_art_id AS flw_art_id_primaer, v05.menge_basis, 
   v06.stueckliste_pos_id, v06.stueckliste_typ_id, v06.komponentenmenge, v06.komponentenmenge_einh_id, 
   v06.stueckliste_pos_typ_id, v06.flw_art_id AS flw_art_id_sek, v08.flw_art_nr AS flw_art_nr_sek, v09.art_bez AS art_bez_sek

   -- MASTSTKO
   FROM
   dbp_view.v_flw_stueckliste_2 v05
   -- STPO_2
   JOIN
   dbp_view.v_flw_stueckliste_det_2 v06
   ON v05.mandant_id = v06.mandant_id
   AND v05.stueckliste_id = v06.stueckliste_id
   AND v05.stueckliste_typ_id = v06.stueckliste_typ_id
   LEFT OUTER JOIN dbp_view.v_flw_art_2 v08
   ON v06.mandant_id = v08.mandant_id
   AND v06.flw_art_id = v08.flw_art_id

   JOIN dbp_view.v_flw_art_spr_zu_2 v09
   ON v08.mandant_id = v09.mandant_id
   AND v08.flw_art_id = v09.flw_art_id

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v10
   ON v09.spr_id = v10.spr_id

   WHERE v06.stueckliste_pos_typ_id IN ('G','X')
   AND v06.komponentenmenge > 0.001
   ) v07
   

   WHERE v01.mandant_id IN (1,2);