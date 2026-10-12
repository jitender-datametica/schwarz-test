/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      V_AG_ELKE_STAMMDATEN_WH_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2025-12-11      Simeon Nikolaev            Initial version
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_ag_elke_stammdaten_wh_2 (landeskuerzel, client_id, gesellschaft_nr,
gesellschaftskuerzel, gesellschaft, gesellschaftstyp) AS SELECT landeskuerzel,
  CASE
  WHEN landeskuerzel = 'INT'
  THEN 0
  WHEN landeskuerzel = 'AT'
  THEN 1
  WHEN landeskuerzel = 'BE'
  THEN 2
  WHEN landeskuerzel = 'BG'
  THEN 3
  WHEN landeskuerzel = 'CH'
  THEN 4
  WHEN landeskuerzel = 'CY'
  THEN 5
  WHEN landeskuerzel = 'CZ'
  THEN 6
  WHEN landeskuerzel = 'DK'
  THEN 8
  WHEN landeskuerzel = 'ES'
  THEN 10
  WHEN landeskuerzel = 'FI'
  THEN 11
  WHEN landeskuerzel = 'FR'
  THEN 12
  WHEN landeskuerzel = 'GB'
  THEN 13
  WHEN landeskuerzel = 'GR'
  THEN 14
  WHEN landeskuerzel = 'HR'
  THEN 15
  WHEN landeskuerzel = 'HU'
  THEN 16
  WHEN landeskuerzel = 'IE'
  THEN 17
  WHEN landeskuerzel = 'IT'
  THEN 18
  WHEN landeskuerzel = 'LT'
  THEN 19
  WHEN landeskuerzel = 'LV'
  THEN 20
  WHEN landeskuerzel = 'NI'
  THEN 21
  WHEN landeskuerzel = 'NL'
  THEN 22
  WHEN landeskuerzel = 'DE'
  THEN 23
  WHEN landeskuerzel = 'PL'
  THEN 24
  WHEN landeskuerzel = 'PT'
  THEN 25
  WHEN landeskuerzel = 'RO'
  THEN 26
  WHEN landeskuerzel = 'SE'
  THEN 27
  WHEN landeskuerzel = 'SI'
  THEN 28
  WHEN landeskuerzel = 'SK'
  THEN 29
  WHEN landeskuerzel = 'CS'
  THEN 31
  WHEN landeskuerzel = 'MT'
  THEN 32
  WHEN landeskuerzel = 'US'
  THEN 33
  WHEN landeskuerzel = 'RS_2'
  THEN 34
  ELSE NULL
  END AS client_id,
 gesellschaftsnummer AS gesellschaft_nr,
 gesellschaftskuerzel,
  CASE
  WHEN gesellschaftsnummer = - 9998
  THEN 'AT'
  WHEN gesellschaftsnummer = - 9997
  THEN 'BE'
  WHEN gesellschaftsnummer = - 9996
  THEN 'BG'
  WHEN gesellschaftsnummer = - 9995
  THEN 'CH'
  WHEN gesellschaftsnummer = - 9994
  THEN 'CS'
  WHEN gesellschaftsnummer = - 9993
  THEN 'CY'
  WHEN gesellschaftsnummer = - 9992
  THEN 'CZ'
  WHEN gesellschaftsnummer = - 9991
  THEN 'DE'
  WHEN gesellschaftsnummer = - 9990
  THEN 'DK'
  WHEN gesellschaftsnummer = - 9989
  THEN 'EE'
  WHEN gesellschaftsnummer = - 9988
  THEN 'ES'
  WHEN gesellschaftsnummer = - 9987
  THEN 'FI'
  WHEN gesellschaftsnummer = - 9986
  THEN 'FR'
  WHEN gesellschaftsnummer = - 9985
  THEN 'GB'
  WHEN gesellschaftsnummer = - 9984
  THEN 'GR'
  WHEN gesellschaftsnummer = - 9983
  THEN 'HR'
  WHEN gesellschaftsnummer = - 9982
  THEN 'HU'
  WHEN gesellschaftsnummer = - 9981
  THEN 'IE'
  WHEN gesellschaftsnummer = - 9980
  THEN 'IT'
  WHEN gesellschaftsnummer = - 9979
  THEN 'LT'
  WHEN gesellschaftsnummer = - 9978
  THEN 'LV'
  WHEN gesellschaftsnummer = - 9977
  THEN 'MT'
  WHEN gesellschaftsnummer = - 9976
  THEN 'NI'
  WHEN gesellschaftsnummer = - 9975
  THEN 'NL'
  WHEN gesellschaftsnummer = - 9974
  THEN 'PL'
  WHEN gesellschaftsnummer = - 9973
  THEN 'PT'
  WHEN gesellschaftsnummer = - 9972
  THEN 'RO'
  WHEN gesellschaftsnummer = - 9971
  THEN 'RS_2'
  WHEN gesellschaftsnummer = - 9970
  THEN 'SE'
  WHEN gesellschaftsnummer = - 9969
  THEN 'SI'
  WHEN gesellschaftsnummer = - 9968
  THEN 'SK'
  WHEN gesellschaftsnummer = - 9967
  THEN 'US'
  WHEN gesellschaftsnummer = - 10000
  THEN 'INT'
  ELSE gesellschaftsname
  END AS gesellschaft,
 gesellschaftstyp
FROM ldl_logop_data.t_ag_elke_stammdaten_2;