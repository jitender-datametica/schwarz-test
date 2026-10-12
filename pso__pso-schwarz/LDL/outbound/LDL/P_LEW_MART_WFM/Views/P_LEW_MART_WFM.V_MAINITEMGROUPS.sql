CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_mainitemgroups AS SELECT CL.country_cd AS country_iso_cd,
  CASE
  WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
  THEN - 1000
  WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
  THEN 0
  WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
  THEN 1
  WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
  THEN 2
  WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
  THEN 3
  WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
  THEN 4
  WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
  THEN 5
  WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
  THEN 6
  WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
  THEN 7
  WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
  THEN 8
  WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
  THEN 9
  WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
  THEN 4
  WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
  THEN 99
  WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
  THEN 10
  WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
  THEN 990
  WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
  THEN 999
  ELSE NULL
  END AS mainitemgroup_id,
  CASE
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END < 0
  THEN 'Verkauf, Artikel nicht in WaWi angelegt'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 0
  THEN 'neu 0 - 9'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 1
  THEN 'Obst/Gemüse/Blumen'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 2
  THEN 'Tiko'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 3
  THEN 'Kühlung'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 4
  THEN 'Nahrungsmittel'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 5
  THEN 'Konserven'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 6
  THEN 'Getränke'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 7
  THEN 'Brot/Back-/Sü\u00dfwaren/OTC'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 8
  THEN 'Nonfood Sortiment'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 9
  THEN 'Geflügel/Fleisch/Fisch'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 99
  THEN 'neu 99'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 10
  THEN 'Non-Food Aktion / Spezial'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 990
  THEN 'neu 400 - 990'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 999
  THEN 'Verbrauchsgüter/Leergut'
  ELSE NULL
  END AS mainitemgroup_short_desc,
  CASE
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END < 0
  THEN 'Verkauf, Artikel nicht in WaWi angelegt'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 0
  THEN 'neu 0 - 9'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 1
  THEN 'Obst/Gemüse/Blumen'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 2
  THEN 'Tiko'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 3
  THEN 'Kühlung'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 4
  THEN 'Nahrungsmittel'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 5
  THEN 'Konserven'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 6
  THEN 'Getränke'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 7
  THEN 'Brot/Back-/Sü\u00dfwaren/OTC'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 8
  THEN 'Nonfood Sortiment'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 9
  THEN 'Geflügel/Fleisch/Fisch'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 99
  THEN 'neu 99'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 10
  THEN 'Non-Food Aktion / Spezial'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 990
  THEN 'neu 400 - 990'
  WHEN CASE
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) < 0
    THEN - 1000
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 0 AND 9
    THEN 0
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 10 AND 19
    THEN 1
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 20 AND 29
    THEN 2
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 30 AND 39
    THEN 3
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 40 AND 49
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 50 AND 59
    THEN 5
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 60 AND 69
    THEN 6
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 70 AND 79
    THEN 7
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 80 AND 89
    THEN 8
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 90 AND 97
    THEN 9
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 98
    THEN 4
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) = 99
    THEN 99
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 100 AND 399
    THEN 10
    WHEN CAST(SIG.src_subitemgrp_cd AS INTEGER) BETWEEN 400 AND 990
    THEN 990
    WHEN CAST(SIG.src_subitemgrp_cd AS FLOAT64) > 990
    THEN 999
    ELSE NULL
    END = 999
  THEN 'Verbrauchsgüter/Leergut'
  ELSE NULL
  END AS mainitemgroup_desc,
 MAPP.language_id
FROM ldl_p_lew_core_ac.v_subitemgroup AS SIG
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_descr AS SIG_DESCR ON SIG.client_id = SIG_DESCR.client_id AND SIG.sub_item_grp_sid
    = SIG_DESCR.sub_item_grp_sid
 INNER JOIN ldl_p_lew_core_ac.v_client AS CL ON SIG.client_id = CL.client_id
 INNER JOIN ldl_p_lew_core_ac.v_report_language AS RLANG ON SIG_DESCR.lang_sid = RLANG.lang_sid
 INNER JOIN ldl_p_lew_core_ac.v_map_lang_spras AS MAPP ON RLANG.src_spras = MAPP.sap_spras
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS MIG ON SIG.client_id = MIG.client_id
WHERE (MAPP.language_id = SIG.client_id OR MAPP.language_id = 7)
 AND CURRENT_DATE BETWEEN MIG.migration_dat_valid_from AND MIG.migration_dat_valid_to
 AND SIG.src_node IS NOT NULL
GROUP BY country_iso_cd,
 mainitemgroup_id,
 mainitemgroup_short_desc,
 mainitemgroup_desc,
 MAPP.language_id
UNION ALL
SELECT C.country_iso_cd,
 MAIN.mainitemgroup_id,
 MAIN.mainitemgroup_short_desc,
 MAIN.mainitemgroup_desc,
 MAIN.language_id
FROM ldl_p_lew_core_ac.v_wawi_itm_mainitemgroup AS MAIN
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_country AS CC ON MAIN.client_id = CC.client_id
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country AS C ON CC.country_id = C.country_id
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS MIG ON MAIN.client_id = MIG.client_id
WHERE MAIN.mainitemgroup_id > 0
 AND CURRENT_DATE BETWEEN MAIN.dat_rec_start AND MAIN.dat_rec_end
 AND (CURRENT_DATE < MIG.migration_dat_valid_from OR CURRENT_DATE > MIG.migration_dat_valid_to);