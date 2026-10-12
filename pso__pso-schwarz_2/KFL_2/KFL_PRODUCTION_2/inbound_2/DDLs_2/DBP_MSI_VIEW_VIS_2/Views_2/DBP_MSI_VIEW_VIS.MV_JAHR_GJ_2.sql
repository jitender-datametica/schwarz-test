CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_jahr_gj_2
AS
   -- ZEIT_2/HIERARCHIE : Geschaeftsjahr
   -- 2011.09 AL : spalten dat_von (Erster Tag_2 des Jahres) und dat_bis (Letzter Tag_2 des Jahres) ergänzt
   -- 2012.10 AL : dat_bis_heute hinzugefügt
   -- 2018.1025 ssch0611 : Bezeichnungen ergaenzt
   -- 2020.0121 ssch0611 : Join gj_1 removed. akt_gj_mo (Flags) + gj_kbez_aufg (Text) added
   -- 2020.0303 ssch0611 : akt_gj_mo (Flags) adjusted
   -- 2020-09-16 ssch0611 : added bez_akt columns
   SELECT
   jgj.gj                                            AS gj,
   jgj.gj - 1                                        AS gj_1,
   jgj.akt_gj                                        AS akt_gj             -- GJ Wechsel Tag_2 (02.03.)     
   ,
   jgj.akt_gj_komplett                               AS akt_gj_komplett    -- GJ Wechsel (01.03.)
   ,
   akt_gj + CASE WHEN Extract(MONTH From CURRENT_DATE - 1) = 3 THEN 1 ELSE 0 END AS akt_gj_mo          -- GJ Wechsel Monat_2 (02.04.)
   ,
   akt_gj_komplett + CASE WHEN Extract(MONTH From CURRENT_DATE - 1) = 3 THEN 1 ELSE 0 END AS akt_gj_mo_komplett -- GJ Wechsel (01.04.)
   ,
   --Cast(((jgj.gj - 1900) * 10000 + 300 + 1) AS DATE) AS dat_von,
   to_date(to_char(jgj.gj) || '-03-01','YYYY-MM_2-DD') AS dat_von,
   
   
   Add_Months(dat_von, 12) - 1                       AS dat_bis,
   
   CASE WHEN dat_bis > CURRENT_DATE - 1 THEN CURRENT_DATE - 1 ELSE dat_bis END   AS dat_bis_heute,
   CURRENT_DATE - 1                                                AS H0    -- Helper akt Tag_2 (heute)
   ,
   CASE WHEN Extract(MONTH From H0) = 3 THEN 1 ELSE 0 END  AS MO_FG -- Helper Maerz
   ,
   'GJ ' || Trim(jgj.gj)::VARCHAR(20) AS gj_bez      --standard (DE)
   ,
   'GJ ' || Trim(jgj.gj)::VARCHAR(20) AS gj_bez_de   --deutsch
   ,
   'GJ ' || Trim(jgj.gj)::VARCHAR(20) AS gj_bez_cz   --tschechisch
   ,
   'GJ ' || Trim(jgj.gj)::VARCHAR(20) AS gj_bez_sk   --slowakisch
   ,
   'PG ' || Trim(jgj.gj)::VARCHAR(20) AS gj_bez_hr   --kroatisch
   ,
   'RO ' || Trim(jgj.gj)::VARCHAR(20) AS gj_bez_pl   --polnisch
   ,
   'AF ' || Trim(jgj.gj)::VARCHAR(20) AS gj_bez_ro   --rumänisch
   ,
   'ФГ ' || Trim(jgj.gj)::VARCHAR(20) AS gj_bez_bg   --bulgarisch 
   ,
   'GJ ' || Trim(jgj.gj) || ' aufg.'::VARCHAR(20) AS gj_bez_aufg      --standard (DE)
   ,
   'GJ ' || Trim(jgj.gj) || ' aufg.'::VARCHAR(20) AS gj_bez_aufg_de   --deutsch
   ,
   'GJ ' || Trim(jgj.gj) || ' kum.'::VARCHAR(20) AS gj_bez_aufg_cz   --tschechisch
   ,
   'GJ ' || Trim(jgj.gj) || ' kum.'::VARCHAR(20) AS gj_bez_aufg_sk   --slowakisch
   ,
   'PG ' || Trim(jgj.gj) || ' kum.'::VARCHAR(20) AS gj_bez_aufg_hr   --kroatisch
   ,
   'RO ' || Trim(jgj.gj) || ' skum.'::VARCHAR(20) AS gj_bez_aufg_pl   --polnisch
   ,
   'AF ' || Trim(jgj.gj) || ' cum.'::VARCHAR(20) AS gj_bez_aufg_ro   --rumänisch
   ,
   'ФГ ' || Trim(jgj.gj) || ' кум.'::VARCHAR(20) AS gj_bez_aufg_bg   --bulgarisch 
   ,
   'GJ aufg.'::VARCHAR(20) AS gj_kbez_aufg      --standard (DE)
   ,
   'GJ aufg.'::VARCHAR(20) AS gj_kbez_aufg_de   --deutsch
   ,
   'GJ kum.'::VARCHAR(20) AS gj_kbez_aufg_cz   --tschechisch
   ,
   'GJ kum.'::VARCHAR(20) AS gj_kbez_aufg_sk   --slowakisch
   ,
   'PG kum.'::VARCHAR(20) AS gj_kbez_aufg_hr   --kroatisch
   ,
   'RO skum.'::VARCHAR(20) AS gj_kbez_aufg_pl   --polnisch
   ,
   'AF cum.'::VARCHAR(20) AS gj_kbez_aufg_ro   --rumänisch
   ,
   'ФГ кум.'::VARCHAR(20) AS gj_kbez_aufg_bg   --bulgarisch 
   ,
   'GJ ' || Trim(jgj.gj) || ' akt.'::VARCHAR(20) AS gj_bez_akt      --standard (DE)
   ,
   'GJ ' || Trim(jgj.gj) || ' akt.'::VARCHAR(20) AS gj_bez_akt_de   --deutsch
   ,
   'GJ ' || Trim(jgj.gj) || ' akt.'::VARCHAR(20) AS gj_bez_akt_cz   --tschechisch
   ,
   'GJ ' || Trim(jgj.gj) || ' akt.'::VARCHAR(20) AS gj_bez_akt_sk   --slowakisch
   ,
   'PG ' || Trim(jgj.gj) || ' akt.'::VARCHAR(20) AS gj_bez_akt_hr   --kroatisch
   ,
   'RO ' || Trim(jgj.gj) || ' akt.'::VARCHAR(20) AS gj_bez_akt_pl   --polnisch
   ,
   'AF ' || Trim(jgj.gj) || ' act.'::VARCHAR(20) AS gj_bez_akt_ro   --rumänisch
   ,
   'ФГ ' || Trim(jgj.gj) || ' акт.'::VARCHAR(20) AS gj_bez_akt_bg   --bulgarisch 
   ,
   'GJ akt.'::VARCHAR(20)  AS gj_kbez_akt      --standard (DE)
   ,
   'GJ akt.'::VARCHAR(20)  AS gj_kbez_akt_de   --deutsch
   ,
   'GJ akt.'::VARCHAR(20)  AS gj_kbez_akt_cz   --tschechisch
   ,
   'GJ akt.'::VARCHAR(20)  AS gj_kbez_akt_sk   --slowakisch
   ,
   'PG akt.'::VARCHAR(20)  AS gj_kbez_akt_hr   --kroatisch
   ,
   'RO akt.'::VARCHAR(20)  AS gj_kbez_akt_pl   --polnisch
   ,
   'AF act.'::VARCHAR(20)  AS gj_kbez_akt_ro   --rumänisch
   ,
   'ФГ акт.'::VARCHAR(20)  AS gj_kbez_akt_bg   --bulgarisch 

   FROM dbp_view.v_jahr_gj_2  jgj;