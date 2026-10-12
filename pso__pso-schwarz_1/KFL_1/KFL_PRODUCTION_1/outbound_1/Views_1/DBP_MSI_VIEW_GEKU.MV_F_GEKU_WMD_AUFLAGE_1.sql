CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_f_geku_wmd_auflage_1 (wmd_austraeger_gebiet_uid, dat,
mandant_id, kdc_fg, mzk_fg, wmd_fg, sec_kz, auflage) AS SELECT A17.wmd_austraeger_gebiet_uid,
 A17.dat,
 A18.mandant_id,
 0 AS kdc_fg,
 0 AS mzk_fg,
 1 AS wmd_fg,
 3 AS sec_kz,
 A17.auflage
FROM kfl_production_dbp_view.v_geku_ges_vertriebsltg_1 AS A11
 INNER JOIN kfl_production_dbp_view.v_geku_vertriebsbuero_1 AS A12 ON A11.country_uid = A12.country_uid
 INNER JOIN kfl_production_dbp_view.v_geku_gebietsleiter_1 AS A13 ON A12.vertriebsbuero_uid = A13.vertriebsbuero_uid
 INNER JOIN kfl_production_dbp_view.v_geku_verteilgebiet_1 AS A14 ON A13.gebietsleiter_uid = A14.gebietsleiter_uid
 INNER JOIN kfl_production_dbp_view.v_geku_gebiets_bereich_1 AS A15 ON A14.verteilgebiet_uid = A15.verteilgebiet_uid
 INNER JOIN kfl_production_dbp_view.v_geku_austr_gebiet_1 AS A16 ON A15.gebiets_bereich_uid = A16.gebiets_bereich_uid
 INNER JOIN kfl_production_dbp_view.v_geku_austr_gebiet_tag_1 AS A17 ON A16.wmd_austraeger_gebiet_uid = A17.wmd_austraeger_gebiet_uid
  
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS A18 ON A11.land_iso = CASE
   WHEN A18.mandant_kbez = 'D'
   THEN 'DE'
   ELSE A18.mandant_kbez
   END;