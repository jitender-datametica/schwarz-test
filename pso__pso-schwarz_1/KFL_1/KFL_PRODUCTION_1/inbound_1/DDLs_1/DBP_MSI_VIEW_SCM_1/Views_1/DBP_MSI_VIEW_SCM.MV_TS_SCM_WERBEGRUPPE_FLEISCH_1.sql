CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_TS_SCM_WERBEGRUPPE_FLEISCH_1 
-- 28.04.2021, AP0084960, SPEC0104182, srom0404, separate TransactionServices Lookup für werbegruppe_fleisch
AS
SELECT v01.marktmerkmal_wert AS werbegruppe_fleisch             
      ,Max(CASE WHEN spr_id =  22 THEN marktmerkmal_wert_bez END)                                       AS werbegruppe_fleisch_bez       -- standard == DE
      ,Max(CASE WHEN spr_id =  22 THEN marktmerkmal_wert_bez END)                                       AS werbegruppe_fleisch_bez_de    -- DE
      ,Coalesce(Max(CASE WHEN spr_id = 124 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_cz    -- CZ
      ,Coalesce(Max(CASE WHEN spr_id = 108 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_sk    -- SK
      ,Coalesce(Max(CASE WHEN spr_id =  65 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_hr    -- HR
      ,Coalesce(Max(CASE WHEN spr_id =  90 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_pl    -- PL
      ,Coalesce(Max(CASE WHEN spr_id =  95 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_ro    -- RO
      ,Coalesce(Max(CASE WHEN spr_id =  18 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_bg    -- BG
 FROM  DBP_VIEW.v_marktmerkmal_wert_spr_zu_1 v01  
  WHERE v01.marktmerkmal_id='0051'  
 GROUP BY  v01.marktmerkmal_wert
 
UNION 

SELECT v02.werbegruppe_fleisch
	  ,v02.marktmerkmal_wert_bez
	  ,v02.werbegruppe_fleisch_bez_de
	  ,v02.werbegruppe_fleisch_bez_cz
	  ,v02.werbegruppe_fleisch_bez_sk
	  ,v02.werbegruppe_fleisch_bez_hr
	  ,v02.werbegruppe_fleisch_bez_pl
	  ,v02.werbegruppe_fleisch_bez_ro
	  ,v02.werbegruppe_fleisch_bez_bg	
	  
	  FROM (SELECT '-1' AS werbegruppe_fleisch
	              ,'All (DIF)' AS marktmerkmal_wert_bez
	              ,'All (DIF)' AS werbegruppe_fleisch_bez_de
	              ,'All (DIF)' AS werbegruppe_fleisch_bez_cz
	              ,'All (DIF)' AS werbegruppe_fleisch_bez_sk
	              ,'All (DIF)' AS werbegruppe_fleisch_bez_hr
	              ,'All (DIF)' AS werbegruppe_fleisch_bez_pl
	              ,'All (DIF)' AS werbegruppe_fleisch_bez_ro
	              ,'All (DIF)' AS werbegruppe_fleisch_bez_bg
            ) v02
;
