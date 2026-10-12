CREATE OR REPLACE VIEW dbp_msi_view_scm.mv_wg_spr_zu_1
--AP0025638- removed mandant_1, added distinct
-- 2020-09-03, AP0068964, nwag2310, wg_id-3 --> -1
AS
SELECT DISTINCT
v01.arthiertyp_id
,case when v01.wg_id = -3 then -1 else v01.wg_id end as wg_id
,MAX(CASE when v01.wg_id = -3 then 'Alle (DIF)' WHEN spr_id =  22 THEN wg_bez END) AS wg_bez                -- standard == DE
,MAX(CASE when v01.wg_id = -3 then 'Alle (DIF)' WHEN spr_id =  22 THEN wg_bez END) AS wg_bez_de                         -- DE
,COALESCE(MAX(CASE WHEN spr_id = 124 THEN wg_bez END), wg_bez_de) AS wg_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN spr_id = 108 THEN wg_bez END), wg_bez_de) AS wg_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN spr_id =  65 THEN wg_bez END), wg_bez_de) AS wg_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN spr_id =  90 THEN wg_bez END), wg_bez_de) AS wg_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN spr_id =  95 THEN wg_bez END), wg_bez_de) AS wg_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN spr_id =  18 THEN wg_bez END), wg_bez_de) AS wg_bez_bg    -- BG
FROM dbp_view.v_wg_spr_zu_1 v01
WHERE  v01.arthiertyp_id = 2
AND v01.wg_id >= -3
--17.07.10: Filterung der Korrektur- WG aus VIS/MIS
GROUP BY
 v01.arthiertyp_id
, v01.wg_id;