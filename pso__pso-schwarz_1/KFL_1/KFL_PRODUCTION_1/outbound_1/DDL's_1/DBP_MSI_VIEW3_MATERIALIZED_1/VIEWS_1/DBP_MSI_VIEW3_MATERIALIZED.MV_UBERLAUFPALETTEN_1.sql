-- 20221007,AP0092670, SPEC0142675, dknop, adding condition for hu_anzahl hu_status_id = '0050', adding wg_verkett_hier_id

-- AP0092670, SPEC0142675, dknop,  correcting logic for hu_anzahl, lief_beleg_orig_id, kkp_type

-- 20221007,AP0092670, SPEC0142675, dknop,updating logic for kkp_type - adding '0'

-- 20221004,AP0092670, SPEC0142675, dknop, adding join to dbp_msi_data.ts_lagerort_ewm_dat_1 and filter on dat_lief_soll instead of hardcoded DC/Dates

-- AP0092670, SPEC0142675, dknop, changing condition from KFL_PRODUCTION.lb_split.split_vorgang_id is not null to lb_split.split_vorgang_id<>''

-- 20221128,AP0092670, SPEC0142675, dknop, correcting anzahl_hu

-- 20221122,AP0092670, SPEC0142675, dknop,exchange dat_lief_soll with dat_erstellung in joins

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_uberlaufpaletten_1 (wup_id, mandant_id, nb_id,
lagernummer_id, dat_lief_soll, lief_pal_typ_id, lief_typ_id, werbeware_id, wg_verkett_lief, wg_verkett_hier_id,
lief_beleg_id, lief_beleg_orig_id, hu_anzahl, count_pal_typ, vz_wup_id, vz_nb_id, kkp_type) AS
/* Damit das Attribut Verteilzentrum auch ein nb_id bekommt */
-- ON   CASE WHEN lb_split.split_vorgang_id ='' THEN COALESCE (COALESCE(lb_split2.lief_beleg_split_id ,lb_split.lief_beleg_split_id), bl.lief_beleg_id) ELSE bl.lief_beleg_id END=hu_anzl.lief_beleg_id

-- EWM Lagernummern ausfiltern! - Erweiterung mit jedem Go-Live erforderlich!

