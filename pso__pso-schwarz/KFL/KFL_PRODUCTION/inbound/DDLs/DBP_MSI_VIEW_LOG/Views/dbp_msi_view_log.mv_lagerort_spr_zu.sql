CREATE OR REPLACE VIEW dbp_msi_view_log.mv_lagerort_spr_zu
 -- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
-- 10.11.2021, INC3829726, dknop, change to show also lagerort_id -1 (Dummy), formatting updates
(
 mandant_id
,wup_id
,nb_id
,lagerort_id
,lagerort_bez
,lagerort_bez_de
,lagerort_bez_cz
,lagerort_bez_sk
,lagerort_bez_hr
,lagerort_bez_pl
,lagerort_bez_ro
,lagerort_bez_bg

,lagerort_bez_short
,lagerort_bez_short_cz
,lagerort_bez_short_sk
,lagerort_bez_short_hr
,lagerort_bez_short_pl
,lagerort_bez_short_ro
,lagerort_bez_short_bg

,lagerort_bez_sap
,lagerort_bez_sap_cz
,lagerort_bez_sap_sk
,lagerort_bez_sap_hr
,lagerort_bez_sap_pl
,lagerort_bez_sap_ro
,lagerort_bez_sap_bg

,lagerort_bez_altn
,lagerort_bez_altn_cz
,lagerort_bez_altn_sk
,lagerort_bez_altn_hr
,lagerort_bez_altn_pl
,lagerort_bez_altn_ro
,lagerort_bez_altn_bg
)
AS
SELECT
 v01.mandant_id
