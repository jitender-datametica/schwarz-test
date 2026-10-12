CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_EINKAUFSPREISSTAMM_KBSAL
(
	MANDANT_ID,
	ART_ID,
	BEZUGSWEG_ID,
	EK_KAL_BASIS,
	EK_MEP,
	LOGISTIKKOSTENZUSCHLAG
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
/* View MV_EINKAUFSPREISSTAMM_KBSAL wird referenziert durch View MV_EINKAUFSPREISSTAMM! Ist nicht im Frontend verbaut */
v01.mandant_id,
v01.art_id,
v01.bezugsweg_id,
MAX(ek_kal_basis) ek_kal_basis,
MAX(ek_mep) ek_mep,
MAX(logistikkostenzuschlag) logistikkostenzuschlag
FROM dbp_view.v_art_gp_wup_zu_per v01
/* SPEC0245154 / sschuecke 03.04.2024
bisheriger Join wird ersetzt um direkten View Join, um eventuelle Änderung der Logik in der anderen View berücksichtigen zu können
*/
JOIN dbp_msi_view2.mv_art_gp_nm_zu_aktuell v02
ON v01.art_id = v02.art_id
AND v01.gp_id = v02.AKT_GP_ID
AND v01.mandant_id = v02.mandant_id

WHERE v01.dat_bis = '9999-12-31'
AND v01.mandant_id = 1
GROUP BY 1,2,3;