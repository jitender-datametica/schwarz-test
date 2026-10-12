CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_SAAF
(
  mandant_id
, bewart_id
, bewart_bez 
, bewart_bez_de
, bewart_bez_cz
, bewart_bez_sk
, bewart_bez_hr
, bewart_bez_pl
, bewart_bez_ro
, bewart_bez_bg

) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
SELECT
  v01.mandant_id
, v01.bewart_id
,COALESCE(MAX(CASE WHEN v01.spr_id =  22   THEN v01.bewart_bez END),'N/A') AS bewart_bez                       -- Standard == DE
,COALESCE(MAX(CASE WHEN v01.spr_id =  22   THEN v01.bewart_bez END),'N/A') AS bewart_bez_de                 -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124  THEN v01.bewart_bez END), bewart_bez_de) AS bewart_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108  THEN v01.bewart_bez END), bewart_bez_de) AS bewart_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65   THEN v01.bewart_bez END), bewart_bez_de) AS bewart_bez_hr     -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90   THEN v01.bewart_bez END), bewart_bez_de) AS bewart_bez_pl     -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id =  95   THEN v01.bewart_bez END), bewart_bez_de) AS bewart_bez_ro     -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id =  18   THEN v01.bewart_bez END), bewart_bez_de) AS bewart_bez_bg    -- BG

FROM dbp_view.v_bewart_spr_zu v01

WHERE bewart_id IN (1001,1002,1010)
GROUP BY 1,2;