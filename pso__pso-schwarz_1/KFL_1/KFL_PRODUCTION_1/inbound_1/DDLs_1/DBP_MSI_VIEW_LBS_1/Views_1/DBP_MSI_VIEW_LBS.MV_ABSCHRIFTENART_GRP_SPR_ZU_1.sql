CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_ABSCHRIFTENART_GRP_SPR_ZU_1(
	ABSCHRIFTART_GRUPPE_ID,
	ABSCHRIFTART_BEZ,
	ABSCHRIFTART_BEZ_DE,
	ABSCHRIFTART_BEZ_CZ,
	ABSCHRIFTART_BEZ_SK,
	ABSCHRIFTART_BEZ_HR,
	ABSCHRIFTART_BEZ_PL,
	ABSCHRIFTART_BEZ_RO,
	ABSCHRIFTART_BEZ_BG,
	BEZ,
	MANDANT_ID
) AS SELECT
 v01.abschriftart_id AS abschriftart_gruppe_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.abschriftart_bez END), 'N/A') AS abschriftart_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.abschriftart_bez END), 'N/A') AS abschriftart_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.abschriftart_bez END), abschriftart_bez_de) AS abschriftart_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.abschriftart_bez END), abschriftart_bez_de) AS abschriftart_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.abschriftart_bez END), abschriftart_bez_de) AS abschriftart_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.abschriftart_bez END), abschriftart_bez_de) AS abschriftart_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.abschriftart_bez END), abschriftart_bez_de) AS abschriftart_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.abschriftart_bez END), abschriftart_bez_de) AS abschriftart_bez_bg
,TRIM(v01.abschriftart_id) || ', ' || TRIM(v01.abschriftart_id+1) AS bez
,v01.mandant_id
FROM dbp_view.v_abschriftart_spr_zu_1 v01
WHERE --v01.abschriftart_id BETWEEN 905 AND 994
-- INC4858777 Auskommentieren Funktion MOD, da hierdurch die Storno Abschriftarten nicht angezeigt werden / sschuecke 22.06.2022
-- AND MOD( v01.abschriftart_id, 2) =1
--AND v01.mandant_id <> 1
NOT (v01.abschriftart_id = 955
AND v01.mandant_id = 2)
AND v01.abschriftart_id NOT IN (923, 924)
GROUP BY
 abschriftart_gruppe_id
,bez
,mandant_id

UNION ALL

SELECT DISTINCT
CASE 
WHEN lager_bewart_id IN ('Y01','Y02') THEN 210
WHEN lager_bewart_id IN ('Y07','Y08') THEN 211
WHEN lager_bewart_id IN ('Y11','Y12') THEN 240
WHEN lager_bewart_id IN ('Y05','Y06') THEN 241
WHEN lager_bewart_id IN ('Y35','Y36') THEN 242
END
,CASE WHEN lager_bewart_id IN ('Y01','Y02') THEN 'Y01, Y02 RLZ' WHEN lager_bewart_id IN ('Y07','Y08') THEN 'Y07, Y08 RLZ Spenden' 
      WHEN lager_bewart_id IN ('Y11','Y12') THEN 'Y11, Y12 Bewirtung Zentrale' WHEN lager_bewart_id IN ('Y05','Y06') THEN 'Y05, Y06 Entnahme Zentrale QS/EK/Externe'
      WHEN lager_bewart_id IN ('Y35','Y36') THEN 'Y35, Y36 Gewinne/Kundenwerbegeschenke/Sponsoring'
END AS abschriftart_bez
,CASE WHEN lager_bewart_id IN ('Y01','Y02') THEN 'Y01, Y02 RLZ' WHEN lager_bewart_id IN ('Y07','Y08') THEN 'Y07, Y08 RLZ Spenden' 
      WHEN lager_bewart_id IN ('Y11','Y12') THEN 'Y11, Y12 Bewirtung Zentrale' WHEN lager_bewart_id IN ('Y05','Y06') THEN 'Y05, Y06 Entnahme Zentrale QS/EK/Externe'
      WHEN lager_bewart_id IN ('Y35','Y36') THEN 'Y35, Y36 Gewinne/Kundenwerbegeschenke/Sponsoring'
END AS abschriftart_bez_de
,CASE WHEN lager_bewart_id IN ('Y01','Y02') THEN 'Y01, Y02 RLZ' WHEN lager_bewart_id IN ('Y07','Y08') THEN 'Y07, Y08 RLZ Spenden' 
      WHEN lager_bewart_id IN ('Y11','Y12') THEN 'Y11, Y12 Bewirtung Zentrale' WHEN lager_bewart_id IN ('Y05','Y06') THEN 'Y05, Y06 Entnahme Zentrale QS/EK/Externe'
      WHEN lager_bewart_id IN ('Y35','Y36') THEN 'Y35, Y36 Gewinne/Kundenwerbegeschenke/Sponsoring'
