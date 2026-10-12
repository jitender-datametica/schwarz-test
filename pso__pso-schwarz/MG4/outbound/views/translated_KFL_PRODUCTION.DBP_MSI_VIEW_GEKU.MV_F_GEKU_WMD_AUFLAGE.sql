-- 16.07.2012 twie: Umstellung auf Tabelle mit historisierter Auflage

-- 12.10.2022 twie: SPEC0167837 sek_kz von 3 auf 3 geändert

-- 21.07.2017 twie: SPEC0025359 neues Security Kennzeichen für Sicherheitsfilter

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_f_geku_wmd_auflage (wmd_austraeger_gebiet_uid, dat,
mandant_id, kdc_fg, mzk_fg, wmd_fg, sec_kz, auflage) AS SELECT a17.wmd_austraeger_gebiet_uid,
 a17.dat,
 a18.mandant_id,
 0 AS kdc_fg,
 0 AS mzk_fg,
 1 AS wmd_fg,
 3 AS sec_kz,
 a17.auflage
FROM kfl_production_dbp_view.v_geku_ges_vertriebsltg AS a11
 INNER JOIN kfl_production_dbp_view.v_geku_vertriebsbuero AS a12 ON a11.country_uid = a12.country_uid
 INNER JOIN kfl_production_dbp_view.v_geku_gebietsleiter AS a13 ON a12.vertriebsbuero_uid = a13.vertriebsbuero_uid
 INNER JOIN kfl_production_dbp_view.v_geku_verteilgebiet AS a14 ON a13.gebietsleiter_uid = a14.gebietsleiter_uid
 INNER JOIN kfl_production_dbp_view.v_geku_gebiets_bereich AS a15 ON a14.verteilgebiet_uid = a15.verteilgebiet_uid
 INNER JOIN kfl_production_dbp_view.v_geku_austr_gebiet AS a16 ON a15.gebiets_bereich_uid = a16.gebiets_bereich_uid
 INNER JOIN kfl_production_dbp_view.v_geku_austr_gebiet_tag AS a17 ON a16.wmd_austraeger_gebiet_uid = a17.wmd_austraeger_gebiet_uid
  
 INNER JOIN kfl_production_dbp_view.v_mandant AS a18 ON a11.land_iso = CASE
   WHEN a18.mandant_kbez = 'D'
   THEN 'DE'
   ELSE a18.mandant_kbez
   END;