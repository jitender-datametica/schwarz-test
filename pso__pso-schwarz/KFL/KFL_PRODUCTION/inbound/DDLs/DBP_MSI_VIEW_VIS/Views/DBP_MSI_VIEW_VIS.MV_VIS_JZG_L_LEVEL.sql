CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_JZG_L_LEVEL(
	LEVEL_ID,
	LEVEL_BEZ,
	LEVEL_BEZ_CZ,
	LEVEL_BEZ_SK,
	LEVEL_BEZ_HR,
	LEVEL_BEZ_PL,
	LEVEL_BEZ_RO,
	LEVEL_BEZ_BG,
	LEVEL2_BEZ,
	LEVEL2_BEZ_CZ,
	LEVEL2_BEZ_SK,
	LEVEL2_BEZ_HR,
	LEVEL2_BEZ_PL,
	LEVEL2_BEZ_RO,
	LEVEL2_BEZ_BG
) AS
 
/*	JZG LOOKUP : Jahreszielgespraech Level (Bezeichnung) 
	2023-02-15 ssch0611 : Setup inkl. Translations. AP0144461
	2023-10-18 ssch0611 : Review Syntax 
	2024-01-11 ssch0611 : Release version
*/ 
 
SELECT
  $1::INTEGER AS LEVEL_ID
, $2::STRING  AS LEVEL_BEZ
, $3::STRING  AS LEVEL_BEZ_CZ
, $4::STRING  AS LEVEL_BEZ_SK
, $5::STRING  AS LEVEL_BEZ_HR
, $6::STRING  AS LEVEL_BEZ_PL
, $7::STRING  AS LEVEL_BEZ_RO
, $8::STRING  AS LEVEL_BEZ_BG
, $9::STRING  AS LEVEL2_BEZ
, $10::STRING AS LEVEL2_BEZ_CZ
, $10::STRING AS LEVEL2_BEZ_SK
, $11::STRING AS LEVEL2_BEZ_HR
, $10::STRING AS LEVEL2_BEZ_PL
, $10::STRING AS LEVEL2_BEZ_RO
, $10::STRING AS LEVEL2_BEZ_BG
FROM (
SELECT /* Gesamt/Filiale */
0
, 'Gesamt', 'Celkem', 'Celkom', 'Ukupno', 'Razem', 'Total', 'Общо'
, 'Filiale Gesamt', 'Filiálka Celkem', 'Filiálka Celkom', 'Poslovnica Ukupno', 'Market Razem', 'Magazin Total', 'Филиал Общо'

UNION ALL SELECT /* Abteilung */
  CASE WHEN abt.abt_id = 4 THEN 9999999 ELSE abt.abt_id * 1000000 END
, abts.abt_bez, abts.abt_bez_cz, abts.abt_bez_sk, abts.abt_bez_hr, abts.abt_bez_pl, abts.abt_bez_ro, abts.abt_bez_bg
, 'Abteilung '|| abts.abt_bez, 'Oddělení ' || abts.abt_bez_cz, 'Oddelenie' || abts.abt_bez_sk, 'Odjel' || abts.abt_bez_hr, 'Dział' || abts.abt_bez_pl, 'Departament' || abts.abt_bez_ro, 'Отдел' || abts.abt_bez_bg
FROM dbp_msi_view_vis.mv_abt_int abt
JOIN dbp_msi_view_vis.mv_abt_int_spr_zu abts
ON abts.abt_id = abt.abt_id 
WHERE abt.abt_id IN (4,5,6,7,8)> 0
 
UNION ALL SELECT /* HWG */
  abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000 
, hwgs.hwg_bez, hwgs.hwg_bez_cz, hwgs.hwg_bez_sk, hwgs.hwg_bez_hr, hwgs.hwg_bez_pl, hwgs.hwg_bez_ro, hwgs.hwg_bez_bg
, 'HWG' || hwgs.hwg_bez, 'HWG' || hwgs.hwg_bez_cz, 'HWG' || hwgs.hwg_bez_sk, 'HWG' || hwgs.hwg_bez_hr, 'GGT' || hwgs.hwg_bez_pl, 'HWG' || hwgs.hwg_bez_ro, 'HWG' || hwgs.hwg_bez_bg
FROM dbp_msi_view_vis.mv_hwg_int hwg
JOIN dbp_msi_view_vis.mv_hwg_int_spr_zu hwgs
ON hwgs.hwg_id = hwg.hwg_id
JOIN dbp_msi_view_vis.mv_abt_int abt
ON abt.abt_id = hwg.abt_id
WHERE abt.abt_id IN (5,6) AND hwg.hwg_id > 0
 
UNION ALL SELECT /* OWG */
  abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000  + ABS(owg.owg_id)
, owgs.owg_bez, owgs.owg_bez_cz, owgs.owg_bez_sk, owgs.owg_bez_hr, owgs.owg_bez_pl, owgs.owg_bez_ro, owgs.owg_bez_bg
, 'OWG' || owgs.owg_bez, 'OWG' || owgs.owg_bez_cz, 'OWG' || owgs.owg_bez_sk, 'OWG' || owgs.owg_bez_hr, 'NGT' || owgs.owg_bez_pl, 'OWG' || owgs.owg_bez_ro, 'OWG' || owgs.owg_bez_bg
FROM dbp_msi_view_vis.mv_owg_int owg
JOIN dbp_msi_view_vis.mv_owg_int_spr_zu owgs
ON owgs.owg_id = owg.owg_id
JOIN dbp_msi_view_vis.mv_hwg_int hwg
ON hwg.hwg_id = owg.hwg_id
JOIN dbp_msi_view_vis.mv_abt_int abt
ON abt.abt_id = hwg.abt_id
WHERE abt.abt_id IN (5) AND owg.owg_id > 0
) jzg;
