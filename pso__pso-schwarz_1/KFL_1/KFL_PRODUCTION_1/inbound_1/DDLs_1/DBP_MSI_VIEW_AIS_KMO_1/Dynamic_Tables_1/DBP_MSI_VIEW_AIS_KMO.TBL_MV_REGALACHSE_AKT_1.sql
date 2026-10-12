CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.TBL_MV_REGALACHSE_AKT_1
(
	AKTIV_FG,
	ART_ID,
	DISPLAY_ART_ID,
	EK_MEP,
	FACHBODEN_NR,
	FACHBODEN_POS,
	FBB_NR,
	KAPAZITAET,
	KAPAZITAET_FAKTOR,
	KAPAZITAET_MENGE_EINH_ID,
	MANDANT_ID,
	NB_ID,
	REGIONAL_KZ,
	SOLL_IST_KZ,
	VK_BRUTTO,
	MWST,
	WUP_ID,
	REGALACHSE_FLAECHE,
    UMRECHNUNGSKURS_0,
    UMRECHNUNGSKURS_1
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   SELECT
   v01.aktiv_fg,
   v01.art_id,
   v01.display_art_id,
   /*CAST(
   CASE WHEN v01.wrg_id <> v100.default_wrg AND v200.wrg_typ_id  = 0 THEN COALESCE( v01.ek_mep ,0)
  -- Landesbeleg in Euro wird in Landeswährung angezeigt
        WHEN v01.wrg_id <> v100.default_wrg AND v200.wrg_typ_id  = 1 THEN COALESCE(v01.ek_mep ,0) / v400.umrechnungskurs
   -- Landesbeleg in Landeswährung wird in Euro angezeigt
        WHEN v01.wrg_id = v100.default_wrg AND v200.wrg_typ_id  = 0  THEN COALESCE(v01.ek_mep ,0) * v400.umrechnungskurs
   -- Landesbeleg in Landeswährung wird in Landeswährung angezeigt
        WHEN v01.wrg_id = v100.default_wrg AND v200.wrg_typ_id  = 1  THEN COALESCE(v01.ek_mep ,0)
        END AS DECIMAL(18,6)) AS ek_mep,*/

   v01.ek_mep,
   v01.fachboden_nr,
   v01.fachboden_pos,
   v01.fbb_nr,
   v01.kapazitaet,
   v01.kapazitaet_faktor,
   v01.kapazitaet_menge_einh_id,
   v01.mandant_id,
   v01.nb_id,
   v01.regional_kz,
   v01.soll_ist_kz,
   /*CAST(
   CASE WHEN v01.wrg_id <> v100.default_wrg AND v200.wrg_typ_id  = 0 THEN COALESCE(v01.vk_brutto ,0)
  -- Landesbeleg in Euro wird in Landeswährung angezeigt
        WHEN v01.wrg_id <> v100.default_wrg AND v200.wrg_typ_id  = 1 THEN COALESCE(v01.vk_brutto ,0) / v400.umrechnungskurs
   -- Landesbeleg in Landeswährung wird in Euro angezeigt
        WHEN v01.wrg_id = v100.default_wrg AND v200.wrg_typ_id  = 0  THEN COALESCE(v01.vk_brutto ,0) * v400.umrechnungskurs
   -- Landesbeleg in Landeswährung wird in Landeswährung angezeigt
        WHEN v01.wrg_id = v100.default_wrg AND v200.wrg_typ_id  = 1  THEN COALESCE(v01.vk_brutto ,0)
        END AS DECIMAL(18,6)) AS vk_brutto_umrechnung,*/
   
   v01.vk_brutto,
   COALESCE(v01.mwst ,0) AS mwst,
   v01.wup_id,
   regalachse_flaeche,
   v400.umrechnungskurs AS umrechnungskurs_0,
   v500.umrechnungskurs AS umrechnungskurs_1

  FROM DBP_DATA.REGALACHSE_AKT_1 v01

   JOIN DBP_DATA.MANDANT_1 v100
   ON v01.mandant_id = v100.mandant_id

  /* JOIN dbp_view.v_kurs_1 AS v400
   ON v01.wrg_id = v400.von_wrg_id
   AND v400.dat_bis = '9999-12-31'
   AND v400.kurstyp_id = 9
   AND v400.nach_wrg_id = 'EUR'*/

   -- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs_1 v400
   ON v400.dat_bis = '9999-12-31'
   AND v01.wrg_id = v400.von_wrg_id
   AND v400.kurstyp_id = 3
   AND v400.nach_wrg_id ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN dbp_view.v_kurs_1 v500
   ON CURRENT_DATE BETWEEN v500.dat_von AND v500.dat_bis
   AND v01.wrg_id = v500.von_wrg_id
   AND v500.kurstyp_id = 3
   AND v500.nach_wrg_id ='EUR'

   WHERE v01.mandant_id <> 1;