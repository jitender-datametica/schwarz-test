create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BESCH_LIEF_2(
	DAT_LIEF_SOLL,
	KUNDE_ID,
	MANDANT_ID_KUNDE,
	LIEF_BELEG_ID,
	LIEF_PAL_TYP_ID,
	LIEF_TYP_ID,
	MANDANT_ID,
	NB_ID,
	VERKAUFSORGANISATION_ID,
	VERSANDSTELLE_ID,
	VERTR_BELEG_TYP_ID,
	WUP_ID,
	KJ,
	AUFTRAGGEBER_ID,
	ANZAHL_PACKSTUECK,
	WERBEWARE_ID,
	CD_KZ,
	WUP_ID_CD,
	LAGERNUMMER_ID,
	WG_VERKETT_FG,
	WG_VERKETT_LIEF,
	GP_ID,
	WE_STATUS_ID,
	VZ_WUP_ID,
	VZ_NB_ID,
	DAT_AKTION
) as











SELECT
v01.dat_lief_soll,

CASE WHEN TRY_CAST(kunde_id AS INTEGER) IS NULL THEN -3  ELSE v05.aktuell_wup_id END kunde_id,
CASE
WHEN v01.mandant_id_kunde IS NULL OR v01.mandant_id_kunde = 0 THEN v01.mandant_id
ELSE v01.mandant_id_kunde END AS mandant_id_kunde,
v01.lief_beleg_id,
CAST(v01.lief_pal_typ_id AS CHAR(2)) AS lief_pal_typ_id,
v01.lief_typ_id,
v01.mandant_id,
v01.nb_id,
v01.verkaufsorganisation_id,
v01.versandstelle_id,
v01.vertr_beleg_typ_id,
v01.wup_id,
v01.kj,
CASE
WHEN TRY_CAST(v01.auftraggeber_id AS INTEGER) = 0 THEN NULL
ELSE CAST(TRY_CAST(v01.auftraggeber_id AS INTEGER) AS VARCHAR (10)) END AS auftraggeber_id,
v01.anzahl_packstueck,
v01.werbeware_id,
v01.cd_kz,
v01.wup_id_cd,
v01.lagernummer_id,
v01.wg_verkett_fg,
v01.wg_verkett_lief,
v01.gp_id,
v01.we_status_id,
v02. wup_id AS vz_wup_id,

-111 AS vz_nb_id,
v01.dat_aktion
FROM dbp_view.v_besch_lief_2 v01
LEFT JOIN dbp_view.v_wup_2 v05
   ON v05.mandant_id = CASE WHEN v01.mandant_id_kunde IS NULL OR v01.mandant_id_kunde = 0 THEN v01.mandant_id ELSE v01.mandant_id_kunde END
   AND v05.wup_id = CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(kunde_id AS INTEGER) END
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

LEFT JOIN dbp_view.v_l_lagernummer_2 v02
ON v01.mandant_id = v02.mandant_id
AND v01.lagernummer_id = v02.lagernummer_id

LEFT JOIN (SELECT 
            mandant_id
           ,wup_id
           ,nb_id
           ,lagernummer_id
           ,MIN(dat) AS dat 
           FROM dbp_msi_data.ts_lagerort_ewm_dat_2 
           GROUP BY mandant_id
           ,wup_id
           ,nb_id
           ,lagernummer_id) v03
  ON v01.mandant_id = v03.mandant_id
 AND v02.wup_id = v03.wup_id
 AND v02.nb_id = v03.nb_id
 AND v01.lagernummer_id = v03.lagernummer_id

   
WHERE 
  ( v03.mandant_id IS NULL OR NOT  v01.dat_lief_soll >= v03.dat);