END AS abschriftart_bez_cz
,CASE WHEN lager_bewart_id IN ('Y01','Y02') THEN 'Y01, Y02 RLZ' WHEN lager_bewart_id IN ('Y07','Y08') THEN 'Y07, Y08 RLZ Spenden' 
      WHEN lager_bewart_id IN ('Y11','Y12') THEN 'Y11, Y12 Bewirtung Zentrale' WHEN lager_bewart_id IN ('Y05','Y06') THEN 'Y05, Y06 Entnahme Zentrale QS/EK/Externe'
      WHEN lager_bewart_id IN ('Y35','Y36') THEN 'Y35, Y36 Gewinne/Kundenwerbegeschenke/Sponsoring'
END AS abschriftart_bez_sk
,CASE WHEN lager_bewart_id IN ('Y01','Y02') THEN 'Y01, Y02 RLZ' WHEN lager_bewart_id IN ('Y07','Y08') THEN 'Y07, Y08 RLZ Spenden' 
      WHEN lager_bewart_id IN ('Y11','Y12') THEN 'Y11, Y12 Bewirtung Zentrale' WHEN lager_bewart_id IN ('Y05','Y06') THEN 'Y05, Y06 Entnahme Zentrale QS/EK/Externe'
      WHEN lager_bewart_id IN ('Y35','Y36') THEN 'Y35, Y36 Gewinne/Kundenwerbegeschenke/Sponsoring'
END AS abschriftart_bez_hr
,CASE WHEN lager_bewart_id IN ('Y01','Y02') THEN 'Y01, Y02 RLZ' WHEN lager_bewart_id IN ('Y07','Y08') THEN 'Y07, Y08 RLZ Spenden' 
      WHEN lager_bewart_id IN ('Y11','Y12') THEN 'Y11, Y12 Bewirtung Zentrale' WHEN lager_bewart_id IN ('Y05','Y06') THEN 'Y05, Y06 Entnahme Zentrale QS/EK/Externe'
      WHEN lager_bewart_id IN ('Y35','Y36') THEN 'Y35, Y36 Gewinne/Kundenwerbegeschenke/Sponsoring'
END AS abschriftart_bez_pl
,CASE WHEN lager_bewart_id IN ('Y01','Y02') THEN 'Y01, Y02 RLZ' WHEN lager_bewart_id IN ('Y07','Y08') THEN 'Y07, Y08 RLZ Spenden' 
      WHEN lager_bewart_id IN ('Y11','Y12') THEN 'Y11, Y12 Bewirtung Zentrale' WHEN lager_bewart_id IN ('Y05','Y06') THEN 'Y05, Y06 Entnahme Zentrale QS/EK/Externe'
      WHEN lager_bewart_id IN ('Y35','Y36') THEN 'Y35, Y36 Gewinne/Kundenwerbegeschenke/Sponsoring'
END AS abschriftart_bez_ro
,CASE WHEN lager_bewart_id IN ('Y01','Y02') THEN 'Y01, Y02 RLZ' WHEN lager_bewart_id IN ('Y07','Y08') THEN 'Y07, Y08 RLZ Spenden' 
      WHEN lager_bewart_id IN ('Y11','Y12') THEN 'Y11, Y12 Bewirtung Zentrale' WHEN lager_bewart_id IN ('Y05','Y06') THEN 'Y05, Y06 Entnahme Zentrale QS/EK/Externe'
      WHEN lager_bewart_id IN ('Y35','Y36') THEN 'Y35, Y36 Gewinne/Kundenwerbegeschenke/Sponsoring'
END AS abschriftart_bez_bg
,CASE 
WHEN lager_bewart_id IN ('Y01','Y02') THEN '210'
WHEN lager_bewart_id IN ('Y07','Y08') THEN '211'
WHEN lager_bewart_id IN ('Y11','Y12') THEN '240'
WHEN lager_bewart_id IN ('Y05','Y06') THEN '241'
WHEN lager_bewart_id IN ('Y35','Y36') THEN '242'
END
,mandant_id
FROM dbp_view.v_l_lager_bewart_1
WHERE lager_bewart_id IN ('Y01','Y02','Y07','Y08','Y11','Y12','Y05','Y06','Y35','Y36');