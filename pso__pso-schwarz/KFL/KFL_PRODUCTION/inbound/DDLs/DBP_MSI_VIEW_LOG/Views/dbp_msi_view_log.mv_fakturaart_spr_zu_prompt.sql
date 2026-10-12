CREATE OR REPLACE VIEW dbp_msi_view_log.mv_fakturaart_spr_zu_prompt -- 12.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
(
 fakturaart_id
,fakturaart_bez
,fakturaart_bez_de
,fakturaart_bez_cz
,fakturaart_bez_sk
,fakturaart_bez_hr
,fakturaart_bez_pl
,fakturaart_bez_ro
,fakturaart_bez_bg
--,f_soll_haben
)

AS
SELECT
v01.fakturaart_id,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.fakturaart_bez END) AS fakturaart_bez                         -- standard == DE
,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.fakturaart_bez END) AS fakturaart_bez_de                                  -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN v01.fakturaart_bez END), fakturaart_bez_de) AS fakturaart_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN v01.fakturaart_bez END), fakturaart_bez_de) AS fakturaart_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN v01.fakturaart_bez END), fakturaart_bez_de) AS fakturaart_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN v01.fakturaart_bez END), fakturaart_bez_de) AS fakturaart_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN v01.fakturaart_bez END), fakturaart_bez_de) AS fakturaart_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN v01.fakturaart_bez END), fakturaart_bez_de) AS fakturaart_bez_bg    -- BG

--,Max(CASE WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS') THEN '-' ELSE '+' END) AS f_soll_haben
FROM dbp_view.v_fakturaart_spr_zu v01
WHERE fakturaart_id IN ('G2','ZGLT','ZGWP','ZEWP','L2','ZVLT','ZMWP','S1','ZSLT','ZSMP','S2','Z5LT','Z5MP','ZSWP','ZGEP','ZF1','ZIV','ZIVS','ZLF2','ZLG2','ZLIG','ZLL2','ZLLS','ZLRE','ZLRS','ZLS2','ZLUL','ZLUS')
GROUP BY v01.fakturaart_id;
