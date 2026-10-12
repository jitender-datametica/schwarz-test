/*
 #----------------------------------------------------------------------------
 # @ LIDL Stiftung & Co. KG - DWH / MIS
 #----------------------------------------------------------------------------
 # Interface: DDL for P_LEW_MART_MSI.V_SALESFORCE_SURVEY_DAY_CNTY
 #----------------------------------------------------------------------------
 # History:
 #  1.0  02.11.2022    Kitschke,Felix           Initial Version; AP0140749 CC-Dossier Views
 #----------------------------------------------------------------------------
 */

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_SALESFORCE_SURVEY_DAY_CNTY AS
SELECT
  t10.client_id
  ,t10.cc2
  ,t10.cc3
  ,t1.cust_complaint_sid
  ,t1.src_cust_complaint_nr
  ,t1.case_open_dt
  ,t3.cust_complaint_survey_dt
  ,t3.cust_complaint_feedback_val
  ,t8.dat_calendar
  ,t8.cy_month
  ,t8.cy AS byr
FROM
  P_LEW_MART_MSI_AC.V_CUSTOMER_COMPLAINT_CASE t1
  LEFT JOIN (
    SELECT
      cust_complaint_sid
      ,cust_complaint_srv_center_cd
    FROM
      P_LEW_CORE_AC.V_CUSTOMER_COMPLAINT_CASE_HIST
    WHERE
      CURRENT_DATE() BETWEEN dwh_valid_from
      AND dwh_valid_to
  ) t2 ON t1.cust_complaint_sid = t2.cust_complaint_sid
  LEFT JOIN (
    SELECT
      cust_complaint_sid
      ,cust_complaint_survey_dt
      ,cust_complaint_feedback_val
    FROM
      P_LEW_CORE_AC.V_CUSTOMER_COMPLAINT_CASE_SURVEY_HIST
    WHERE
      CURRENT_DATE() BETWEEN dwh_valid_from
      AND dwh_valid_to
  ) t3 ON t1.cust_complaint_sid = t3.cust_complaint_sid
  LEFT JOIN (
    SELECT
      dat_calendar
      ,cy
      ,cy_month
    FROM
      P_LEW_MART_MSI_AC.V_CAL_CALENDARDAY
  ) AS t8 ON SUBSTR(t3.cust_complaint_survey_dt, 0, 10) = t8.dat_calendar
  INNER JOIN (
    SELECT
      t1.client_id
      ,t2.cc2
      ,t2.cc3
    FROM
      P_LEW_MART_MSI_AC.V_REF_CLIENT_LEAD t1
      LEFT JOIN (
        SELECT
          'AF' AS cc2
          ,'AFG' AS cc3
        UNION
        ALL
        SELECT
          'AX' AS cc2
          ,'ALA' AS cc3
        UNION
        ALL
        SELECT
          'AL' AS cc2
          ,'ALB' AS cc3
        UNION
        ALL
        SELECT
          'DZ' AS cc2
          ,'DZA' AS cc3
        UNION
        ALL
        SELECT
          'AS' AS cc2
          ,'ASM' AS cc3
        UNION
        ALL
        SELECT
          'AD' AS cc2
          ,'AND' AS cc3
        UNION
        ALL
        SELECT
          'AO' AS cc2
          ,'AGO' AS cc3
        UNION
        ALL
        SELECT
          'AI' AS cc2
          ,'AIA' AS cc3
        UNION
        ALL
        SELECT
          'AQ' AS cc2
          ,'ATA' AS cc3
        UNION
        ALL
        SELECT
          'AG' AS cc2
          ,'ATG' AS cc3
        UNION
        ALL
        SELECT
          'AR' AS cc2
          ,'ARG' AS cc3
        UNION
        ALL
        SELECT
          'AM' AS cc2
          ,'ARM' AS cc3
        UNION
        ALL
        SELECT
          'AW' AS cc2
          ,'ABW' AS cc3
        UNION
        ALL
        SELECT
          'AU' AS cc2
          ,'AUS' AS cc3
        UNION
        ALL
        SELECT
          'AT' AS cc2
          ,'AUT' AS cc3
        UNION
        ALL
        SELECT
          'AZ' AS cc2
          ,'AZE' AS cc3
        UNION
        ALL
        SELECT
          'BS' AS cc2
          ,'BHS' AS cc3
        UNION
        ALL
        SELECT
          'BH' AS cc2
          ,'BHR' AS cc3
        UNION
        ALL
        SELECT
          'BD' AS cc2
          ,'BGD' AS cc3
        UNION
        ALL
        SELECT
          'BB' AS cc2
          ,'BRB' AS cc3
        UNION
        ALL
        SELECT
          'BY' AS cc2
          ,'BLR' AS cc3
        UNION
        ALL
        SELECT
          'BE' AS cc2
          ,'BEL' AS cc3
        UNION
        ALL
        SELECT
          'BZ' AS cc2
          ,'BLZ' AS cc3
        UNION
        ALL
        SELECT
          'BJ' AS cc2
          ,'BEN' AS cc3
        UNION
        ALL
        SELECT
          'BM' AS cc2
          ,'BMU' AS cc3
        UNION
        ALL
        SELECT
          'BT' AS cc2
          ,'BTN' AS cc3
        UNION
        ALL
        SELECT
          'BO' AS cc2
          ,'BOL' AS cc3
        UNION
        ALL
        SELECT
          'BQ' AS cc2
          ,'BES' AS cc3
        UNION
        ALL
        SELECT
          'BA' AS cc2
          ,'BIH' AS cc3
        UNION
        ALL
        SELECT
          'BW' AS cc2
          ,'BWA' AS cc3
        UNION
        ALL
        SELECT
          'BV' AS cc2
          ,'BVT' AS cc3
        UNION
        ALL
        SELECT
          'BR' AS cc2
          ,'BRA' AS cc3
        UNION
        ALL
        SELECT
          'IO' AS cc2
          ,'IOT' AS cc3
        UNION
        ALL
        SELECT
          'BN' AS cc2
          ,'BRN' AS cc3
        UNION
        ALL
        SELECT
          'BG' AS cc2
          ,'BGR' AS cc3
        UNION
        ALL
        SELECT
          'BF' AS cc2
          ,'BFA' AS cc3
        UNION
        ALL
        SELECT
          'BI' AS cc2
          ,'BDI' AS cc3
        UNION
        ALL
        SELECT
          'CV' AS cc2
          ,'CPV' AS cc3
        UNION
        ALL
        SELECT
          'KH' AS cc2
          ,'KHM' AS cc3
        UNION
        ALL
        SELECT
          'CM' AS cc2
          ,'CMR' AS cc3
        UNION
        ALL
        SELECT
          'CA' AS cc2
          ,'CAN' AS cc3
        UNION
        ALL
        SELECT
          'KY' AS cc2
          ,'CYM' AS cc3
        UNION
        ALL
        SELECT
          'CF' AS cc2
          ,'CAF' AS cc3
        UNION
        ALL
        SELECT
          'TD' AS cc2
          ,'TCD' AS cc3
        UNION
        ALL
        SELECT
          'CL' AS cc2
          ,'CHL' AS cc3
        UNION
        ALL
        SELECT
          'CN' AS cc2
          ,'CHN' AS cc3
        UNION
        ALL
        SELECT
          'CX' AS cc2
          ,'CXR' AS cc3
        UNION
        ALL
        SELECT
          'CC' AS cc2
          ,'CCK' AS cc3
        UNION
        ALL
        SELECT
          'CO' AS cc2
          ,'COL' AS cc3
        UNION
        ALL
        SELECT
          'KM' AS cc2
          ,'COM' AS cc3
        UNION
        ALL
        SELECT
          'CG' AS cc2
          ,'COG' AS cc3
        UNION
        ALL
        SELECT
          'CD' AS cc2
          ,'COD' AS cc3
        UNION
        ALL
        SELECT
          'CK' AS cc2
          ,'COK' AS cc3
        UNION
        ALL
        SELECT
          'CR' AS cc2
          ,'CRI' AS cc3
        UNION
        ALL
        SELECT
          'CI' AS cc2
          ,'CIV' AS cc3
        UNION
        ALL
        SELECT
          'HR' AS cc2
          ,'HRV' AS cc3
        UNION
        ALL
        SELECT
          'CU' AS cc2
          ,'CUB' AS cc3
        UNION
        ALL
        SELECT
          'CW' AS cc2
          ,'CUW' AS cc3
        UNION
        ALL
        SELECT
          'CY' AS cc2
          ,'CYP' AS cc3
        UNION
        ALL
        SELECT
          'CZ' AS cc2
          ,'CZE' AS cc3
        UNION
        ALL
        SELECT
          'DK' AS cc2
          ,'DNK' AS cc3
        UNION
        ALL
        SELECT
          'DJ' AS cc2
          ,'DJI' AS cc3
        UNION
        ALL
        SELECT
          'DM' AS cc2
          ,'DMA' AS cc3
        UNION
        ALL
        SELECT
          'DO' AS cc2
          ,'DOM' AS cc3
        UNION
        ALL
        SELECT
          'EC' AS cc2
          ,'ECU' AS cc3
        UNION
        ALL
        SELECT
          'EG' AS cc2
          ,'EGY' AS cc3
        UNION
        ALL
        SELECT
          'SV' AS cc2
          ,'SLV' AS cc3
        UNION
        ALL
        SELECT
          'GQ' AS cc2
          ,'GNQ' AS cc3
        UNION
        ALL
        SELECT
          'ER' AS cc2
          ,'ERI' AS cc3
        UNION
        ALL
        SELECT
          'EE' AS cc2
          ,'EST' AS cc3
        UNION
        ALL
        SELECT
          'SZ' AS cc2
          ,'SWZ' AS cc3
        UNION
        ALL
        SELECT
          'ET' AS cc2
          ,'ETH' AS cc3
        UNION
        ALL
        SELECT
          'FK' AS cc2
          ,'FLK' AS cc3
        UNION
        ALL
        SELECT
          'FO' AS cc2
          ,'FRO' AS cc3
        UNION
        ALL
        SELECT
          'FJ' AS cc2
          ,'FJI' AS cc3
        UNION
        ALL
        SELECT
          'FI' AS cc2
          ,'FIN' AS cc3
        UNION
        ALL
        SELECT
          'FR' AS cc2
          ,'FRA' AS cc3
        UNION
        ALL
        SELECT
          'GF' AS cc2
          ,'GUF' AS cc3
        UNION
        ALL
        SELECT
          'PF' AS cc2
          ,'PYF' AS cc3
        UNION
        ALL
        SELECT
          'TF' AS cc2
          ,'ATF' AS cc3
        UNION
        ALL
        SELECT
          'GA' AS cc2
          ,'GAB' AS cc3
        UNION
        ALL
        SELECT
          'GM' AS cc2
          ,'GMB' AS cc3
        UNION
        ALL
        SELECT
          'GE' AS cc2
          ,'GEO' AS cc3
        UNION
        ALL
        SELECT
          'DE' AS cc2
          ,'DEU' AS cc3
        UNION
        ALL
        SELECT
          'GH' AS cc2
          ,'GHA' AS cc3
        UNION
        ALL
        SELECT
          'GI' AS cc2
          ,'GIB' AS cc3
        UNION
        ALL
        SELECT
          'GR' AS cc2
          ,'GRC' AS cc3
        UNION
        ALL
        SELECT
          'GL' AS cc2
          ,'GRL' AS cc3
        UNION
        ALL
        SELECT
          'GD' AS cc2
          ,'GRD' AS cc3
        UNION
        ALL
        SELECT
          'GP' AS cc2
          ,'GLP' AS cc3
        UNION
        ALL
        SELECT
          'GU' AS cc2
          ,'GUM' AS cc3
        UNION
        ALL
        SELECT
          'GT' AS cc2
          ,'GTM' AS cc3
        UNION
        ALL
        SELECT
          'GG' AS cc2
          ,'GGY' AS cc3
        UNION
        ALL
        SELECT
          'GN' AS cc2
          ,'GIN' AS cc3
        UNION
        ALL
        SELECT
          'GW' AS cc2
          ,'GNB' AS cc3
        UNION
        ALL
        SELECT
          'GY' AS cc2
          ,'GUY' AS cc3
        UNION
        ALL
        SELECT
          'HT' AS cc2
          ,'HTI' AS cc3
        UNION
        ALL
        SELECT
          'HM' AS cc2
          ,'HMD' AS cc3
        UNION
        ALL
        SELECT
          'VA' AS cc2
          ,'VAT' AS cc3
        UNION
        ALL
        SELECT
          'HN' AS cc2
          ,'HND' AS cc3
        UNION
        ALL
        SELECT
          'HK' AS cc2
          ,'HKG' AS cc3
        UNION
        ALL
        SELECT
          'HU' AS cc2
          ,'HUN' AS cc3
        UNION
        ALL
        SELECT
          'IS' AS cc2
          ,'ISL' AS cc3
        UNION
        ALL
        SELECT
          'IN' AS cc2
          ,'IND' AS cc3
        UNION
        ALL
        SELECT
          'ID' AS cc2
          ,'IDN' AS cc3
        UNION
        ALL
        SELECT
          'IR' AS cc2
          ,'IRN' AS cc3
        UNION
        ALL
        SELECT
          'IQ' AS cc2
          ,'IRQ' AS cc3
        UNION
        ALL
        SELECT
          'IE' AS cc2
          ,'IRL' AS cc3
        UNION
        ALL
        SELECT
          'IM' AS cc2
          ,'IMN' AS cc3
        UNION
        ALL
        SELECT
          'IL' AS cc2
          ,'ISR' AS cc3
        UNION
        ALL
        SELECT
          'IT' AS cc2
          ,'ITA' AS cc3
        UNION
        ALL
        SELECT
          'JM' AS cc2
          ,'JAM' AS cc3
        UNION
        ALL
        SELECT
          'JP' AS cc2
          ,'JPN' AS cc3
        UNION
        ALL
        SELECT
          'JE' AS cc2
          ,'JEY' AS cc3
        UNION
        ALL
        SELECT
          'JO' AS cc2
          ,'JOR' AS cc3
        UNION
        ALL
        SELECT
          'KZ' AS cc2
          ,'KAZ' AS cc3
        UNION
        ALL
        SELECT
          'KE' AS cc2
          ,'KEN' AS cc3
        UNION
        ALL
        SELECT
          'KI' AS cc2
          ,'KIR' AS cc3
        UNION
        ALL
        SELECT
          'KP' AS cc2
          ,'PRK' AS cc3
        UNION
        ALL
        SELECT
          'KR' AS cc2
          ,'KOR' AS cc3
        UNION
        ALL
        SELECT
          'KW' AS cc2
          ,'KWT' AS cc3
        UNION
        ALL
        SELECT
          'KG' AS cc2
          ,'KGZ' AS cc3
        UNION
        ALL
        SELECT
          'LA' AS cc2
          ,'LAO' AS cc3
        UNION
        ALL
        SELECT
          'LV' AS cc2
          ,'LVA' AS cc3
        UNION
        ALL
        SELECT
          'LB' AS cc2
          ,'LBN' AS cc3
        UNION
        ALL
        SELECT
          'LS' AS cc2
          ,'LSO' AS cc3
        UNION
        ALL
        SELECT
          'LR' AS cc2
          ,'LBR' AS cc3
        UNION
        ALL
        SELECT
          'LY' AS cc2
          ,'LBY' AS cc3
        UNION
        ALL
        SELECT
          'LI' AS cc2
          ,'LIE' AS cc3
        UNION
        ALL
        SELECT
          'LT' AS cc2
          ,'LTU' AS cc3
        UNION
        ALL
        SELECT
          'LU' AS cc2
          ,'LUX' AS cc3
        UNION
        ALL
        SELECT
          'MO' AS cc2
          ,'MAC' AS cc3
        UNION
        ALL
        SELECT
          'MG' AS cc2
          ,'MDG' AS cc3
        UNION
        ALL
        SELECT
          'MW' AS cc2
          ,'MWI' AS cc3
        UNION
        ALL
        SELECT
          'MY' AS cc2
          ,'MYS' AS cc3
        UNION
        ALL
        SELECT
          'MV' AS cc2
          ,'MDV' AS cc3
        UNION
        ALL
        SELECT
          'ML' AS cc2
          ,'MLI' AS cc3
        UNION
        ALL
        SELECT
          'MT' AS cc2
          ,'MLT' AS cc3
        UNION
        ALL
        SELECT
          'MH' AS cc2
          ,'MHL' AS cc3
        UNION
        ALL
        SELECT
          'MQ' AS cc2
          ,'MTQ' AS cc3
        UNION
        ALL
        SELECT
          'MR' AS cc2
          ,'MRT' AS cc3
        UNION
        ALL
        SELECT
          'MU' AS cc2
          ,'MUS' AS cc3
        UNION
        ALL
        SELECT
          'YT' AS cc2
          ,'MYT' AS cc3
        UNION
        ALL
        SELECT
          'MX' AS cc2
          ,'MEX' AS cc3
        UNION
        ALL
        SELECT
          'FM' AS cc2
          ,'FSM' AS cc3
        UNION
        ALL
        SELECT
          'MD' AS cc2
          ,'MDA' AS cc3
        UNION
        ALL
        SELECT
          'MC' AS cc2
          ,'MCO' AS cc3
        UNION
        ALL
        SELECT
          'MN' AS cc2
          ,'MNG' AS cc3
        UNION
        ALL
        SELECT
          'ME' AS cc2
          ,'MNE' AS cc3
        UNION
        ALL
        SELECT
          'MS' AS cc2
          ,'MSR' AS cc3
        UNION
        ALL
        SELECT
          'MA' AS cc2
          ,'MAR' AS cc3
        UNION
        ALL
        SELECT
          'MZ' AS cc2
          ,'MOZ' AS cc3
        UNION
        ALL
        SELECT
          'MM' AS cc2
          ,'MMR' AS cc3
        UNION
        ALL
        SELECT
          'NA' AS cc2
          ,'NAM' AS cc3
        UNION
        ALL
        SELECT
          'NR' AS cc2
          ,'NRU' AS cc3
        UNION
        ALL
        SELECT
          'NP' AS cc2
          ,'NPL' AS cc3
        UNION
        ALL
        SELECT
          'NL' AS cc2
          ,'NLD' AS cc3
        UNION
        ALL
        SELECT
          'NC' AS cc2
          ,'NCL' AS cc3
        UNION
        ALL
        SELECT
          'NZ' AS cc2
          ,'NZL' AS cc3
        UNION
        ALL
        SELECT
          'NI' AS cc2
          ,'NIC' AS cc3
        UNION
        ALL
        SELECT
          'NE' AS cc2
          ,'NER' AS cc3
        UNION
        ALL
        SELECT
          'NG' AS cc2
          ,'NGA' AS cc3
        UNION
        ALL
        SELECT
          'NU' AS cc2
          ,'NIU' AS cc3
        UNION
        ALL
        SELECT
          'NF' AS cc2
          ,'NFK' AS cc3
        UNION
        ALL
        SELECT
          'MK' AS cc2
          ,'MKD' AS cc3
        UNION
        ALL
        SELECT
          'MP' AS cc2
          ,'MNP' AS cc3
        UNION
        ALL
        SELECT
          'NO' AS cc2
          ,'NOR' AS cc3
        UNION
        ALL
        SELECT
          'OM' AS cc2
          ,'OMN' AS cc3
        UNION
        ALL
        SELECT
          'PK' AS cc2
          ,'PAK' AS cc3
        UNION
        ALL
        SELECT
          'PW' AS cc2
          ,'PLW' AS cc3
        UNION
        ALL
        SELECT
          'PS' AS cc2
          ,'PSE' AS cc3
        UNION
        ALL
        SELECT
          'PA' AS cc2
          ,'PAN' AS cc3
        UNION
        ALL
        SELECT
          'PG' AS cc2
          ,'PNG' AS cc3
        UNION
        ALL
        SELECT
          'PY' AS cc2
          ,'PRY' AS cc3
        UNION
        ALL
        SELECT
          'PE' AS cc2
          ,'PER' AS cc3
        UNION
        ALL
        SELECT
          'PH' AS cc2
          ,'PHL' AS cc3
        UNION
        ALL
        SELECT
          'PN' AS cc2
          ,'PCN' AS cc3
        UNION
        ALL
        SELECT
          'PL' AS cc2
          ,'POL' AS cc3
        UNION
        ALL
        SELECT
          'PT' AS cc2
          ,'PRT' AS cc3
        UNION
        ALL
        SELECT
          'PR' AS cc2
          ,'PRI' AS cc3
        UNION
        ALL
        SELECT
          'QA' AS cc2
          ,'QAT' AS cc3
        UNION
        ALL
        SELECT
          'RE' AS cc2
          ,'REU' AS cc3
        UNION
        ALL
        SELECT
          'RO' AS cc2
          ,'ROU' AS cc3
        UNION
        ALL
        SELECT
          'RU' AS cc2
          ,'RUS' AS cc3
        UNION
        ALL
        SELECT
          'RW' AS cc2
          ,'RWA' AS cc3
        UNION
        ALL
        SELECT
          'BL' AS cc2
          ,'BLM' AS cc3
        UNION
        ALL
        SELECT
          'SH' AS cc2
          ,'SHN' AS cc3
        UNION
        ALL
        SELECT
          'KN' AS cc2
          ,'KNA' AS cc3
        UNION
        ALL
        SELECT
          'LC' AS cc2
          ,'LCA' AS cc3
        UNION
        ALL
        SELECT
          'MF' AS cc2
          ,'MAF' AS cc3
        UNION
        ALL
        SELECT
          'PM' AS cc2
          ,'SPM' AS cc3
        UNION
        ALL
        SELECT
          'VC' AS cc2
          ,'VCT' AS cc3
        UNION
        ALL
        SELECT
          'WS' AS cc2
          ,'WSM' AS cc3
        UNION
        ALL
        SELECT
          'SM' AS cc2
          ,'SMR' AS cc3
        UNION
        ALL
        SELECT
          'ST' AS cc2
          ,'STP' AS cc3
        UNION
        ALL
        SELECT
          'SA' AS cc2
          ,'SAU' AS cc3
        UNION
        ALL
        SELECT
          'SN' AS cc2
          ,'SEN' AS cc3
        UNION
        ALL
        SELECT
          'RS' AS cc2
          ,'SRB' AS cc3
        UNION
        ALL
        SELECT
          'SC' AS cc2
          ,'SYC' AS cc3
        UNION
        ALL
        SELECT
          'SL' AS cc2
          ,'SLE' AS cc3
        UNION
        ALL
        SELECT
          'SG' AS cc2
          ,'SGP' AS cc3
        UNION
        ALL
        SELECT
          'SX' AS cc2
          ,'SXM' AS cc3
        UNION
        ALL
        SELECT
          'SK' AS cc2
          ,'SVK' AS cc3
        UNION
        ALL
        SELECT
          'SI' AS cc2
          ,'SVN' AS cc3
        UNION
        ALL
        SELECT
          'SB' AS cc2
          ,'SLB' AS cc3
        UNION
        ALL
        SELECT
          'SO' AS cc2
          ,'SOM' AS cc3
        UNION
        ALL
        SELECT
          'ZA' AS cc2
          ,'ZAF' AS cc3
        UNION
        ALL
        SELECT
          'GS' AS cc2
          ,'SGS' AS cc3
        UNION
        ALL
        SELECT
          'SS' AS cc2
          ,'SSD' AS cc3
        UNION
        ALL
        SELECT
          'ES' AS cc2
          ,'ESP' AS cc3
        UNION
        ALL
        SELECT
          'LK' AS cc2
          ,'LKA' AS cc3
        UNION
        ALL
        SELECT
          'SD' AS cc2
          ,'SDN' AS cc3
        UNION
        ALL
        SELECT
          'SR' AS cc2
          ,'SUR' AS cc3
        UNION
        ALL
        SELECT
          'SJ' AS cc2
          ,'SJM' AS cc3
        UNION
        ALL
        SELECT
          'SE' AS cc2
          ,'SWE' AS cc3
        UNION
        ALL
        SELECT
          'CH' AS cc2
          ,'CHE' AS cc3
        UNION
        ALL
        SELECT
          'SY' AS cc2
          ,'SYR' AS cc3
        UNION
        ALL
        SELECT
          'TW' AS cc2
          ,'TWN' AS cc3
        UNION
        ALL
        SELECT
          'TJ' AS cc2
          ,'TJK' AS cc3
        UNION
        ALL
        SELECT
          'TZ' AS cc2
          ,'TZA' AS cc3
        UNION
        ALL
        SELECT
          'TH' AS cc2
          ,'THA' AS cc3
        UNION
        ALL
        SELECT
          'TL' AS cc2
          ,'TLS' AS cc3
        UNION
        ALL
        SELECT
          'TG' AS cc2
          ,'TGO' AS cc3
        UNION
        ALL
        SELECT
          'TK' AS cc2
          ,'TKL' AS cc3
        UNION
        ALL
        SELECT
          'TO' AS cc2
          ,'TON' AS cc3
        UNION
        ALL
        SELECT
          'TT' AS cc2
          ,'TTO' AS cc3
        UNION
        ALL
        SELECT
          'TN' AS cc2
          ,'TUN' AS cc3
        UNION
        ALL
        SELECT
          'TR' AS cc2
          ,'TUR' AS cc3
        UNION
        ALL
        SELECT
          'TM' AS cc2
          ,'TKM' AS cc3
        UNION
        ALL
        SELECT
          'TC' AS cc2
          ,'TCA' AS cc3
        UNION
        ALL
        SELECT
          'TV' AS cc2
          ,'TUV' AS cc3
        UNION
        ALL
        SELECT
          'UG' AS cc2
          ,'UGA' AS cc3
        UNION
        ALL
        SELECT
          'UA' AS cc2
          ,'UKR' AS cc3
        UNION
        ALL
        SELECT
          'AE' AS cc2
          ,'ARE' AS cc3
        UNION
        ALL
        SELECT
          'GB' AS cc2
          ,'GBR' AS cc3
        UNION
        ALL
        SELECT
          'US' AS cc2
          ,'USA' AS cc3
        UNION
        ALL
        SELECT
          'UM' AS cc2
          ,'UMI' AS cc3
        UNION
        ALL
        SELECT
          'UY' AS cc2
          ,'URY' AS cc3
        UNION
        ALL
        SELECT
          'UZ' AS cc2
          ,'UZB' AS cc3
        UNION
        ALL
        SELECT
          'VU' AS cc2
          ,'VUT' AS cc3
        UNION
        ALL
        SELECT
          'VE' AS cc2
          ,'VEN' AS cc3
        UNION
        ALL
        SELECT
          'VN' AS cc2
          ,'VNM' AS cc3
        UNION
        ALL
        SELECT
          'VG' AS cc2
          ,'VGB' AS cc3
        UNION
        ALL
        SELECT
          'VI' AS cc2
          ,'VIR' AS cc3
        UNION
        ALL
        SELECT
          'WF' AS cc2
          ,'WLF' AS cc3
        UNION
        ALL
        SELECT
          'EH' AS cc2
          ,'ESH' AS cc3
        UNION
        ALL
        SELECT
          'YE' AS cc2
          ,'YEM' AS cc3
        UNION
        ALL
        SELECT
          'ZM' AS cc2
          ,'ZMB' AS cc3
        UNION
        ALL
        SELECT
          'ZW' AS cc2
          ,'ZWE' AS cc3
        UNION
        ALL
        SELECT
          'EU' AS cc2
          ,'INT' AS cc3
      ) t2 ON t1.country_iso_cd = cc2
  ) t10 ON t2.cust_complaint_srv_center_cd = t10.cc3
WHERE
  t1.src_name = 'Salesforce';