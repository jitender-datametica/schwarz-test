CREATE OR REPLACE VIEW dbp_msi_view_log.mv_ewm_exception_spr_zu_prompt_2
AS
--2021-03-18 | nwag2310 | AP0080760 | initial
SELECT
v01.ewm_exception_id,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.ewm_exception_bez END) AS ewm_exception_bez                  -- standard == DE
,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.ewm_exception_bez END) AS ewm_exception_bez_de                           -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN v01.ewm_exception_bez END), ewm_exception_bez_de) AS ewm_exception_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN v01.ewm_exception_bez END), ewm_exception_bez_de) AS ewm_exception_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN v01.ewm_exception_bez END), ewm_exception_bez_de) AS ewm_exception_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN v01.ewm_exception_bez END), ewm_exception_bez_de) AS ewm_exception_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN v01.ewm_exception_bez END), ewm_exception_bez_de) AS ewm_exception_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN v01.ewm_exception_bez END), ewm_exception_bez_de) AS ewm_exception_bez_bg    -- BG

FROM dbp_view.v_ewm_exception_spr_zu_2 v01
WHERE LEFT(lagernummer_id ,1) in ( 'D','H','S','P','B','C','M','R' )
AND LENGTH(TRIM(lagernummer_id))=4
group by v01.ewm_exception_id ;