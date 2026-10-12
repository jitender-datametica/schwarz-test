CREATE OR REPLACE VIEW P_LEW_TOOLS.V_MAT0_SUPPLIER_CONEG_COUNTRY_HIST_1
AS
   SELECT maintab.client_id,
   maintab.sup_sid,
   maintab.country_sid_conegot,
   maintab.country_cd_conegot,
   maintab.deleted_fg,
   CASE WHEN maintab.deleted_fg = 1 or maintab.country_sid_conegot = 0 THEN ''
        ELSE TRIM(CAST(maintab.country_sid_conegot AS VARCHAR(4)))
   END country_sid_conegot_vc,
   CASE WHEN maintab.deleted_fg = 1 or maintab.country_sid_conegot = 0 THEN ''
        ELSE TRIM(CAST(maintab.country_cd_conegot AS VARCHAR(4)))
   END country_cd_conegot_vc,
   CASE WHEN maintab.deleted_fg = 1 or maintab.country_sid_conegot = 0 THEN 0
        ELSE 1
   END real_country_fg,
   maintab.dwh_valid_from,
   maintab.dwh_valid_to,
   intvls.dwh_valid_from-1 schnitt_peri_start,
   intvls.dwh_valid_to schnitt_peri_end,
   to_char(schnitt_peri_start,'YYYY-MM_1-DD') || ',' || to_char(schnitt_peri_end,'YYYY-MM_1-DD') AS peri,
   (maintab.dwh_valid_from /*Warning, Format 'yyyymmdd' removed.*/::varchar(8)) || maintab.country_cd_conegot order_crit,
   row_number() over (partition by  maintab.client_id,
                  maintab.sup_sid,
                  schnitt_peri_start,
                  schnitt_peri_end
            order by real_country_fg DESC NULLS LAST,
                   maintab.country_sid_conegot asc nulls last) relevant_unq_row,
   CASE WHEN
       SUM(real_country_fg) over (partition by  maintab.client_id,
                            maintab.sup_sid,
                          schnitt_peri_start,
                          schnitt_peri_end)
        >1
       THEN 'MULTIPLE'
    WHEN relevant_unq_row=1
    THEN 'UNIQUE'
    ELSE 'NOT RELEVANT'
   end map_type
FROM p_lew_core_ac.v_supplier_coneg_country_hist_1 maintab
   INNER JOIN (-- Projiziere supplier_1-Country_1-Kombinationshistorie auf die reine supplier_1-Historie 
   -- (Supersets aller Schnitte der Kombis eine_1 Suppliers werden auf jede Kombi übertragen)
   SELECT client_id,
   sup_sid,
   dwh_valid_from,
   COALESCE(MIN(dwh_valid_from) OVER (PARTITION BY client_id, sup_sid ORDER BY dwh_valid_from
                                         ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)-1, TO_DATE('30.12.9999', 'DD.MM.YYYY') ) dwh_valid_to
   FROM (SELECT DISTINCT client_id,
   sup_sid,
   dwh_valid_from
                       FROM p_lew_core_ac.v_supplier_coneg_country_hist_1
                       UNION
                       SELECT DISTINCT client_id,
   sup_sid,
   dwh_valid_to+1
                       FROM p_lew_core_ac.v_supplier_coneg_country_hist_1
                      ) a
                 WHERE dwh_valid_from<> TO_DATE('99991231', 'yyyymmdd')
   ) intvls
   ON maintab.client_id = intvls.client_id
   AND maintab.sup_sid = intvls.sup_sid
   AND maintab.dwh_valid_from <= intvls.dwh_valid_to
   AND maintab.dwh_valid_to >= intvls.dwh_valid_from;