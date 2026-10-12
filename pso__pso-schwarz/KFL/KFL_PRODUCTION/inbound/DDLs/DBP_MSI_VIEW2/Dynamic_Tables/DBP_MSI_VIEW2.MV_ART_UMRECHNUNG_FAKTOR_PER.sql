CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ART_UMRECHNUNG_FAKTOR_PER
(
	MANDANT_ID,
	ALTNV_MENGE_EINH_ID,
	ART_ID,
	DAT_VON,
	BRUTTOGEW,
	UMRECH_FAKTOR,
	GEW_EINH_ID,
	DAT_BIS,
	LAENGE,
	BREITE,
	HOEHE
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
 mandant_id
,altnv_menge_einh_id
,art_id
,dat_von
,bruttogew
,umrech_faktor
,gew_einh_id
,dat_bis
,laenge
,breite
,hoehe 
-- Nur zum verstehen Anfang
--,ROW_NUMBER() OVER (PARTITION BY mandant_id,art_id ORDER BY CASE WHEN dbp_process.is_num(altnv_menge_einh_id) = 1 THEN CAST(altnv_menge_einh_id AS INTEGER) ELSE 9999999 END ASC) AS zeile
--, CASE WHEN dbp_process.is_num(altnv_menge_einh_id) = 1 THEN CAST(altnv_menge_einh_id AS INTEGER) ELSE 9999999 END  AS zeile2
-- Nur zum verstehen Ende
FROM dbp_view.v_art_umrechnung_faktor_per
WHERE mandant_id = 1
AND dat_bis = '9999-12-31' 
--AND dbp_process.is_num(altnv_menge_einh_id) = 1
AND (
    CASE WHEN TRY_TO_NUMERIC(altnv_menge_einh_id) IS NOT NULL THEN 1 ELSE 0 END) = 1 
   QUALIFY ROW_NUMBER() OVER ( PARTITION BY mandant_id, art_id  ORDER BY CASE WHEN (IFF(TRY_TO_NUMBER(altnv_menge_einh_id) IS NULL, 0, 1)) = 1 THEN CAST(altnv_menge_einh_id AS INTEGER) ELSE 9999999 END ASC) = 1
UNION
SELECT
mandant_id
,altnv_menge_einh_id
,art_id
,dat_von
,bruttogew
,umrech_faktor
,gew_einh_id
,dat_bis
,laenge
,breite
,hoehe
FROM dbp_view.v_art_umrechnung_faktor_per
WHERE mandant_id = 1
AND dat_bis = '9999-12-31'
AND TRIM(altnv_menge_einh_id) = 'ST';
