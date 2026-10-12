CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_SOLL_KZ_FBB_WUP_ZU_1
(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	FBB_NR,
	SOLL_IST_KZ
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
   SELECT
   mandant_id, 
   wup_id_ AS wup_id, 
   nb_id_ AS nb_id, 
   fbb_nr, 
   CASE WHEN si_kz = 1 AND MAX(si_kz) OVER(PARTITION BY mandant_id, wup_id_, SUBSTRING(fbb_nr, 1, 4) ORDER BY mandant_id DESC NULLS LAST) = 3
        THEN 2 ELSE si_kz END AS soll_ist_kz
   FROM
   (
   SELECT
   r.mandant_id, 
   COALESCE(r.wup_id, lwz.wup_id) AS wup_id_, 
   COALESCE(r.nb_id, lwz.nb_id) AS nb_id_, 
   r.fbb_nr, 
   r.layoutbaustein_version, 
   MAX(layoutbaustein_version)
   OVER(PARTITION BY r.mandant_id, wup_id_, r.fbb_nr ORDER BY r.dat_von DESC NULLS LAST) AS max_wup_art_version, 
   CASE WHEN r.wup_id IS NULL THEN 1 ELSE 3 END AS si_kz 
   
   FROM dbp_view.v_regalachse_1 r
   LEFT OUTER JOIN dbp_view.v_layoutbaustein_wup_zu_per_1 lwz
   ON r.mandant_id = lwz.mandant_id
   AND r.layoutbaustein_id = lwz.layoutbaustein_id
   AND CURRENT_DATE BETWEEN lwz.dat_von AND lwz.dat_bis
   AND aktiv_fg = 1
   AND r.platzierungsstufe_id IS NOT NULL
   AND r.wup_id IS NULL
   LEFT OUTER JOIN dbp_view.v_wup_1 w
   ON r.mandant_id = w.mandant_id
   AND r.wup_id = w.wup_id
   AND r.nb_id = w.nb_id

   WHERE (lwz.mandant_id IS NOT NULL OR w.mandant_id IS NOT NULL)
   AND (r.mandant_id, r.regalachse_id) IN
   (
   SELECT
   mandant_id, regalachse_id
   FROM dbp_view.v_regalachse_art_zu_1
   )
   ) r
   WHERE layoutbaustein_version = max_wup_art_version
   AND r.mandant_id = 1;