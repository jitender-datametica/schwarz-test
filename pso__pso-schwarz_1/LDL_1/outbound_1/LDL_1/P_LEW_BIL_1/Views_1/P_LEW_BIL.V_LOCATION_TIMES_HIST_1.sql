CREATE OR REPLACE VIEW ldl_p_lew_bil.v_location_times_hist_1 (client_id, loc_sid, dwh_valid_from, dwh_valid_to,
open_time_mo_nrm, open_time_tu_nrm, open_time_we_nrm, open_time_th_nrm, open_time_fr_nrm, open_time_sa_nrm,
open_time_su_nrm, open_time_mo_start, open_time_mo_end, open_time_tu_start, open_time_tu_end, open_time_we_start,
open_time_we_end, open_time_th_start, open_time_th_end, open_time_fr_start, open_time_fr_end, open_time_sa_start,
open_time_sa_end, open_time_su_start, open_time_su_end, open_time_mo, open_time_tu, open_time_we, open_time_th,
open_time_fr, open_time_sa, open_time_su) AS SELECT client_id,
 loc_sid,
 dwh_valid_from,
 dwh_valid_to,
  CASE
  WHEN `_open_time_mo_nrm` = ''
  THEN '00000000'
  ELSE `_open_time_mo_nrm`
  END AS open_time_mo_nrm,
  CASE
  WHEN `_open_time_tu_nrm` = ''
  THEN '00000000'
  ELSE `_open_time_tu_nrm`
  END AS open_time_tu_nrm,
  CASE
  WHEN `_open_time_we_nrm` = ''
  THEN '00000000'
  ELSE `_open_time_we_nrm`
  END AS open_time_we_nrm,
  CASE
  WHEN `_open_time_th_nrm` = ''
  THEN '00000000'
  ELSE `_open_time_th_nrm`
  END AS open_time_th_nrm,
  CASE
  WHEN `_open_time_fr_nrm` = ''
  THEN '00000000'
  ELSE `_open_time_fr_nrm`
  END AS open_time_fr_nrm,
  CASE
  WHEN `_open_time_sa_nrm` = ''
  THEN '00000000'
  ELSE `_open_time_sa_nrm`
  END AS open_time_sa_nrm,
  CASE
  WHEN `_open_time_su_nrm` = ''
  THEN '00000000'
  ELSE `_open_time_su_nrm`
  END AS open_time_su_nrm,
    SUBSTR(CASE
      WHEN `_open_time_mo_nrm` = ''
      THEN '00000000'
      ELSE `_open_time_mo_nrm`
      END, 1, 2) || ':' || SUBSTR(CASE
     WHEN `_open_time_mo_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_mo_nrm`
     END, 3, 2) || ':00' AS open_time_mo_start,
  CASE
  WHEN LENGTH(CASE
     WHEN `_open_time_mo_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_mo_nrm`
     END) = 6
  THEN SUBSTR(CASE
     WHEN `_open_time_mo_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_mo_nrm`
     END, 5, 2) || ':00:00'
  ELSE SUBSTR(CASE
       WHEN `_open_time_mo_nrm` = ''
       THEN '00000000'
       ELSE `_open_time_mo_nrm`
       END, 5, 2) || ':' || SUBSTR(CASE
      WHEN `_open_time_mo_nrm` = ''
      THEN '00000000'
      ELSE `_open_time_mo_nrm`
      END, 7, 2) || ':00'
  END AS open_time_mo_end,
    SUBSTR(CASE
      WHEN `_open_time_tu_nrm` = ''
      THEN '00000000'
      ELSE `_open_time_tu_nrm`
      END, 1, 2) || ':' || SUBSTR(CASE
     WHEN `_open_time_tu_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_tu_nrm`
     END, 3, 2) || ':00' AS open_time_tu_start,
  CASE
  WHEN LENGTH(CASE
     WHEN `_open_time_tu_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_tu_nrm`
     END) = 6
  THEN SUBSTR(CASE
     WHEN `_open_time_tu_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_tu_nrm`
     END, 5, 2) || ':00:00'
  ELSE SUBSTR(CASE
       WHEN `_open_time_tu_nrm` = ''
       THEN '00000000'
       ELSE `_open_time_tu_nrm`
       END, 5, 2) || ':' || SUBSTR(CASE
      WHEN `_open_time_tu_nrm` = ''
      THEN '00000000'
      ELSE `_open_time_tu_nrm`
      END, 7, 2) || ':00'
  END AS open_time_tu_end,
    SUBSTR(CASE
      WHEN `_open_time_we_nrm` = ''
      THEN '00000000'
      ELSE `_open_time_we_nrm`
      END, 1, 2) || ':' || SUBSTR(CASE
     WHEN `_open_time_we_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_we_nrm`
     END, 3, 2) || ':00' AS open_time_we_start,
  CASE
  WHEN LENGTH(CASE
     WHEN `_open_time_we_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_we_nrm`
     END) = 6
  THEN SUBSTR(CASE
     WHEN `_open_time_we_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_we_nrm`
     END, 5, 2) || ':00:00'
  ELSE SUBSTR(CASE
       WHEN `_open_time_we_nrm` = ''
       THEN '00000000'
       ELSE `_open_time_we_nrm`
       END, 5, 2) || ':' || SUBSTR(CASE
      WHEN `_open_time_we_nrm` = ''
      THEN '00000000'
      ELSE `_open_time_we_nrm`
      END, 7, 2) || ':00'
  END AS open_time_we_end,
    SUBSTR(CASE
      WHEN `_open_time_th_nrm` = ''
      THEN '00000000'
      ELSE `_open_time_th_nrm`
      END, 1, 2) || ':' || SUBSTR(CASE
     WHEN `_open_time_th_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_th_nrm`
     END, 3, 2) || ':00' AS open_time_th_start,
  CASE
  WHEN LENGTH(CASE
     WHEN `_open_time_th_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_th_nrm`
     END) = 6
  THEN SUBSTR(CASE
     WHEN `_open_time_th_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_th_nrm`
     END, 5, 2) || ':00:00'
  ELSE SUBSTR(CASE
       WHEN `_open_time_th_nrm` = ''
       THEN '00000000'
       ELSE `_open_time_th_nrm`
       END, 5, 2) || ':' || SUBSTR(CASE
      WHEN `_open_time_th_nrm` = ''
      THEN '00000000'
      ELSE `_open_time_th_nrm`
      END, 7, 2) || ':00'
  END AS open_time_th_end,
    SUBSTR(CASE
      WHEN `_open_time_fr_nrm` = ''
      THEN '00000000'
      ELSE `_open_time_fr_nrm`
      END, 1, 2) || ':' || SUBSTR(CASE
     WHEN `_open_time_fr_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_fr_nrm`
     END, 3, 2) || ':00' AS open_time_fr_start,
  CASE
  WHEN LENGTH(CASE
     WHEN `_open_time_fr_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_fr_nrm`
     END) = 6
  THEN SUBSTR(CASE
     WHEN `_open_time_fr_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_fr_nrm`
     END, 5, 2) || ':00:00'
  ELSE SUBSTR(CASE
       WHEN `_open_time_fr_nrm` = ''
       THEN '00000000'
       ELSE `_open_time_fr_nrm`
       END, 5, 2) || ':' || SUBSTR(CASE
      WHEN `_open_time_fr_nrm` = ''
      THEN '00000000'
      ELSE `_open_time_fr_nrm`
      END, 7, 2) || ':00'
  END AS open_time_fr_end,
    SUBSTR(CASE
      WHEN `_open_time_sa_nrm` = ''
      THEN '00000000'
      ELSE `_open_time_sa_nrm`
      END, 1, 2) || ':' || SUBSTR(CASE
     WHEN `_open_time_sa_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_sa_nrm`
     END, 3, 2) || ':00' AS open_time_sa_start,
  CASE
  WHEN LENGTH(CASE
     WHEN `_open_time_sa_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_sa_nrm`
     END) = 6
  THEN SUBSTR(CASE
     WHEN `_open_time_sa_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_sa_nrm`
     END, 5, 2) || ':00:00'
  ELSE SUBSTR(CASE
       WHEN `_open_time_sa_nrm` = ''
       THEN '00000000'
       ELSE `_open_time_sa_nrm`
       END, 5, 2) || ':' || SUBSTR(CASE
      WHEN `_open_time_sa_nrm` = ''
      THEN '00000000'
      ELSE `_open_time_sa_nrm`
      END, 7, 2) || ':00'
  END AS open_time_sa_end,
    SUBSTR(CASE
      WHEN `_open_time_su_nrm` = ''
      THEN '00000000'
      ELSE `_open_time_su_nrm`
      END, 1, 2) || ':' || SUBSTR(CASE
     WHEN `_open_time_su_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_su_nrm`
     END, 3, 2) || ':00' AS open_time_su_start,
  CASE
  WHEN LENGTH(CASE
     WHEN `_open_time_su_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_su_nrm`
     END) = 6
  THEN SUBSTR(CASE
     WHEN `_open_time_su_nrm` = ''
     THEN '00000000'
     ELSE `_open_time_su_nrm`
     END, 5, 2) || ':00:00'
  ELSE SUBSTR(CASE
       WHEN `_open_time_su_nrm` = ''
       THEN '00000000'
       ELSE `_open_time_su_nrm`
       END, 5, 2) || ':' || SUBSTR(CASE
      WHEN `_open_time_su_nrm` = ''
      THEN '00000000'
      ELSE `_open_time_su_nrm`
      END, 7, 2) || ':00'
  END AS open_time_su_end,
   SUBSTR(CAST(SUBSTR(CASE
          WHEN `_open_time_mo_nrm` = ''
          THEN '00000000'
          ELSE `_open_time_mo_nrm`
          END, 1, 2) || ':' || SUBSTR(CASE
         WHEN `_open_time_mo_nrm` = ''
         THEN '00000000'
         ELSE `_open_time_mo_nrm`
         END, 3, 2) || ':00' AS STRING), 1, 8) || '-' || SUBSTR(CAST(CASE
     WHEN LENGTH(CASE
        WHEN `_open_time_mo_nrm` = ''
        THEN '00000000'
        ELSE `_open_time_mo_nrm`
        END) = 6
     THEN SUBSTR(CASE
        WHEN `_open_time_mo_nrm` = ''
        THEN '00000000'
        ELSE `_open_time_mo_nrm`
        END, 5, 2) || ':00:00'
     ELSE SUBSTR(CASE
          WHEN `_open_time_mo_nrm` = ''
          THEN '00000000'
          ELSE `_open_time_mo_nrm`
          END, 5, 2) || ':' || SUBSTR(CASE
         WHEN `_open_time_mo_nrm` = ''
         THEN '00000000'
         ELSE `_open_time_mo_nrm`
         END, 7, 2) || ':00'
     END AS STRING), 1, 8) AS open_time_mo,
   SUBSTR(CAST(SUBSTR(CASE
          WHEN `_open_time_tu_nrm` = ''
          THEN '00000000'
          ELSE `_open_time_tu_nrm`
          END, 1, 2) || ':' || SUBSTR(CASE
         WHEN `_open_time_tu_nrm` = ''
         THEN '00000000'
         ELSE `_open_time_tu_nrm`
         END, 3, 2) || ':00' AS STRING), 1, 8) || '-' || SUBSTR(CAST(CASE
     WHEN LENGTH(CASE
        WHEN `_open_time_tu_nrm` = ''
        THEN '00000000'
        ELSE `_open_time_tu_nrm`
        END) = 6
     THEN SUBSTR(CASE
        WHEN `_open_time_tu_nrm` = ''
        THEN '00000000'
        ELSE `_open_time_tu_nrm`
        END, 5, 2) || ':00:00'
     ELSE SUBSTR(CASE
          WHEN `_open_time_tu_nrm` = ''
          THEN '00000000'
          ELSE `_open_time_tu_nrm`
          END, 5, 2) || ':' || SUBSTR(CASE
         WHEN `_open_time_tu_nrm` = ''
         THEN '00000000'
         ELSE `_open_time_tu_nrm`
         END, 7, 2) || ':00'
     END AS STRING), 1, 8) AS open_time_tu,
   SUBSTR(CAST(SUBSTR(CASE
          WHEN `_open_time_we_nrm` = ''
          THEN '00000000'
          ELSE `_open_time_we_nrm`
          END, 1, 2) || ':' || SUBSTR(CASE
         WHEN `_open_time_we_nrm` = ''
         THEN '00000000'
         ELSE `_open_time_we_nrm`
         END, 3, 2) || ':00' AS STRING), 1, 8) || '-' || SUBSTR(CAST(CASE
     WHEN LENGTH(CASE
        WHEN `_open_time_we_nrm` = ''
        THEN '00000000'
        ELSE `_open_time_we_nrm`
        END) = 6
     THEN SUBSTR(CASE
        WHEN `_open_time_we_nrm` = ''
        THEN '00000000'
        ELSE `_open_time_we_nrm`
        END, 5, 2) || ':00:00'
     ELSE SUBSTR(CASE
          WHEN `_open_time_we_nrm` = ''
          THEN '00000000'
          ELSE `_open_time_we_nrm`
          END, 5, 2) || ':' || SUBSTR(CASE
         WHEN `_open_time_we_nrm` = ''
         THEN '00000000'
         ELSE `_open_time_we_nrm`
         END, 7, 2) || ':00'
     END AS STRING), 1, 8) AS open_time_we,
   SUBSTR(CAST(SUBSTR(CASE
          WHEN `_open_time_th_nrm` = ''
          THEN '00000000'
          ELSE `_open_time_th_nrm`
          END, 1, 2) || ':' || SUBSTR(CASE
         WHEN `_open_time_th_nrm` = ''
         THEN '00000000'
         ELSE `_open_time_th_nrm`
         END, 3, 2) || ':00' AS STRING), 1, 8) || '-' || SUBSTR(CAST(CASE
     WHEN LENGTH(CASE
        WHEN `_open_time_th_nrm` = ''
        THEN '00000000'
        ELSE `_open_time_th_nrm`
        END) = 6
     THEN SUBSTR(CASE
        WHEN `_open_time_th_nrm` = ''
        THEN '00000000'
        ELSE `_open_time_th_nrm`
        END, 5, 2) || ':00:00'
     ELSE SUBSTR(CASE
          WHEN `_open_time_th_nrm` = ''
          THEN '00000000'
          ELSE `_open_time_th_nrm`
          END, 5, 2) || ':' || SUBSTR(CASE
         WHEN `_open_time_th_nrm` = ''
         THEN '00000000'
         ELSE `_open_time_th_nrm`
         END, 7, 2) || ':00'
     END AS STRING), 1, 8) AS open_time_th,
   SUBSTR(CAST(SUBSTR(CASE
          WHEN `_open_time_fr_nrm` = ''
          THEN '00000000'
          ELSE `_open_time_fr_nrm`
          END, 1, 2) || ':' || SUBSTR(CASE
         WHEN `_open_time_fr_nrm` = ''
         THEN '00000000'
         ELSE `_open_time_fr_nrm`
         END, 3, 2) || ':00' AS STRING), 1, 8) || '-' || SUBSTR(CAST(CASE
     WHEN LENGTH(CASE
        WHEN `_open_time_fr_nrm` = ''
        THEN '00000000'
        ELSE `_open_time_fr_nrm`
        END) = 6
     THEN SUBSTR(CASE
        WHEN `_open_time_fr_nrm` = ''
        THEN '00000000'
        ELSE `_open_time_fr_nrm`
        END, 5, 2) || ':00:00'
     ELSE SUBSTR(CASE
          WHEN `_open_time_fr_nrm` = ''
          THEN '00000000'
          ELSE `_open_time_fr_nrm`
          END, 5, 2) || ':' || SUBSTR(CASE
         WHEN `_open_time_fr_nrm` = ''
         THEN '00000000'
         ELSE `_open_time_fr_nrm`
         END, 7, 2) || ':00'
     END AS STRING), 1, 8) AS open_time_fr,
   SUBSTR(CAST(SUBSTR(CASE
          WHEN `_open_time_sa_nrm` = ''
          THEN '00000000'
          ELSE `_open_time_sa_nrm`
          END, 1, 2) || ':' || SUBSTR(CASE
         WHEN `_open_time_sa_nrm` = ''
         THEN '00000000'
         ELSE `_open_time_sa_nrm`
         END, 3, 2) || ':00' AS STRING), 1, 8) || '-' || SUBSTR(CAST(CASE
     WHEN LENGTH(CASE
        WHEN `_open_time_sa_nrm` = ''
        THEN '00000000'
        ELSE `_open_time_sa_nrm`
        END) = 6
     THEN SUBSTR(CASE
        WHEN `_open_time_sa_nrm` = ''
        THEN '00000000'
        ELSE `_open_time_sa_nrm`
        END, 5, 2) || ':00:00'
     ELSE SUBSTR(CASE
          WHEN `_open_time_sa_nrm` = ''
          THEN '00000000'
          ELSE `_open_time_sa_nrm`
          END, 5, 2) || ':' || SUBSTR(CASE
         WHEN `_open_time_sa_nrm` = ''
         THEN '00000000'
         ELSE `_open_time_sa_nrm`
         END, 7, 2) || ':00'
     END AS STRING), 1, 8) AS open_time_sa,
   SUBSTR(CAST(SUBSTR(CASE
          WHEN `_open_time_su_nrm` = ''
          THEN '00000000'
          ELSE `_open_time_su_nrm`
          END, 1, 2) || ':' || SUBSTR(CASE
         WHEN `_open_time_su_nrm` = ''
         THEN '00000000'
         ELSE `_open_time_su_nrm`
         END, 3, 2) || ':00' AS STRING), 1, 8) || '-' || SUBSTR(CAST(CASE
     WHEN LENGTH(CASE
        WHEN `_open_time_su_nrm` = ''
        THEN '00000000'
        ELSE `_open_time_su_nrm`
        END) = 6
     THEN SUBSTR(CASE
        WHEN `_open_time_su_nrm` = ''
        THEN '00000000'
        ELSE `_open_time_su_nrm`
        END, 5, 2) || ':00:00'
     ELSE SUBSTR(CASE
          WHEN `_open_time_su_nrm` = ''
          THEN '00000000'
          ELSE `_open_time_su_nrm`
          END, 5, 2) || ':' || SUBSTR(CASE
         WHEN `_open_time_su_nrm` = ''
         THEN '00000000'
         ELSE `_open_time_su_nrm`
         END, 7, 2) || ':00'
     END AS STRING), 1, 8) AS open_time_su
