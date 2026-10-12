-- 2022-08-01, AP0125093, SPEC0155049, dknop, correction of filter

-- 2022-07-14, AP0125093, SPEC0155049, dknop, filtering out EWM lagernummer

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_art_lagernummer_zu_per_1 (mandant_id, lagernummer_id,
art_id, wup_id, nb_id, lager_bereich_kz, einlager_typ_kz, lager_einheiten_typ, kapazitaet_verbrauch, dat) AS
-- EWM Lagernummern ausfiltern! - Erweiterung mit jedem Go-Live erforderlich!
 SELECT V01.mandant_id,
 V01.lagernummer_id,
 V01.art_id,
 V01.wup_id,
 V01.nb_id,
 V01.lager_bereich_kz,
 V01.einlager_typ_kz,
 V01.lager_einheiten_typ,
 V01.kapazitaet_verbrauch,
 V02.dat
FROM kfl_production_dbp_view.v_art_lagernummer_zu_per_1 AS V01
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   nb_id,
   lagernummer_id,
   MIN(dat) AS dat
  FROM kfl_production_dbp_msi_data.ts_lagerort_ewm_dat_1
  GROUP BY mandant_id,
   lagernummer_id,
   wup_id,
   nb_id) AS v03 ON V01.mandant_id = v03.mandant_id AND V01.wup_id = v03.wup_id AND V01.nb_id = v03.nb_id AND V01.lagernummer_id
    = v03.lagernummer_id
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS V02 ON V02.dat BETWEEN V01.dat_von AND V01.dat_bis AND V02.dat < COALESCE(v03
    .dat, DATE('9999-12-31'))
WHERE v03.mandant_id IS NULL
 OR V02.dat < v03.dat;