CREATE OR REPLACE VIEW P_LEW_BIL.V_LOCATION_TIMES_HIST_1
(
   client_id
 , loc_sid
 , dwh_valid_from
 , dwh_valid_to
 , open_time_mo_nrm
 , open_time_tu_nrm
 , open_time_we_nrm
 , open_time_th_nrm
 , open_time_fr_nrm
 , open_time_sa_nrm
 , open_time_su_nrm
 , open_time_mo_start
 , open_time_mo_end
 , open_time_tu_start
 , open_time_tu_end
 , open_time_we_start
 , open_time_we_end
 , open_time_th_start
 , open_time_th_end
 , open_time_fr_start
 , open_time_fr_end
 , open_time_sa_start
 , open_time_sa_end
 , open_time_su_start
 , open_time_su_end
 , open_time_mo
 , open_time_tu
 , open_time_we
 , open_time_th
 , open_time_fr
 , open_time_sa
 , open_time_su
 )
AS
   SELECT
   ptm.client_id,
   ptm.loc_sid,
   ptm.dwh_valid_from,
   ptm.dwh_valid_to,
   CASE WHEN ptm._open_time_mo_nrm IS NULL THEN '00000000'
              WHEN ptm._open_time_mo_nrm ='' THEN  '00000000'
              ELSE ptm._open_time_mo_nrm END AS open_time_mo_nrm,
   CASE WHEN ptm._open_time_tu_nrm IS NULL THEN '00000000'
              WHEN ptm._open_time_tu_nrm =''  THEN  '00000000'
              ELSE ptm._open_time_tu_nrm END AS open_time_tu_nrm,
   CASE WHEN ptm._open_time_we_nrm IS NULL THEN '00000000'
              WHEN ptm._open_time_we_nrm ='' THEN  '00000000'
              ELSE ptm._open_time_we_nrm END AS open_time_we_nrm,
   CASE WHEN ptm._open_time_mo_nrm IS NULL THEN '00000000'
              WHEN ptm._open_time_th_nrm ='' THEN  '00000000'
              ELSE ptm._open_time_th_nrm END AS open_time_th_nrm,
   CASE WHEN ptm._open_time_mo_nrm IS NULL THEN '00000000'
              WHEN ptm._open_time_fr_nrm = '' THEN  '00000000'
              ELSE ptm._open_time_fr_nrm END AS open_time_fr_nrm,
   CASE WHEN ptm._open_time_sa_nrm IS NULL THEN '00000000'
              WHEN ptm._open_time_sa_nrm ='' THEN  '00000000'
              ELSE ptm._open_time_sa_nrm END AS open_time_sa_nrm,
   CASE WHEN ptm._open_time_su_nrm IS NULL THEN '00000000'
              WHEN ptm._open_time_su_nrm ='' THEN '00000000'
              ELSE ptm._open_time_su_nrm END AS open_time_su_nrm,
   SUBSTR(open_time_mo_nrm, 1,2) || ':' || SUBSTR(open_time_mo_nrm, 3,2) || ':00'  AS open_time_mo_start,
   CASE WHEN LENGTH(open_time_mo_nrm) = 6 THEN SUBSTR(open_time_mo_nrm, 5,2)  || ':00:00'
               ELSE SUBSTR(open_time_mo_nrm, 5,2) || ':' || SUBSTR(open_time_mo_nrm, 7,2)  || ':00'
               END  open_time_mo_end,
   SUBSTR(open_time_tu_nrm, 1,2) || ':' || SUBSTR(open_time_tu_nrm, 3,2) || ':00' AS open_time_tu_start,
   CASE WHEN LENGTH(open_time_tu_nrm) = 6 THEN SUBSTR(open_time_tu_nrm, 5,2)  || ':00:00'
               ELSE SUBSTR(open_time_tu_nrm, 5,2) || ':' || SUBSTR(open_time_tu_nrm, 7,2)  || ':00'
               END open_time_tu_end,
   SUBSTR(open_time_we_nrm, 1,2) || ':' || SUBSTR(open_time_we_nrm, 3,2) || ':00' AS open_time_we_start,
   CASE WHEN LENGTH(open_time_we_nrm) = 6 THEN SUBSTR(open_time_we_nrm, 5,2)  || ':00:00'
               ELSE SUBSTR(open_time_we_nrm, 5,2) || ':' || SUBSTR(open_time_we_nrm, 7,2)  || ':00'
               END open_time_we_end,
   SUBSTR(open_time_th_nrm, 1,2) || ':' || SUBSTR(open_time_th_nrm, 3,2) || ':00'  AS open_time_th_start,
   CASE WHEN LENGTH(open_time_th_nrm) = 6 THEN SUBSTR(open_time_th_nrm, 5,2)  || ':00:00'
               ELSE SUBSTR(open_time_th_nrm, 5,2) || ':' || SUBSTR(open_time_th_nrm, 7,2)  || ':00'
               END open_time_th_end,
   SUBSTR(open_time_fr_nrm, 1,2) || ':' || SUBSTR(open_time_fr_nrm, 3,2) || ':00'  AS open_time_fr_start,
   CASE WHEN LENGTH(open_time_fr_nrm) = 6 THEN SUBSTR(open_time_fr_nrm, 5,2)  || ':00:00'
               ELSE SUBSTR(open_time_fr_nrm, 5,2) || ':' || SUBSTR(open_time_fr_nrm, 7,2)  || ':00'
               END open_time_fr_end,
   SUBSTR(open_time_sa_nrm, 1,2) || ':' || SUBSTR(open_time_sa_nrm, 3,2) || ':00'  AS open_time_sa_start,
   CASE WHEN LENGTH(open_time_sa_nrm) = 6 THEN SUBSTR(open_time_sa_nrm, 5,2)  || ':00:00'
               ELSE SUBSTR(open_time_sa_nrm, 5,2) || ':' || SUBSTR(open_time_sa_nrm, 7,2)  || ':00'
               END open_time_sa_end,
   SUBSTR(open_time_su_nrm, 1,2) || ':' || SUBSTR(open_time_su_nrm, 3,2) || ':00'  AS open_time_su_start,
   CASE WHEN LENGTH(open_time_su_nrm) = 6 THEN SUBSTR(open_time_su_nrm, 5,2)  || ':00:00'
               ELSE SUBSTR(open_time_su_nrm, 5,2) || ':' || SUBSTR(open_time_su_nrm, 7,2)  || ':00'
               END open_time_su_end,
   CAST(open_time_mo_start AS CHAR(8)) || '-' || CAST(open_time_mo_end AS CHAR(8)) AS open_time_mo,
   CAST(open_time_tu_start AS CHAR(8)) || '-' || CAST(open_time_tu_end AS CHAR(8)) AS open_time_tu,
   CAST(open_time_we_start AS CHAR(8)) || '-' || CAST(open_time_we_end AS CHAR(8)) AS open_time_we,
   CAST(open_time_th_start AS CHAR(8)) || '-' || CAST(open_time_th_end AS CHAR(8)) AS open_time_th,
   CAST(open_time_fr_start AS CHAR(8)) || '-' || CAST(open_time_fr_end AS CHAR(8)) AS open_time_fr,
   CAST(open_time_sa_start AS CHAR(8)) || '-' || CAST(open_time_sa_end AS CHAR(8)) AS open_time_sa,
   CAST(open_time_su_start AS CHAR(8)) || '-' || CAST(open_time_su_end AS CHAR(8)) AS open_time_su
   FROM (SELECT
   client_id,
   loc_sid,
   dwh_valid_from,
   dwh_valid_to,
   cast( REGEXP_REPLACE(
      REGEXP_REPLACE(
   Cast( mon_opening_tm as varchar(8)) ||cast( mon_closing_tm as varchar(8))||coalesce( cast(mon_break_start_tm as varchar(8)), '') ||coalesce(cast(mon_break_end_tm     as varchar(8)), '')   , '(\d+):(\d+):00', '\1:\2', 1,0,'i'),
      '\D', '',1,0,'i'  ) AS varchar(20)) AS _open_time_mo_nrm,
   cast(REGEXP_REPLACE(
      REGEXP_REPLACE(cast( tue_opening_tm as varchar(8)) ||cast( tue_closing_tm as varchar(8))||coalesce( cast(tue_break_start_tm as varchar(8)), '') ||coalesce(cast(tue_break_end_tm     as varchar(8)), ''), '(\d+):(\d+):00', '\1:\2', 1,0,'i'),
      '\D', '',1,0,'i'  ) as varchar(20)) AS _open_time_tu_nrm,
   cast( REGEXP_REPLACE(
      REGEXP_REPLACE(cast( wed_opening_tm as varchar(8)) ||cast( wed_closing_tm as varchar(8))||coalesce( cast(wed_break_start_tm as varchar(8)), '') ||coalesce(cast(wed_break_end_tm     as varchar(8)), ''), '(\d+):(\d+):00', '\1:\2', 1,0,'i'),
      '\D', '',1,0,'i'  ) as varchar(20)) AS _open_time_we_nrm,
   cast(REGEXP_REPLACE(
       REGEXP_REPLACE(cast( thu_opening_tm as varchar(8)) ||cast( thu_closing_tm as varchar(8))||coalesce( cast(thu_break_start_tm as varchar(8)), '') ||coalesce(cast(thu_break_end_tm     as varchar(8)), ''), '(\d+):(\d+):00', '\1:\2', 1,0,'i'),
       '\D', '',1,0,'i'  ) as varchar(20))AS _open_time_th_nrm,
   cast( REGEXP_REPLACE(
        REGEXP_REPLACE(cast( fri_opening_tm as varchar(8)) ||cast( fri_closing_tm as varchar(8))||coalesce( cast(fri_break_start_tm as varchar(8)), '') ||coalesce(cast(fri_break_end_tm     as varchar(8)), ''), '(\d+):(\d+):00', '\1:\2', 1,0,'i'),
        '\D', '',1,0,'i'  ) as varchar(20))AS _open_time_fr_nrm,
   cast( REGEXP_REPLACE(
        REGEXP_REPLACE(cast( sat_opening_tm as varchar(8)) ||cast( sat_closing_tm as varchar(8))||coalesce( cast(sat_break_start_tm as varchar(8)), '') ||coalesce(cast(sat_break_end_tm     as varchar(8)), ''), '(\d+):(\d+):00', '\1:\2', 1,0,'i'),
        '\D', '',1,0,'i'  ) as varchar(20))AS _open_time_sa_nrm,
   cast( REGEXP_REPLACE(
         REGEXP_REPLACE(cast( sun_opening_tm as varchar(8)) ||cast( sun_closing_tm as varchar(8))||coalesce( cast(sun_break_start_tm as varchar(8)), '') ||coalesce(cast(sun_break_end_tm     as varchar(8)), ''), '(\d+):(\d+):00', '\1:\2', 1,0,'i'),
         '\D', '',1,0,'i'  ) as varchar(20))AS _open_time_su_nrm
   FROM p_lew_core_ac.v_location_hist_1
       ) ptm
  WHERE dwh_valid_from <= dwh_valid_to
;