-- and bl.wup_id=6905  and bl.dat_lief_soll='2022-09-03';
 SELECT BL.wup_id,
 BL.mandant_id,
 BL.nb_id,
 BL.lagernummer_id,
 BL.dat_lief_soll,
 BL.lief_pal_typ_id,
 BL.lief_typ_id,
 BL.werbeware_id,
 BL.wg_verkett_lief,
  CASE
  WHEN BL.wg_verkett_fg = 1
  THEN CAST(WGVERPER.wg_verkett_hier_id AS STRING)
  ELSE ''
  END AS wg_verkett_hier_id,
 BL.lief_beleg_id,
  CASE
  WHEN LB_SPLIT.split_vorgang_id = ''
  THEN COALESCE(COALESCE(LB_SPLIT2.lief_beleg_split_id, LB_SPLIT.lief_beleg_split_id), BL.lief_beleg_id)
  ELSE BL.lief_beleg_id
  END AS lief_beleg_orig_id,
 SUM(hu_anzl.hu_anzahl) OVER (PARTITION BY BL.mandant_id, CASE
     WHEN LB_SPLIT.split_vorgang_id = ''
     THEN COALESCE(COALESCE(LB_SPLIT2.lief_beleg_split_id, LB_SPLIT.lief_beleg_split_id), BL.lief_beleg_id)
     ELSE BL.lief_beleg_id
     END, BL.kj RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS hu_anzahl,
 COUNT(BL.lief_pal_typ_id) OVER (PARTITION BY BL.mandant_id, CASE
     WHEN LB_SPLIT.split_vorgang_id = ''
     THEN COALESCE(COALESCE(LB_SPLIT2.lief_beleg_split_id, LB_SPLIT.lief_beleg_split_id), BL.lief_beleg_id)
     ELSE BL.lief_beleg_id
     END, BL.kj RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS count_pal_typ,
 LAG_NUM.wup_id AS vz_wup_id,
 -111 AS vz_nb_id,
  CASE
  WHEN BL.wg_verkett_fg = 0
  THEN CASE
   WHEN WGVER.klapp_pal_fg = 1 AND CASE
      WHEN WGVER.palettengroesse_einh_id = 'CM'
      THEN WGVER.palettenvolumen / 1000
      ELSE WGVER.palettenvolumen
      END > 800
   THEN '2'
   WHEN WGVER.klapp_pal_fg = 0 AND CASE
      WHEN WGVER.palettengroesse_einh_id = 'CM'
      THEN WGVER.palettenvolumen / 1000
      ELSE WGVER.palettenvolumen
      END > 800
   THEN '0'
   ELSE '1'
   END
  ELSE CASE
   WHEN WUPWGVERHIE.klapp_pal_fg = 1 AND CASE
      WHEN WUPWGVERHIE.palettengroesse_einh_id = 'CM'
      THEN WUPWGVERHIE.palettenvolumen / 1000
      ELSE WUPWGVERHIE.palettenvolumen
      END > 800
   THEN '2'
   WHEN WUPWGVERHIE.klapp_pal_fg = 0 AND CASE
      WHEN WUPWGVERHIE.palettengroesse_einh_id = 'CM'
      THEN WUPWGVERHIE.palettenvolumen / 1000
      ELSE WUPWGVERHIE.palettenvolumen
      END > 800
   THEN '0'
   ELSE '1'
   END
  END AS kkp_type
FROM kfl_production_dbp_view.v_besch_lief_1 AS BL
 LEFT JOIN kfl_production_dbp_view.v_lief_belegfluss_split_1 AS LB_SPLIT ON BL.mandant_id = LB_SPLIT.mandant_id AND BL.lief_beleg_id
     = LB_SPLIT.lief_beleg_id AND LB_SPLIT.split_vorgang_id = ''
 LEFT JOIN kfl_production_dbp_view.v_lief_belegfluss_split_1 AS LB_SPLIT2 ON LB_SPLIT.mandant_id = LB_SPLIT2.mandant_id
   AND LB_SPLIT.lief_beleg_split_id = LB_SPLIT2.lief_beleg_id AND LB_SPLIT2.split_vorgang_id = ''
 LEFT JOIN (SELECT lief_beleg_id,
   mandant_id,
   kj_lief_beleg,
   COUNT(DISTINCT handling_unit_id_ext) AS hu_anzahl
  FROM kfl_production_dbp_view.v_handling_unit_1
  WHERE hu_status_id = '0050'
  GROUP BY mandant_id,
   lief_beleg_id,
   kj_lief_beleg) AS hu_anzl ON BL.lief_beleg_id = hu_anzl.lief_beleg_id AND BL.mandant_id = hu_anzl.mandant_id AND BL.kj
    = hu_anzl.kj_lief_beleg
 LEFT JOIN kfl_production_dbp_view.v_l_lagernummer_1 AS LAG_NUM ON BL.mandant_id = LAG_NUM.mandant_id AND BL.lagernummer_id
    = LAG_NUM.lagernummer_id
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   nb_id,
   lagernummer_id,
   MIN(dat) AS dat
  FROM kfl_production_dbp_msi_data.ts_lagerort_ewm_dat_1
  GROUP BY mandant_id,
   lagernummer_id,
   wup_id,
   nb_id) AS l_ewm ON BL.mandant_id = l_ewm.mandant_id AND LAG_NUM.wup_id = l_ewm.wup_id AND LAG_NUM.nb_id = l_ewm.nb_id
     AND BL.lagernummer_id = l_ewm.lagernummer_id
 LEFT JOIN kfl_production_dbp_view.v_wg_verkettung_hierarchie_zu_per_1 AS WGVERPER ON LAG_NUM.wup_id = WGVERPER.wup_id AND
      BL.mandant_id = WGVERPER.mandant_id AND BL.wg_verkett_lief = WGVERPER.wg_verkett_id AND COALESCE(BL.dat_erstellung
     , BL.dat_lief_soll) BETWEEN WGVERPER.dat_von AND WGVERPER.dat_bis AND BL.wg_verkett_fg = 1
 LEFT JOIN kfl_production_dbp_view.v_wg_verkettung_per_1 AS WGVER ON LAG_NUM.wup_id = WGVER.wup_id AND BL.mandant_id =
      WGVER.mandant_id AND BL.wg_verkett_lief = WGVER.wg_verkett_id AND COALESCE(BL.dat_erstellung, BL.dat_lief_soll)
    BETWEEN WGVER.dat_von AND WGVER.dat_bis AND BL.wg_verkett_fg = 0
 LEFT JOIN kfl_production_dbp_view.v_wup_wg_verkettung_hierarchie_per_1 AS WUPWGVERHIE ON LAG_NUM.wup_id = WUPWGVERHIE.wup_id
       AND BL.mandant_id = WUPWGVERHIE.mandant_id AND WGVERPER.wg_verkett_hier_id = WUPWGVERHIE.wg_verkett_hier_id AND
    COALESCE(BL.dat_erstellung, BL.dat_lief_soll) BETWEEN WUPWGVERHIE.dat_von AND WUPWGVERHIE.dat_bis AND BL.wg_verkett_fg
    = 1
WHERE l_ewm.mandant_id IS NULL
 OR BL.dat_lief_soll < l_ewm.dat;