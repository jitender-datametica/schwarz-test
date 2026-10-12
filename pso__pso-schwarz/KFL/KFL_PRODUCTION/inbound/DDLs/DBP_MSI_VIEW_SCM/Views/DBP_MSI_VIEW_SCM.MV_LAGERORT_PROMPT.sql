CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_LAGERORT_PROMPT(
	LAGERORT_UID,
	LAGERORT_BEZ,
	LAGERORT_BEZ_DE,
	LAGERORT_BEZ_CZ,
	LAGERORT_BEZ_SK,
	LAGERORT_BEZ_HR,
	LAGERORT_BEZ_PL,
	LAGERORT_BEZ_RO,
	LAGERORT_BEZ_BG
) AS
--2024-01-25, AP0182383, SPEC0207712, dknop, initial
SELECT 
 lagerort_uid AS lagerort_uid
,MAX(CASE WHEN spr_id=22 THEN lagerort_bez END) AS lagerort_bez
,MAX(CASE WHEN spr_id=22 THEN lagerort_bez END) AS lagerort_bez_de
,COALESCE(MAX(CASE WHEN spr_id = 124 THEN lagerort_bez END), lagerort_bez_de) AS lagerort_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN spr_id = 108 THEN lagerort_bez END), lagerort_bez_de) AS lagerort_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN spr_id =  65 THEN lagerort_bez END), lagerort_bez_de) AS lagerort_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN spr_id =  90 THEN lagerort_bez END), lagerort_bez_de) AS lagerort_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN spr_id =  95 THEN lagerort_bez END), lagerort_bez_de) AS lagerort_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN spr_id =  18 THEN lagerort_bez END), lagerort_bez_de) AS lagerort_bez_bg    -- BG

FROM(
(SELECT 1 AS lagerort_uid, 'Food' AS lagerort_bez, 22 AS spr_id ) UNION
(SELECT 2 AS lagerort_uid, 'Frische' AS lagerort_bez, 22 AS spr_id) UNION
(SELECT 3 AS lagerort_uid, 'TKK' AS lagerort_bez, 22 AS spr_id) UNION
(SELECT 4 AS lagerort_uid, 'Non Food' AS lagerort_bez, 22 AS spr_id) UNION
(SELECT 5 AS lagerort_uid, 'Obst & Gemüse'AS lagerort_bez, 22 AS spr_id) UNION
(SELECT 6 AS lagerort_uid, 'Blumen/Pflanzen' AS lagerort_bez, 22 AS spr_id) UNION
  
(SELECT 1 AS lagerort_uid, 'Food' AS lagerort_bez, 124 AS spr_id ) UNION
(SELECT 2 AS lagerort_uid, 'Fresh' AS lagerort_bez, 124 AS spr_id) UNION
(SELECT 3 AS lagerort_uid, 'Frozen Food' AS lagerort_bez, 124 AS spr_id) UNION
(SELECT 4 AS lagerort_uid, 'Non Food' AS lagerort_bez, 124 AS spr_id) UNION
(SELECT 5 AS lagerort_uid, 'Fruits & Vegetables'AS lagerort_bez, 124 AS spr_id) UNION
(SELECT 6 AS lagerort_uid, 'Flowers/Plants' AS lagerort_bez, 124 AS spr_id)UNION  
  
(SELECT 1 AS lagerort_uid, 'Food' AS lagerort_bez, 108 AS spr_id ) UNION
(SELECT 2 AS lagerort_uid, 'Fresh' AS lagerort_bez, 108 AS spr_id) UNION
(SELECT 3 AS lagerort_uid, 'Frozen Food' AS lagerort_bez, 108 AS spr_id) UNION
(SELECT 4 AS lagerort_uid, 'Non Food' AS lagerort_bez, 108 AS spr_id) UNION
(SELECT 5 AS lagerort_uid, 'Fruits & Vegetables'AS lagerort_bez, 108 AS spr_id) UNION
(SELECT 6 AS lagerort_uid, 'Flowers/Plants' AS lagerort_bez, 108 AS spr_id)UNION  
  
(SELECT 1 AS lagerort_uid, 'Food' AS lagerort_bez, 65 AS spr_id ) UNION
(SELECT 2 AS lagerort_uid, 'Fresh' AS lagerort_bez, 65 AS spr_id) UNION
(SELECT 3 AS lagerort_uid, 'Frozen Food' AS lagerort_bez, 65 AS spr_id) UNION
(SELECT 4 AS lagerort_uid, 'Non Food' AS lagerort_bez, 65 AS spr_id) UNION
(SELECT 5 AS lagerort_uid, 'Fruits & Vegetables'AS lagerort_bez, 65 AS spr_id) UNION
(SELECT 6 AS lagerort_uid, 'Flowers/Plants' AS lagerort_bez, 65 AS spr_id)UNION  

(SELECT 1 AS lagerort_uid, 'Food' AS lagerort_bez, 90 AS spr_id ) UNION
(SELECT 2 AS lagerort_uid, 'Fresh' AS lagerort_bez, 90 AS spr_id) UNION
(SELECT 3 AS lagerort_uid, 'Frozen Food' AS lagerort_bez, 90 AS spr_id) UNION
(SELECT 4 AS lagerort_uid, 'Non Food' AS lagerort_bez, 90 AS spr_id) UNION
(SELECT 5 AS lagerort_uid, 'Fruits & Vegetables'AS lagerort_bez, 90 AS spr_id) UNION
(SELECT 6 AS lagerort_uid, 'Flowers/Plants' AS lagerort_bez, 90 AS spr_id)UNION  
  
(SELECT 1 AS lagerort_uid, 'Food' AS lagerort_bez, 95 AS spr_id ) UNION
(SELECT 2 AS lagerort_uid, 'Fresh' AS lagerort_bez, 95 AS spr_id) UNION
(SELECT 3 AS lagerort_uid, 'Frozen Food' AS lagerort_bez, 95 AS spr_id) UNION
(SELECT 4 AS lagerort_uid, 'Non Food' AS lagerort_bez, 95 AS spr_id) UNION
(SELECT 5 AS lagerort_uid, 'Fruits & Vegetables'AS lagerort_bez, 95 AS spr_id) UNION
(SELECT 6 AS lagerort_uid, 'Flowers/Plants' AS lagerort_bez, 95 AS spr_id)UNION  
  
(SELECT 1 AS lagerort_uid, 'Food' AS lagerort_bez, 18 AS spr_id ) UNION
(SELECT 2 AS lagerort_uid, 'Fresh' AS lagerort_bez, 18 AS spr_id) UNION
(SELECT 3 AS lagerort_uid, 'Frozen Food' AS lagerort_bez, 18 AS spr_id) UNION
(SELECT 4 AS lagerort_uid, 'Non Food' AS lagerort_bez, 18 AS spr_id) UNION
(SELECT 5 AS lagerort_uid, 'Fruits & Vegetables'AS lagerort_bez, 18 AS spr_id) UNION
(SELECT 6 AS lagerort_uid, 'Flowers/Plants' AS lagerort_bez, 18 AS spr_id) 
)
          
GROUP BY lagerort_uid
;