-- 24.07.2017 twie: SPEC0025359 neues Security Kennzeichen für Sicherheitsfilter

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_l_kmr_security (sec_kz, sec_bez) AS SELECT sec_kz,
 sec_bez
FROM kfl_production_dbp_msi_v_view.v_l_kmr_security;