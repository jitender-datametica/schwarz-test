CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_kampagne_optin_dat_1 (mandant_id, dat, kjmo,
crm_optin_kanal_id, kum_monat_total, kum_monat_not_granted, kum_montat_granted) AS WITH OPTIN_DAT AS (SELECT a14.dat,
   a14.kjmo,
   A11.crm_optin_kanal_cd AS crm_optin_kanal_id,
   A15.crm_optin_kanal_bez,
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
  FROM kfl_production_dbp_data.crm_l_optin_1 AS A11
   INNER JOIN kfl_production_dbp_data.crm_kunde_optin_zu_1 AS A13 ON A11.crm_optin_id = A13.crm_optin_id
   INNER JOIN (SELECT V01.crm_kunde_id,
     V01.kunde_mandant_id,
     V02.dat,
     V02.kjmo,
     DATE(V01.zeit_registrierung) AS dat_registrierung,
     DATE(V01.zeit_abmeldung) AS abmeldung_orginal
    FROM kfl_production_dbp_data.crm_l_kunde_1 AS V01
     INNER JOIN kfl_production_dbp_data.tag_1 AS V02 ON TRUE
    WHERE V02.dat BETWEEN DATE(V01.zeit_registrierung) AND (DATE(V01.zeit_abmeldung))
     AND DATE(V01.zeit_abmeldung) > CURRENT_DATE
     AND DATE(V01.zeit_registrierung) <= CURRENT_DATE
     AND V02.akt_mo <= 0
    GROUP BY V01.crm_kunde_id,
     V01.kunde_mandant_id,
     V02.dat,
     V02.kjmo,
     dat_registrierung,
     abmeldung_orginal) AS a14 ON A13.crm_kunde_id = a14.crm_kunde_id
   INNER JOIN kfl_production_dbp_data.crm_optin_kanal_spr_zu_1 AS A15 ON A11.crm_optin_kanal_cd = A15.crm_optin_kanal_cd
   INNER JOIN kfl_production_dbp_data.crm_optin_statusgrund_spr_zu_1 AS A17 ON A13.crm_optin_statusgrund_cd = A17.crm_optin_statusgrund_cd
    
  WHERE A11.crm_optin_kanal_cd IN ('emailLoyalty', 'smsLoyalty')
  GROUP BY a14.dat,
   a14.kjmo,
   crm_optin_kanal_id,
   A15.crm_optin_kanal_bez,
   optin_statusgrund_id,
   optin_statusgrund_bez,
   mandant_id,
   a14.crm_kunde_id,
   not_granted_user,
   granted_user) (SELECT mandant_id,
   dat,
   kjmo,
   crm_optin_kanal_id,
   COUNT(DISTINCT crm_kunde_id),
   COUNT(DISTINCT not_granted_user),
   COUNT(DISTINCT granted_user)
  FROM OPTIN_DAT
  GROUP BY dat,
   kjmo,
   crm_optin_kanal_id,
   mandant_id);