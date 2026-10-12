 CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.mv_wup_werbegruppe_fleisch 
 -- 2020-12-10 | nwag2310 | intial creation
 -- 2020-07-20 | nwag2310 | filter on valid = today, not valid = infinity!, eg. 4560 closes sept 25th...
 -- 2020-08-02 | nwag2310 | filter on valid = today, OR valid > today until infinity to cover new openings (5113)
AS
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
      FROM DBP_VIEW.v_wup_marktmerkmal_zu_per v00
      JOIN DBP_VIEW.v_marktmerkmal_wert_spr_zu v01 
        ON v00.marktmerkmal_id = v01.marktmerkmal_id
       AND v00.marktmerkmal_wert = v01.marktmerkmal_wert
     WHERE v00.marktmerkmal_id = '0051' AND ((CURRENT_DATE BETWEEN v00.dat_von AND v00.dat_bis) OR (v00.dat_von > CURRENT_DATE AND v00.dat_bis = '9999-12-31'))
   ) v0
   
 WHERE relevant_fg=1
 GROUP BY v0.mandant_id
         ,v0.wup_id
         ,v0.nb_id
         ,v0.marktmerkmal_wert
 ;
