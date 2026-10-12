CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_uberlaufpaletten (mandant_id, lagernummer_id,
artikelsortiment_id, dat_lief_soll, lief_pal_typ_id, lief_typ_id, werbeware_id, wg_verkett_lief, wg_verkett_hier_id,
lief_beleg_id, lief_beleg_orig_id, hu_anzahl, pal_typ_anzahl, kkp_type) AS SELECT t3.mandant_id,
 t3.lagernummer_id,
  CASE
  WHEN t3.lagersortiment_id = '5'
  THEN '1'
  ELSE t3.lagersortiment_id
  END AS artikelsortiment_id,
 t3.dat_lief_soll,
 t3.lief_pal_typ_id,
 t3.lief_typ_id,
 t3.werbeware_id,
 t3.wg_verkett_lief,
 t3.wg_verkett_hier_id,
 t3.lief_beleg_id,
 t3.lief_beleg_orig_id,
 SUM(t3.hu_anzahl) OVER (PARTITION BY CAST(t3.mandant_id AS STRING), t3.lief_beleg_orig_id RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS hu_anzahl_0,
 COUNT(t3.lief_pal_typ_id) OVER (PARTITION BY CAST(t3.mandant_id AS STRING), t3.lief_beleg_orig_id RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS count_pal_typ,
 t3.kkp_type
FROM (SELECT HU_WA.mandant_id,
   HU_WA.lagernummer_id,
   HU_WA.lagersortiment_id,
   HU_WA.dat_lief_soll,
   HU_WA.lief_pal_typ_id,
   HU_WA.lief_typ_id,
   HU_WA.werbeware_id,
   HU_WA.wg_verkett_lief,
   HU_WA.lief_beleg_id,
    CASE
    WHEN LB_SPLIT.split_vorgang_id = ''
    THEN COALESCE(LB_SPLIT.lief_beleg_split_id, HU_WA.lief_beleg_id)
    ELSE HU_WA.lief_beleg_id
    END AS lief_beleg_orig_id,
   hu_anzl.hu_anzahl,
    CASE
    WHEN HU_WA.wg_verkett_fg = 0
    THEN CASE
     WHEN WGVERPER.klapp_pal_fg = 1 AND CASE
        WHEN WGVERPER.palettengroesse_einh_id = 'CM'
        THEN WGVERPER.palettenvolumen / 1000
        ELSE WGVERPER.palettenvolumen
        END > 800
     THEN '2'
     WHEN WGVERPER.klapp_pal_fg = 0 AND CASE
        WHEN WGVERPER.palettengroesse_einh_id = 'CM'
        THEN WGVERPER.palettenvolumen / 1000
        ELSE WGVERPER.palettenvolumen
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
    END AS kkp_type,
   MAX(CASE
     WHEN HU_WA.wg_verkett_fg = 1
     THEN SUBSTR(CAST(WGVER.wg_verkett_hier_id AS STRING), 1, 4)
     ELSE ''
     END) AS wg_verkett_hier_id
  FROM kfl_production_dbp_view.v_besch_lief_wa_hu_sum AS HU_WA
   LEFT JOIN kfl_production_dbp_view.v_lief_belegfluss_split AS LB_SPLIT ON HU_WA.mandant_id = LB_SPLIT.mandant_id AND
      HU_WA.lief_beleg_id = LB_SPLIT.lief_beleg_id AND LB_SPLIT.split_vorgang_id =
     ' \n\nLEFT JOIN KFL_PRODUCTION.dbp_view.v_lief_belegfluss_split lb_split2\nON  lb_split.mandant_id=lb_split2.mandant_id\nAND lb_split.lief_beleg_split_id=lb_split2.lief_beleg_id\nAND lb_split2.split_vorgang_id ='
     
   INNER JOIN (SELECT lief_beleg_id,
     mandant_id,
     COUNT(DISTINCT handling_unit_id_ext) AS hu_anzahl
    FROM kfl_production_dbp_view.v_handling_unit
    WHERE hu_status_id = '0020'
    GROUP BY lief_beleg_id,
     mandant_id) AS hu_anzl ON HU_WA.mandant_id = hu_anzl.mandant_id AND HU_WA.lief_beleg_id = hu_anzl.lief_beleg_id
   LEFT JOIN kfl_production_dbp_view.v_wg_verkettung_per AS WGVERPER ON HU_WA.wup_id = WGVERPER.wup_id AND HU_WA.mandant_id
         = WGVERPER.mandant_id AND HU_WA.wg_verkett_lief = WGVERPER.wg_verkett_id AND COALESCE(HU_WA.dat_erstellung,
       HU_WA.dat_lief_soll) BETWEEN WGVERPER.dat_von AND WGVERPER.dat_bis AND HU_WA.wg_verkett_fg = 0
   LEFT JOIN kfl_production_dbp_view.v_wg_verkettung_hierarchie_zu_per AS WGVER ON HU_WA.wup_id = WGVER.wup_id AND HU_WA
        .mandant_id = WGVER.mandant_id AND HU_WA.wg_verkett_lief = WGVER.wg_verkett_id AND COALESCE(HU_WA.dat_erstellung
       , HU_WA.dat_lief_soll) BETWEEN WGVER.dat_von AND WGVER.dat_bis AND HU_WA.wg_verkett_fg = 1
   LEFT JOIN kfl_production_dbp_view.v_wup_wg_verkettung_hierarchie_per AS WUPWGVERHIE ON WGVER.wup_id = WUPWGVERHIE.wup_id
         AND WGVER.mandant_id = WUPWGVERHIE.mandant_id AND WGVER.wg_verkett_hier_id = WUPWGVERHIE.wg_verkett_hier_id AND
      COALESCE(HU_WA.dat_erstellung, HU_WA.dat_lief_soll) BETWEEN WUPWGVERHIE.dat_von AND WUPWGVERHIE.dat_bis AND HU_WA
     .wg_verkett_fg = 1
  GROUP BY HU_WA.mandant_id,
   HU_WA.lagernummer_id,
   HU_WA.lagersortiment_id,
   HU_WA.dat_lief_soll,
   HU_WA.lief_pal_typ_id,
   HU_WA.lief_typ_id,
   HU_WA.werbeware_id,
   HU_WA.wg_verkett_lief,
   HU_WA.lief_beleg_id,
   lief_beleg_orig_id,
   hu_anzl.hu_anzahl,
   kkp_type) AS t3;