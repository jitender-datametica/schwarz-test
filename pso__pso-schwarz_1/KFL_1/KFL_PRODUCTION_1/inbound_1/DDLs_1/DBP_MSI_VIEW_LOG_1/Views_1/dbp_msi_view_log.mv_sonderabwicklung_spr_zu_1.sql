CREATE OR REPLACE VIEW dbp_msi_view_log.mv_sonderabwicklung_spr_zu_1
--17.02.2021, SPEC0091861, AP0073899, dknop, initiale Anlage_1
--03.12.2021, SPEC0091861, AP0073899, dknop, adding '-1'
AS
SELECT

v01.sonderabwicklung_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.sonderabwicklung_bez END) AS sonderabwicklung_bez                       -- standard == DE
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.sonderabwicklung_bez END) AS sonderabwicklung_bez_de                                  -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.sonderabwicklung_bez END),sonderabwicklung_bez_de) AS sonderabwicklung_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.sonderabwicklung_bez END),sonderabwicklung_bez_de) AS sonderabwicklung_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.sonderabwicklung_bez END),sonderabwicklung_bez_de) AS sonderabwicklung_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.sonderabwicklung_bez END),sonderabwicklung_bez_de) AS sonderabwicklung_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.sonderabwicklung_bez END),sonderabwicklung_bez_de) AS sonderabwicklung_bez_b
FROM dbp_view.v_sonderabwicklung_spr_zu_1 v01

GROUP BY v01.sonderabwicklung_id

UNION
SELECT
'-1' AS sonderabwicklung_id
,''AS sonderabwicklung_bez                       -- standard == DE
,'' AS sonderabwicklung_bez_de                                  -- DE
,'' AS sonderabwicklung_bez_sk    -- SK
,'' AS sonderabwicklung_bez_hr    -- HR
,'' AS sonderabwicklung_bez_pl    -- PL
,'' AS sonderabwicklung_bez_ro    -- RO
,'' AS sonderabwicklung_bez_b
;