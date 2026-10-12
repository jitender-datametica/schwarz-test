CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ART_WUP_LIST_ZU_HIST
(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	BEZUGSWEG_ID,
	DAT_VON,
	DAT_BIS,
	KDIS,
	LISTUNG_ID,
	LISTUNG_MARKT
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
   SELECT
   mandant_id,
   wup_id,
   nb_id,
   art_id,
   bezugsweg_id,
   dat_von,
   dat_bis,
   kdis,
   listung_id,
   CASE WHEN listung_id = 1 THEN (CASE WHEN bezugsweg_id = 1 THEN (CASE WHEN KDIS = 0 THEN '1' ELSE '5' END)
        WHEN bezugsweg_id = 4 THEN (CASE WHEN KDIS = 0 THEN '4' ELSE '8' END)
        ELSE 'ausgelistet' END) ELSE 'ausgelistet' END AS listung_markt
   
   FROM dbp_view.v_art_wup_zu_per
   WHERE mandant_id = 1
   AND nb_id <> 99;