,v01.wup_id
,v01.nb_id
,v01.lagerort_id
/* VZ Nummer vorangestellt*/
/* Zuerst den ländespezifischen Alternativtext*/
/* Wenn es keine landesspezifische Bezeichnung (zuerst Alternative) gibt, wird die deutsche Bezeichnung genommen*/
,TRIM(v01.wup_id||' '||MAX(CASE WHEN v01.spr_id =  22 THEN COALESCE(v02.lagerort_bez, v01.lagerort_bez) END)) AS lagerort_bez                                  -- DE
,TRIM(MAX(CASE WHEN v01.spr_id =  22 THEN COALESCE(v02.lagerort_bez, v01.lagerort_bez) END)) AS lagerort_bez_de                                    -- standard == DE
,TRIM(v01.wup_id||' '||COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN COALESCE(v02.lagerort_bez, v01.lagerort_bez) END), lagerort_bez_de)) AS lagerort_bez_cz    -- CZ
,TRIM(v01.wup_id||' '||COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN COALESCE(v02.lagerort_bez, v01.lagerort_bez) END), lagerort_bez_de)) AS lagerort_bez_sk    -- SK
,TRIM(v01.wup_id||' '||COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN COALESCE(v02.lagerort_bez, v01.lagerort_bez) END), lagerort_bez_de)) AS lagerort_bez_hr    -- HR
,TRIM(v01.wup_id||' '||COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN COALESCE(v02.lagerort_bez, v01.lagerort_bez) END), lagerort_bez_de)) AS lagerort_bez_pl    -- PL
,TRIM(v01.wup_id||' '||COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN COALESCE(v02.lagerort_bez, v01.lagerort_bez) END), lagerort_bez_de)) AS lagerort_bez_ro    -- RO
,TRIM(v01.wup_id||' '||COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN COALESCE(v02.lagerort_bez, v01.lagerort_bez) END), lagerort_bez_de)) AS lagerort_bez_bg    -- BG
/* Zuerst den ländespezifischen Alternativtext*/
/* Wenn es keine landesspezifische Bezeichnung (zuerst Alternative) gibt, wird die deutsche Bezeichnung genommen*/
,MAX(CASE WHEN v01.spr_id =  22 THEN COALESCE(v02.lagerort_bez, v01.lagerort_bez) END) AS lagerort_bez_short                                  -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN COALESCE(v02.lagerort_bez, v01.lagerort_bez) END), lagerort_bez_de) AS lagerort_bez_short_cz    -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN COALESCE(v02.lagerort_bez, v01.lagerort_bez) END), lagerort_bez_de) AS lagerort_bez_short_sk    -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN COALESCE(v02.lagerort_bez, v01.lagerort_bez) END), lagerort_bez_de) AS lagerort_bez_short_hr    -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN COALESCE(v02.lagerort_bez, v01.lagerort_bez) END), lagerort_bez_de) AS lagerort_bez_short_pl    -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN COALESCE(v02.lagerort_bez, v01.lagerort_bez) END), lagerort_bez_de) AS lagerort_bez_short_ro    -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN COALESCE(v02.lagerort_bez, v01.lagerort_bez) END), lagerort_bez_de) AS lagerort_bez_short_bg    -- BG
/* Nur die durch das Quellsystem gelieferte Bezeichnung*/
,MAX(CASE WHEN v01.spr_id =  22 THEN v01.lagerort_bez END) AS lagerort_bez_sap       -- DE
,MAX(CASE WHEN v01.spr_id = 124 THEN v01.lagerort_bez END) AS lagerort_bez_sap_cz    -- CZ
,MAX(CASE WHEN v01.spr_id = 108 THEN v01.lagerort_bez END) AS lagerort_bez_sap_sk    -- SK
,MAX(CASE WHEN v01.spr_id =  65 THEN v01.lagerort_bez END) AS lagerort_bez_sap_hr    -- HR
,MAX(CASE WHEN v01.spr_id =  90 THEN v01.lagerort_bez END) AS lagerort_bez_sap_pl    -- PL
,MAX(CASE WHEN v01.spr_id =  95 THEN v01.lagerort_bez END) AS lagerort_bez_sap_ro    -- RO
,MAX(CASE WHEN v01.spr_id =  95 THEN v01.lagerort_bez END) AS lagerort_bez_sap_bg    -- BG
/* Nur die eingepflegte alternative Bezeichnung*/
,MAX(CASE WHEN v01.spr_id =  22 AND Length(Trim(v02.lagerort_bez)) = 0 THEN '_BLANK'ELSE v02.lagerort_bez END) AS lagerort_bez_altn      -- DE
,MAX(CASE WHEN v01.spr_id = 124 AND Length(Trim(v02.lagerort_bez)) = 0 THEN '_BLANK'ELSE v02.lagerort_bez END) AS lagerort_bez_altn_cz   -- CZ
,MAX(CASE WHEN v01.spr_id = 108 AND Length(Trim(v02.lagerort_bez)) = 0 THEN '_BLANK'ELSE v02.lagerort_bez END) AS lagerort_bez_altn_sk   -- SK
,MAX(CASE WHEN v01.spr_id =  65 AND Length(Trim(v02.lagerort_bez)) = 0 THEN '_BLANK'ELSE v02.lagerort_bez END) AS lagerort_bez_altn_hr   -- HR
,MAX(CASE WHEN v01.spr_id =  90 AND Length(Trim(v02.lagerort_bez)) = 0 THEN '_BLANK'ELSE v02.lagerort_bez END) AS lagerort_bez_altn_pl   -- PL
,MAX(CASE WHEN v01.spr_id =  95 AND Length(Trim(v02.lagerort_bez)) = 0 THEN '_BLANK'ELSE v02.lagerort_bez END) AS lagerort_bez_altn_ro   -- RO
,MAX(CASE WHEN v01.spr_id =  95 AND Length(Trim(v02.lagerort_bez)) = 0 THEN '_BLANK'ELSE v02.lagerort_bez END) AS lagerort_bez_altn_bg   -- BG

FROM dbp_view.v_lagerort_spr_zu v01

LEFT JOIN dbp_msi_view_log.ts_lagerort_altn_spr_zu v02
ON v01.mandant_id = v02.mandant_id
AND v01.wup_id = v02.wup_id
AND v01.lagerort_id = v02.lagerort_id
AND v01.spr_id = v02.spr_id
WHERE v01.lagerort_id NOT IN ('-2', '-3')
GROUP BY v01.mandant_id
      ,v01.lagerort_id
      ,v01.nb_id
      ,v01.wup_id;