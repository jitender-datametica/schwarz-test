CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AKTION_ART_WUP_ZU_INT_1(
	MANDANT_ID,
	AKTION_ID,
	AKT_DAT_VON,
	AKT_DAT_BIS,
	DAT,
	KJWO_VON,
	ART_ID,
	VK_AKTION_BRUTTO,
	VK_VOR_AKTION_BRUTTO,
	WRG_ID,
	DAT_PREISAKTIVIERT,
	GRUND_SPERRUNG,
	WUP_ID,
	NB_ID,
	LISTUNG_ID,
	VK_BRUTTO,
	DAT_VON,
	DAT_BIS,
	KDIS,
	BEZUGSWEG_ID
) AS 

-- 12.08.2021 - snik1809 - Creation
-- 2022-09-30 ssch0611 : Calculation EUR with new logic [P16167]

SELECT
  akt0.mandant_id
, akt0.aktion_id
, akt0.dat_von AS akt_dat_von
, akt0.dat_bis AS akt_dat_bis
, CURRENT_DATE AS dat
, akt0.kjwo_von
, akt_art.art_id
, akt_art.vk_aktion_brutto * umrechnungskurs     AS vk_aktion_brutto
, akt_art.vk_vor_aktion_brutto * umrechnungskurs AS vk_vor_aktion_brutto
, krs.nach_wrg_id AS wrg_id
, akt_art.dat_preisaktiviert
, akt_art.grund_sperrung
, art_wup.wup_id
, akt_art.nb_id
, art_wup.listung_id
, art_wup.vk_brutto * umrechnungskurs AS vk_brutto
, art_wup.dat_von AS dat_von
, art_wup.dat_bis AS dat_bis
, art_wup.kdis
, art_wup.bezugsweg_id
FROM dbp_view.v_aktion_1  akt0

INNER JOIN dbp_view.v_aktion_art_wup_zu_1  akt_art
ON  akt_art.aktion_id = akt0.aktion_id
AND akt_art.mandant_id = akt0.mandant_id

INNER JOIN dbp_view.v_art_wup_zu_per_1  art_wup
ON  art_wup.art_id = akt_art.art_id
AND art_wup.mandant_id = akt_art.mandant_id
AND art_wup.wup_id = akt_art.wup_id
AND art_wup.wrg_id = akt_art.wrg_id
AND akt0.dat_von BETWEEN art_wup.dat_von AND art_wup.dat_bis

INNER JOIN (
    SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs
    FROM dbp_data.kurs_1 krs1
    WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31'
    AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
    UNION ALL
    SELECT krs2.von_wrg_id, krs2.von_wrg_id AS nach_wrg_id, 1.00000 AS umrechnungskurs
    FROM dbp_data.kurs_1 krs2
    WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31' 
    AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'EUR', 'SIT')
) krs
ON krs.von_wrg_id = akt_art.wrg_id    

WHERE akt_art.grund_sperrung IS NULL
AND akt0.dat_von BETWEEN (CURRENT_DATE - 366) AND (CURRENT_DATE);
