CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_REGALACHSE
(
	MANDANT_ID,
	REGALACHSE_ID,
	LAYOUTBAUSTEIN_ID,
	LAYOUTBAUSTEIN_VERSION,
	DAT_VON,
	DAT_BIS_NEU,
	FBB_NR,
	PLATZIERUNGSSTUFE_ID,
	WUP_ID,
	NB_ID,
	ACHSGRUPPE_ID,
	REGALACHSE_FLAECHE,
	ACHS_NR
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
mandant_id, 
regalachse_id, 
layoutbaustein_id, 
layoutbaustein_version, 
dat_von, 
CASE WHEN SUBSTR(fbb_nr, 1, 4) >= 'P150' AND dat_bis <> '9999-12-31' THEN dat_bis +150 ELSE dat_bis END AS dat_bis_neu, 
fbb_nr, 
platzierungsstufe_id, 
wup_id, 
nb_id, 
achsgruppe_id, 
regalachse_flaeche, 
SUBSTRING(fbb_nr, LENGTH(fbb_nr) -3,  3) AS achs_nr

FROM dbp_view.v_regalachse
WHERE mandant_id = 1
AND (SUBSTRING(platzierungsstufe_id, 1, 1) IN ('X', 'Y', 'Z')
OR (SUBSTRING(platzierungsstufe_id, 1, 1) NOT IN ('X', 'Y', 'Z') AND SUBSTRING(platzierungsstufe_id, 3, 1) = 0))
AND dat_bis_neu >= CURRENT_DATE
QUALIFY ROW_NUMBER() OVER (PARTITION BY mandant_id, fbb_nr ORDER BY dat_bis_neu DESC NULLS LAST) = 1;