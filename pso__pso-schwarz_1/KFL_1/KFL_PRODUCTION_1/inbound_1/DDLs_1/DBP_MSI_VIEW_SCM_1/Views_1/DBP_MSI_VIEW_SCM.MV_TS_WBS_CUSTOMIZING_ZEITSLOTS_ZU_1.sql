CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_TS_WBS_CUSTOMIZING_ZEITSLOTS_ZU_1 AS -- vorher DBP_MSI_VIEW_SCM.MV_TS_WBS_PROCESSBOARD 
WITH TAGE  AS ( 
    -- CROSS JOIN damit zu jeder Ausliefergruppe jeder Tag_1 vorhanden ist 
    SELECT DISTINCT v001.mandant_id, v001.auslieferungsgruppe_id, v000.wtag_id, v000.dat 
    FROM DBP_VIEW.V_TAG_1 v000
    CROSS JOIN DBP_VIEW.V_WBS_MANDANT_AUSLIEFERUNGSGRUPPE_TAG_ZEITSLOTS_ZU_1 v001
    WHERE v000.akt_wo BETWEEN 0 AND 6 -- aktuelle plus die nächsten sechs wochen 
) 
SELECT DISTINCT 
    v02.MANDANT_ID,
    v02.AUSLIEFERUNGSGRUPPE_ID,
    v02.wtag_id,
    NVL(COALESCE(v03.zeitslot_id,v01.zeitslot_id),0) AS zeitslot_id,   
    v02.dat,
    CASE WHEN v03.zeitslot_id IS NULL THEN 0 ELSE 1 END AS FLAG_MANUELL, -- pruefung, ob manuell etwas geaendert wurden ist oder nicht 
    CASE WHEN v04.NON_ADJUSTABLE_DAY_FG = 0 THEN 1 ELSE 0 END AS NON_ADJUSTABLE_DAY_FLAG -- pruefung ob in non adjustable day fuer den mandant_1 gepflegt wurden ist (unabhaengig welches VZ)
FROM TAGE v02 
LEFT JOIN DBP_VIEW.V_WBS_MANDANT_AUSLIEFERUNGSGRUPPE_TAG_ZEITSLOTS_ZU_1 v01 --wbs_processboard_standard_slots v01
ON v01.wtag_id = v02.wtag_id
AND v01.mandant_id = v02.mandant_id
AND v01.auslieferungsgruppe_id = v02.auslieferungsgruppe_id
---
LEFT JOIN DBP_MSI_DATA.TS_WBS_ZEITSLOTS_AENDERUNG_1 v03
ON v02.MANDANT_ID = v03.MANDANT_ID
AND v02.AUSLIEFERUNGSGRUPPE_ID = v03.AUSLIEFERUNGSGRUPPE_ID
AND v02.dat = v03.dat
-- pruefen ob etwas im non adjustable day gepflegt ist 
LEFT JOIN DBP_VIEW.v_ts_wbs_vz_tag_1 v04
ON v02.MANDANT_ID = v04.MANDANT_ID
AND v02.dat = v04.dat
;