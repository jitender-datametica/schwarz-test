CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_kampagne_optin_monat_2 (crm_optin_kanal_id, mandant_id, kjmo
, kum_monat_total, kum_monat_not_granted, kum_montat_granted) AS WITH OPTIN_KJMO AS (SELECT a14.kjmo,
   A11.crm_optin_kanal_cd AS optin_kanal_id,
   A15.crm_optin_kanal_bez AS optin_kanal_bez,
   A13.crm_optin_statusgrund_cd AS optin_statusgrund_id,
   A17.crm_optin_statusgrund_bez AS optin_statusgrund_bez,
   a14.kunde_mandant_id AS mandant_id,
   a14.crm_kunde_id,
    CASE
    WHEN A17.crm_optin_statusgrund_cd IN ('inquired', 'notGranted', 'inactive')
    THEN a14.crm_kunde_id
    ELSE NULL
    END AS not_granted_user,
    CASE
    WHEN A17.crm_optin_statusgrund_cd = 'granted'
    THEN a14.crm_kunde_id
    ELSE NULL
    END AS granted_user
  FROM kfl_production_dbp_data.crm_l_optin_2 AS A11
   INNER JOIN kfl_production_dbp_data.crm_kunde_optin_zu_2 AS A13 ON A11.crm_optin_id = A13.crm_optin_id
   INNER JOIN (SELECT V01.crm_kunde_id,
     DATE(V01.zeit_registrierung) AS dat_registrierung,
     DATE(V01.zeit_abmeldung) AS dat_abmeldung_original,
     DATE_ADD(DATE_TRUNC(DATE_ADD(DATE_TRUNC(DATE(V01.zeit_abmeldung), MONTH), INTERVAL 31 DAY), MONTH), INTERVAL - 1
      DAY) AS letzter_tag_monat_abmeldung,
      CASE
      WHEN DATE(V01.zeit_abmeldung) <= DATE_ADD(DATE_TRUNC(DATE_ADD(DATE_TRUNC(DATE(V01.zeit_abmeldung), MONTH),
          INTERVAL 31 DAY), MONTH), INTERVAL - 1 DAY)
      THEN DATE_ADD(DATE_TRUNC(DATE(V01.zeit_abmeldung), MONTH), INTERVAL - 1 DAY)
      ELSE DATE(V01.zeit_abmeldung)
      END AS dat_abmeldung_neu,
     V01.kunde_mandant_id,
     V02.kjmo
    FROM kfl_production_dbp_data.crm_l_kunde_2 AS V01
     INNER JOIN kfl_production_dbp_data.tag_2 AS V02 ON TRUE
    WHERE V02.kjmo BETWEEN ROUND(CAST(SUBSTR(REPLACE(SUBSTR(CAST(DATE_ADD(DATE_TRUNC(DATE(V01.zeit_registrierung), MONTH), INTERVAL 0 YEAR) AS STRING), 1, 20), '-', ''), 1, 6) AS BIGNUMERIC)
       , 0) AND (ROUND(CAST(SUBSTR(REPLACE(SUBSTR(CAST(DATE_ADD(DATE_TRUNC(DATE(CASE
                 WHEN DATE(V01.zeit_abmeldung) <= DATE_ADD(DATE_TRUNC(DATE_ADD(DATE_TRUNC(DATE(V01.zeit_abmeldung), MONTH), INTERVAL 31 DAY), MONTH), INTERVAL - 1 DAY)
                 THEN DATE_ADD(DATE_TRUNC(DATE(V01.zeit_abmeldung), MONTH), INTERVAL - 1 DAY)
                 ELSE DATE(V01.zeit_abmeldung)
                 END), MONTH), INTERVAL 0 YEAR) AS STRING), 1, 20), '-', ''), 1, 6) AS BIGNUMERIC), 0))
     AND V02.akt_mo <= 0
    GROUP BY V01.crm_kunde_id,
     dat_registrierung,
     dat_abmeldung_original,
     letzter_tag_monat_abmeldung,
     dat_abmeldung_neu,
     V01.kunde_mandant_id,
     V02.kjmo
    ORDER BY V02.kjmo NULLS LAST) AS a14 ON A13.crm_kunde_id = a14.crm_kunde_id
   INNER JOIN kfl_production_dbp_data.crm_optin_kanal_spr_zu_2 AS A15 ON A11.crm_optin_kanal_cd = A15.crm_optin_kanal_cd
   INNER JOIN kfl_production_dbp_data.crm_optin_statusgrund_spr_zu_2 AS A17 ON A13.crm_optin_statusgrund_cd = A17.crm_optin_statusgrund_cd
    
  WHERE A11.crm_optin_kanal_cd IN ('emailLoyalty', 'smsLoyalty')) (SELECT optin_kanal_id,
   mandant_id,
   kjmo,
   COUNT(DISTINCT crm_kunde_id),
   COUNT(DISTINCT not_granted_user),
   COUNT(DISTINCT granted_user)
  FROM OPTIN_KJMO
  GROUP BY kjmo,
   optin_kanal_id,
   mandant_id);