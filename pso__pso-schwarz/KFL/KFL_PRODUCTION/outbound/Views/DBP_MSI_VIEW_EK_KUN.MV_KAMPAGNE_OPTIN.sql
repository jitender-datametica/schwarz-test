CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_kampagne_optin (mandant_id, kampagne_id, kampagne_name,
dat_kampagne_von, dat_kampagne_bis, kampagne_rhythmus_typ_id, kampagne_version_nr, crm_optin_kanal_id,
anzahl_optin_antworten) AS SELECT V04.mandant_id,
 V04.kampagne_id,
 V04.kampagne_name,
 V04.dat_kampagne_von,
 V04.dat_kampagne_bis,
 V04.kampagne_rhythmus_typ_id,
 V04.kampagne_version_nr,
 V01.crm_optin_kanal_cd AS crm_optin_kanal_id,
 COUNT(DISTINCT V02.crm_optin_id) AS anzahl_optin_antworten
FROM kfl_production_dbp_view.v_crm_l_optin AS V01
 INNER JOIN kfl_production_dbp_view.v_crm_kunde_optin_zu AS V02 ON V01.crm_optin_id = V02.crm_optin_id
 INNER JOIN kfl_production_dbp_view.v_crm_l_kunde AS V03 ON V02.crm_kunde_id = V03.crm_kunde_id
 INNER JOIN kfl_production_dbp_view.v_kampagne AS V04 ON V03.registrierungsfiliale_mandant_id = V04.mandant_id AND DATE(V03
    .zeit_registrierung) <= V04.dat_kampagne_von
WHERE V01.crm_optin_kanal_cd IN ('emailLoyalty', 'smsLoyalty')
GROUP BY V04.mandant_id,
 V04.kampagne_id,
 V04.kampagne_name,
 V04.dat_kampagne_von,
 V04.dat_kampagne_bis,
 V04.kampagne_rhythmus_typ_id,
 V04.kampagne_version_nr,
 crm_optin_kanal_id;