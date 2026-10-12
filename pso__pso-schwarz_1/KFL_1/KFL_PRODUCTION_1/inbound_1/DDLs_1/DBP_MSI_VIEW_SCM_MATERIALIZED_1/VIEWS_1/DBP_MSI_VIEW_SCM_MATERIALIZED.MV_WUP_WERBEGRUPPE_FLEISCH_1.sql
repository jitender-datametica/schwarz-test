create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_WUP_WERBEGRUPPE_FLEISCH_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	WERBEGRUPPE_FLEISCH,
	WERBEGRUPPE_FLEISCH_BEZ,
	WERBEGRUPPE_FLEISCH_BEZ_DE,
	WERBEGRUPPE_FLEISCH_BEZ_CZ,
	WERBEGRUPPE_FLEISCH_BEZ_SK,
	WERBEGRUPPE_FLEISCH_BEZ_HR,
	WERBEGRUPPE_FLEISCH_BEZ_PL,
	WERBEGRUPPE_FLEISCH_BEZ_RO,
	WERBEGRUPPE_FLEISCH_BEZ_BG
) as
SELECT 
  v0.mandant_id
  , v0.wup_id
  , v0.nb_id
  , v0.marktmerkmal_wert AS werbegruppe_fleisch
  , Max(CASE WHEN spr_id =  22 THEN marktmerkmal_wert_bez END) AS werbegruppe_fleisch_bez            -- standard == DE
  , Max(CASE WHEN spr_id =  22 THEN marktmerkmal_wert_bez END) AS werbegruppe_fleisch_bez_de         -- DE
  , Coalesce(Max(CASE WHEN spr_id = 124 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_cz    -- CZ
  , Coalesce(Max(CASE WHEN spr_id = 108 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_sk    -- SK
  , Coalesce(Max(CASE WHEN spr_id =  65 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_hr    -- HR
  , Coalesce(Max(CASE WHEN spr_id =  90 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_pl    -- PL
  , Coalesce(Max(CASE WHEN spr_id =  95 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_ro    -- RO
  , Coalesce(Max(CASE WHEN spr_id =  18 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_bg    -- BG
 FROM 
	(
     SELECT v00.mandant_id
           ,v00.wup_id
           ,v00.nb_id
           ,v01.spr_id
           ,v00.marktmerkmal_wert
           ,v01.marktmerkmal_wert_bez
		  ,ROW_NUMBER() OVER (PARTITION BY v00.mandant_id, v00.wup_id, v01.spr_id ORDER BY dat_von ASC) AS relevant_fg 
      FROM DBP_VIEW.v_wup_marktmerkmal_zu_per_1 v00
      JOIN DBP_VIEW.v_marktmerkmal_wert_spr_zu_1 v01 
        ON v00.marktmerkmal_id = v01.marktmerkmal_id
       AND v00.marktmerkmal_wert = v01.marktmerkmal_wert
     WHERE v00.marktmerkmal_id = '0051' AND ((CURRENT_DATE BETWEEN v00.dat_von AND v00.dat_bis) OR (v00.dat_von > CURRENT_DATE AND v00.dat_bis = '9999-12-31'))
   ) v0
   
 WHERE relevant_fg=1
 GROUP BY v0.mandant_id
         ,v0.wup_id
         ,v0.nb_id
         ,v0.marktmerkmal_wert;