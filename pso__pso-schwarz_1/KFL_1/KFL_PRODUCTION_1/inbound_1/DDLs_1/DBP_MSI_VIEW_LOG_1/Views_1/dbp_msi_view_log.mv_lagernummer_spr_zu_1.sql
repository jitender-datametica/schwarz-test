CREATE OR REPLACE VIEW dbp_msi_view_log.mv_lagernummer_spr_zu_1
AS
-- 03.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_1
-- 08.12.2020, AP0053509, SPEC0071753, nwag2310, Prüfung erste Stelle LGNUM / -99 wird nicht mehr gebraucht
-- 11.12.2020, AP0053509, SPEC0071753, nwag2310, Added lagernummer_erp_id 
-- 09.10.2024, nwag2310, exclude wup_id -1 records (nonsense)
SELECT
v01.mandant_id,
v01.wup_id,
v01.nb_id,
v01.lagernummer_id,
LEFT(v01.lagernummer_id ,3) AS lagernummer_erp_id,
MAX(CASE WHEN v01.spr_id = 22 THEN v01.lagernummer_bez END) AS lagernummer_bez,
MAX(CASE WHEN v01.spr_id = 22 THEN v01.lagernummer_bez END) AS lagernummer_bez_de,
COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.lagernummer_bez END), lagernummer_bez_de) AS lagernummer_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.lagernummer_bez END), lagernummer_bez_de) AS lagernummer_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.lagernummer_bez END), lagernummer_bez_de) AS lagernummer_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.lagernummer_bez END), lagernummer_bez_de) AS lagernummer_bez_pl    -- PL
, COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.lagernummer_bez END), lagernummer_bez_de) AS lagernummer_bez_ro    -- RO
, COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.lagernummer_bez END), lagernummer_bez_de) AS lagernummer_bez_bg    -- BG
FROM dbp_view.v_lagernummer_spr_zu_1 v01
WHERE LEFT(v01.lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' ) AND v01.wup_id > 0
AND LENGTH(TRIM(v01.lagernummer_id))=4
GROUP BY v01.mandant_id
        ,v01.wup_id
        ,v01.nb_id
        ,v01.lagernummer_id
		,LEFT(v01.lagernummer_id ,3) 
;