FROM ( SELECT
       client_id,
       loc_sid,
       dwh_valid_from,
       dwh_valid_to,
       -- Monday
       REGEXP_REPLACE(
           REGEXP_REPLACE(
               COALESCE(CAST(mon_opening_tm AS STRING), '') ||
               COALESCE(CAST(mon_closing_tm AS STRING), '') ||
               COALESCE(CAST(mon_break_start_tm AS STRING), '') ||
               COALESCE(CAST(mon_break_end_tm AS STRING), ''),
               r'(\d+):(\d+):00', '\\1:\\2'
           ),
           r'\D', ''
       ) AS _open_time_mo_nrm,
       -- Tuesday
       REGEXP_REPLACE(
           REGEXP_REPLACE(
               COALESCE(CAST(tue_opening_tm AS STRING), '') ||
               COALESCE(CAST(tue_closing_tm AS STRING), '') ||
               COALESCE(CAST(tue_break_start_tm AS STRING), '') ||
               COALESCE(CAST(tue_break_end_tm AS STRING), ''),
               r'(\d+):(\d+):00', '\\1:\\2'
           ),
           r'\D', ''
       ) AS _open_time_tu_nrm,
       -- Wednesday
       REGEXP_REPLACE(
           REGEXP_REPLACE(
               COALESCE(CAST(wed_opening_tm AS STRING), '') ||
               COALESCE(CAST(wed_closing_tm AS STRING), '') ||
               COALESCE(CAST(wed_break_start_tm AS STRING), '') ||
               COALESCE(CAST(wed_break_end_tm AS STRING), ''),
               r'(\d+):(\d+):00', '\\1:\\2'
           ),
           r'\D', ''
       ) AS _open_time_we_nrm,
       -- Thursday
       REGEXP_REPLACE(
           REGEXP_REPLACE(
               COALESCE(CAST(thu_opening_tm AS STRING), '') ||
               COALESCE(CAST(thu_closing_tm AS STRING), '') ||
               COALESCE(CAST(thu_break_start_tm AS STRING), '') ||
               COALESCE(CAST(thu_break_end_tm AS STRING), ''),
               r'(\d+):(\d+):00', '\\1:\\2'
           ),
           r'\D', ''
       ) AS _open_time_th_nrm,
       -- Friday
       REGEXP_REPLACE(
           REGEXP_REPLACE(
               COALESCE(CAST(fri_opening_tm AS STRING), '') ||
               COALESCE(CAST(fri_closing_tm AS STRING), '') ||
               COALESCE(CAST(fri_break_start_tm AS STRING), '') ||
               COALESCE(CAST(fri_break_end_tm AS STRING), ''),
               r'(\d+):(\d+):00', '\\1:\\2'
           ),
           r'\D', ''
       ) AS _open_time_fr_nrm,
       -- Saturday
       REGEXP_REPLACE(
           REGEXP_REPLACE(
               COALESCE(CAST(sat_opening_tm AS STRING), '') ||
               COALESCE(CAST(sat_closing_tm AS STRING), '') ||
               COALESCE(CAST(sat_break_start_tm AS STRING), '') ||
               COALESCE(CAST(sat_break_end_tm AS STRING), ''),
               r'(\d+):(\d+):00', '\\1:\\2'
           ),
           r'\D', ''
       ) AS _open_time_sa_nrm,
       -- Sunday
       REGEXP_REPLACE(
           REGEXP_REPLACE(
               COALESCE(CAST(sun_opening_tm AS STRING), '') ||
               COALESCE(CAST(sun_closing_tm AS STRING), '') ||
               COALESCE(CAST(sun_break_start_tm AS STRING), '') ||
               COALESCE(CAST(sun_break_end_tm AS STRING), ''),
               r'(\d+):(\d+):00', '\\1:\\2'
           ),
           r'\D', ''
       ) AS _open_time_su_nrm
   FROM ldl_p_lew_core_ac.v_location_hist_1) AS ptm
WHERE dwh_valid_from <= dwh_valid_to;
