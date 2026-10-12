CREATE OR REPLACE VIEW dbp_msi_view_log.mv_lagertypgruppe_prompt
-- 2020-02-22, AP0053509, SPEC0071753, dknop, initial with filter needed in prompt
-- 2022-01-11, EWM PL, nwag2310 added 4 Lagertyp Mappings (1x G, 3x A)
-- 2022-12-21, dknop, adding new lagertypgruppe and enlarging 'automatik' and 'griffzone' with new lagertyp_id
-- 2023-10-12, AP0178083, nwag, filter out records with wup_id -1
--2024-09-17, dknop, extending lagertypgruppe_id
AS
SELECT
mandant_id
,lagernummer_id
,lagertyp_id
,CASE
--automatik
WHEN lagertyp_id IN ('3EAB','3RAB','4RAT','4RAP','4EAT','4EAP', '4EHP','4RHP','4RHS', '1RAB','1RAM','1RAP','1RHP','1EHP', '5EHP','5FHP','5RHP') THEN 'A'
--griffzone
WHEN ( (lagertyp_id IN ('3GAB','4GAT','4GAP','4GHP','1GAB','1GHP', '5GHP','5GH3','5GH5') OR CONTAINS( lagertyp_id, 'G0') OR CONTAINS( lagertyp_id, 'G1') )
AND LEFT(lagertyp_id,1) <> 'R'
AND lagertyp_id NOT IN ('3G08','4G08') ) THEN 'G'
--regal
WHEN CONTAINS( lagertyp_id, 'R0') OR (CONTAINS( lagertyp_id, 'R1') AND RIGHT(lagertyp_id,2) <> 'R1') THEN 'R'
--sonstige
WHEN lagertyp_id IN ('1G43','1G45','1G55','1R43','1R53') THEN 'E' 
ELSE 'S' END AS lagertypgruppe_id
,CASE
WHEN lagertypgruppe_id = 'A' THEN 'Automatik'
WHEN lagertypgruppe_id = 'G' THEN 'Griffzone'
WHEN lagertypgruppe_id = 'R' THEN 'Regal'
WHEN lagertypgruppe_id = 'E' THEN 'Außenlager' 
WHEN lagertypgruppe_id = 'S' THEN 'Sonstige' END AS lagertypgruppe_bez_de
,lagertypgruppe_bez_de AS lagertypgruppe_bez
,CASE
WHEN lagertypgruppe_id = 'A' THEN 'Automatic'
WHEN lagertypgruppe_id = 'G' THEN 'Picking Bin'
WHEN lagertypgruppe_id = 'R' THEN 'Rack'
WHEN lagertypgruppe_id = 'E' THEN 'Außenlager' 
WHEN lagertypgruppe_id = 'S' THEN 'Others' END AS lagertypgruppe_bez_cz
,lagertypgruppe_bez_cz AS lagertypgruppe_bez_sk
,lagertypgruppe_bez_cz AS lagertypgruppe_bez_pl
,lagertypgruppe_bez_cz AS lagertypgruppe_bez_hr
,lagertypgruppe_bez_cz AS lagertypgruppe_bez_ro
,lagertypgruppe_bez_cz AS lagertypgruppe_bez_bg
FROM dbp_view.v_l_lagertyp v01
WHERE LEFT(v01.lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' ) AND v01.wup_id > 0
AND LENGTH(TRIM(v01.lagernummer_id))=4 AND lagertypgruppe_id<>'S';
