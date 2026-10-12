CREATE OR REPLACE VIEW dbp_msi_view_log.mv_lagertyp_spr_zu_prompt
-- 20201.01.22, AP0063967, SPEC0090556, srom0404, initial
-- 04.02.2021, AP0053509, SPEC0071753, nwag2310, alte Lagertypen herausfiltern
-- 2023-10-12, AP0178083, nwag, filter out records with wup_id -1
(
 lagertyp_id
,lagertyp_bez
,lagertyp_bez_de
,lagertyp_bez_cz
,lagertyp_bez_sk
,lagertyp_bez_hr
,lagertyp_bez_pl
,lagertyp_bez_ro
,lagertyp_bez_bg
)
AS
SELECT
v01.lagertyp_id,
Max(CASE
WHEN v01.spr_id = 22 THEN Upper(v01.lagertyp_bez) END) AS lagertyp_bez                       -- standard == DE
,
Max(CASE
WHEN v01.spr_id = 22 THEN Upper(v01.lagertyp_bez) END) AS lagertyp_bez_de                                -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN Upper(v01.lagertyp_bez) END), lagertyp_bez_de) AS lagertyp_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN Upper(v01.lagertyp_bez) END), lagertyp_bez_de) AS lagertyp_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN Upper(v01.lagertyp_bez) END), lagertyp_bez_de) AS lagertyp_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN Upper(v01.lagertyp_bez) END), lagertyp_bez_de) AS lagertyp_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN Upper(v01.lagertyp_bez) END), lagertyp_bez_de) AS lagertyp_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN Upper(v01.lagertyp_bez) END), lagertyp_bez_de) AS lagertyp_bez_bg    -- BG

FROM dbp_view.v_lagertyp_spr_zu v01
WHERE LENGTH(TRIM(v01.lagertyp_id))=4 AND v01.wup_id > 0
GROUP BY v01.lagertyp_id;