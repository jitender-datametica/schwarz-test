CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ART_WUP_STATUS_PER
(
	ART_ID,
	DAT_BIS,
	DAT_VON,
	LOESCH_ID,
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WG_VERKETT_ID,
	FREMD_LAGERORT_ID,
	DISPONENT_ID,
	SYSTEM_ID,
	PPS_PLAN_KALENDER_ID,
	DISPOSITION_RHYTHMUS_ID,
	PLANLIEFERZEIT,
	DISPOMERKMAL,
	WE_BEARBEITUNGSZEIT,
	MIN_SICHERH_BESTAND,
	ANLIEFER_KALENDER,
	MIN_RESTLAUFZEIT
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
p.art_id, 
p.dat_bis, 
p.dat_von, 
CASE WHEN p.loesch_id = '' THEN a.loesch_id ELSE p.loesch_id END, 
p.mandant_id, 
nb_id, 
wup_id, 
p.wg_verkett_id, 
p.fremd_lagerort_id, 
p.disponent_id, 
p.system_id, p.pps_plan_kalender_id, 
p.disposition_rhythmus_id, 
p.planlieferzeit, 
p.dispomerkmal, 
p.we_bearbeitungszeit, 
p.min_sicherh_bestand, 
p.anliefer_kalender, 
p.min_restlaufzeit
   
FROM dbp_view.v_art_wup_status_per p
INNER JOIN dbp_view.v_art a
ON a.art_id = p.art_id
AND a.mandant_id = p.mandant_id
WHERE p.dat_bis = DATE '9999-12-31'
AND p.mandant_id = 1
AND p.nb_id = 0;
