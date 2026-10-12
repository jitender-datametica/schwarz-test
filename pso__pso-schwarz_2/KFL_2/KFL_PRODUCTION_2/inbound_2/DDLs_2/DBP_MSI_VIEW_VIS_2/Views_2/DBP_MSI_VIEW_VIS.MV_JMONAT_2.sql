CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_JMONAT_2(
JMO,
JMO_BEZ,
JMO_BEZ_DE,
JMO_BEZ_CZ,
JMO_BEZ_SK,
JMO_BEZ_HR,
JMO_BEZ_PL,
JMO_BEZ_RO,
JMO_BEZ_BG,
JMO_KBEZ,
JMO_KBEZ_DE,
JMO_KBEZ_CZ,
JMO_KBEZ_SK,
JMO_KBEZ_HR,
JMO_KBEZ_PL,
JMO_KBEZ_RO,
JMO_KBEZ_BG
) AS 
 
/*
	2025-01-24 muellerpatri : Initiale Erstellung der View
*/

SELECT 
    msz.mo_id                                                              AS jmo    
    , MAX(CASE WHEN spr_id =  22 THEN mo_bez ELSE TRIM(mo_id) END)         AS jmo_bez_de
    , jmo_bez_de                                                           AS jmo_bez       -- DE
    , COALESCE(MAX(CASE WHEN spr_id = 124 THEN mo_bez END), jmo_bez_de)    AS jmo_bez_cz    -- CZ
    , COALESCE(MAX(CASE WHEN spr_id = 108 THEN mo_bez END), jmo_bez_de)    AS jmo_bez_sk    -- SK
    , COALESCE(MAX(CASE WHEN spr_id =  65 THEN mo_bez END), jmo_bez_de)    AS jmo_bez_hr    -- HR
    , COALESCE(MAX(CASE WHEN spr_id =  90 THEN mo_bez END), jmo_bez_de)    AS jmo_bez_pl    -- PL
    , COALESCE(MAX(CASE WHEN spr_id =  95 THEN mo_bez END), jmo_bez_de)    AS jmo_bez_ro    -- RO
    , COALESCE(MAX(CASE WHEN spr_id =  18 THEN mo_bez END), jmo_bez_de)    AS jmo_bez_bg    -- BG
    , MAX(CASE WHEN spr_id =  22 THEN mo_bez03 ELSE TRIM(mo_id) END)       AS jmo_kbez_de
    , jmo_kbez_de                                                           AS jmo_kbez       -- DE
    , COALESCE(MAX(CASE WHEN spr_id = 124 THEN mo_bez03 END), jmo_kbez_de) AS jmo_kbez_cz    -- CZ
    , COALESCE(MAX(CASE WHEN spr_id = 108 THEN mo_bez03 END), jmo_kbez_de) AS jmo_kbez_sk    -- SK
    , COALESCE(MAX(CASE WHEN spr_id =  65 THEN mo_bez03 END), jmo_kbez_de) AS jmo_kbez_hr    -- HR
    , COALESCE(MAX(CASE WHEN spr_id =  90 THEN mo_bez03 END), jmo_kbez_de) AS jmo_kbez_pl    -- PL
    , COALESCE(MAX(CASE WHEN spr_id =  95 THEN mo_bez03 END), jmo_kbez_de) AS jmo_kbez_ro    -- RO
    , COALESCE(MAX(CASE WHEN spr_id =  18 THEN mo_bez03 END), jmo_kbez_de) AS jmo_kbez_bg    -- BG
FROM 
    (
    SELECT msz.mo_id, msz.spr_id, msz.mo_bez
	, CASE 
		WHEN msz.spr_id = 124 AND msz.mo_id = 6 THEN 'Cvn'
		WHEN msz.spr_id = 124 AND msz.mo_id = 7 THEN 'Cvc'
		ELSE TRIM(SUBSTRING(msz.mo_bez, 1, 3)) 
	  END AS mo_bez03
	FROM dbp_view.v_monat_spr_zu_2 msz
    ) msz
GROUP BY ALL
;