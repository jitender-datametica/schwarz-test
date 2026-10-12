CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_GRUPPE_ZEK_ZU(
	GRUPPE_ID,
	MANDANT_ID,
	ANZ_MANDANT,
	ZEK_ID,
	ALLE_ZEK_FG
) AS
SELECT 
  v01.lbs_gruppe_id
, v01.mandant_id
/* Zählung wie vielen Ländern eine Gruppe zugeordnet ist */
, COUNT (DISTINCT v01.mandant_id) OVER (PARTITION BY v01.lbs_gruppe_id) AS anz_mandant
, v01.zek_id
, v01.alle_zek_fg

FROM dbp_security.lbs_gruppe_zek_zu v01;