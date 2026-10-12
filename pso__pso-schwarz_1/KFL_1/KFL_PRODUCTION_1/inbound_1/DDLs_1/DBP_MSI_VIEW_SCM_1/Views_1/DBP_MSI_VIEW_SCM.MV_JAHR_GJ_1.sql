CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_JAHR_GJ_1 as
   SELECT
     jg.gj, jg1.gj AS gj_1
     , jg.akt_gj, jg.akt_gj_komplett
     , to_date(to_char(jg.gj) || '-03-01','YYYY-MM_1-DD') AS dat_von
     , ADD_MONTHS(dat_von, 12) -1                           AS dat_bis
     , CASE 
          WHEN dat_bis > CURRENT_DATE THEN CURRENT_DATE 
          ELSE dat_bis 
       END  AS dat_bis_heute
   , 'GJ ' || TRIM(jg.gj)::VARCHAR(20) AS gj_bez      --standard (DE)
   , 'GJ ' || TRIM(jg.gj)::VARCHAR(20) AS gj_bez_de   --deutsch
   , 'GJ ' || TRIM(jg.gj)::VARCHAR(20) AS gj_bez_cz   --tschechisch
   , 'RO ' || TRIM(jg.gj)::VARCHAR(20) AS gj_bez_pl   --polnisch
   , 'GJ ' || TRIM(jg.gj)::VARCHAR(20) AS gj_bez_sk   --slowakisch
   , 'PG ' || TRIM(jg.gj)::VARCHAR(20) AS gj_bez_hr   --kroatisch
   , 'AF ' || TRIM(jg.gj)::VARCHAR(20) AS gj_bez_ro   --rumå¯©sch
   , 'PG ' || TRIM(jg.gj)::VARCHAR(20) AS gj_bez_bg   --bulgarisch
   , 'GJ ' || TRIM(jg.gj) || ' aufg.'::VARCHAR(20) AS gj_bez_aufg      --standard (DE)
   , 'GJ ' || TRIM(jg.gj) || ' aufg.'::VARCHAR(20) AS gj_bez_aufg_de   --deutsch
   , 'GJ ' || TRIM(jg.gj) || ' kum.'::VARCHAR(20) AS gj_bez_aufg_cz   --tschechisch
   , 'RO ' || TRIM(jg.gj) || ' skum.'::VARCHAR(20) AS gj_bez_aufg_pl   --polnisch
   , 'GJ ' || TRIM(jg.gj) || ' kum.'::VARCHAR(20) AS gj_bez_aufg_sk   --slowakisch
   , 'PG ' || TRIM(jg.gj) || ' kum.'::VARCHAR(20) AS gj_bez_aufg_hr   --kroatisch
   , 'AF ' || TRIM(jg.gj) || ' cum.'::VARCHAR(20) AS gj_bez_aufg_ro   --rumå¯©sch
   , 'PG ' || TRIM(jg.gj) || ' kum.'::VARCHAR(20) AS gj_bez_aufg_bg   --bulgarisch
   FROM dbp_view.v_jahr_gj_1 jg
   JOIN dbp_view.v_jahr_gj_1 jg1
   ON jg.gj = jg1.gj + 1;