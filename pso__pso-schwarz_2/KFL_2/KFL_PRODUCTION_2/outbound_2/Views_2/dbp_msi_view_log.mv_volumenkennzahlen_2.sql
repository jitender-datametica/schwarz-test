CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_volumenkennzahlen_2 (lagernummer_id, lagersortiment_id,
artikelsortiment_id, mandant_id, handling_unit_id_ext, dat_lief_soll, lief_typ_id, lief_pal_typ_id, werbeware_id,
wg_verkett_lief, wg_verkett_fg, hu_aufgepackt, wg_verkett_hier_id, palettenvolumen_wgrvk, palettenvolumen_hierarchie,
theoretisches_sap_volumen_hier, theoretisches_sap_volumen_wgrvk, lief_pal_typ_dwh_id, theoretisches_sap_volumen,
menge_lief_ist_kolli_hu, ntvol_ladung_gedeckelt, ntvol_hu_gedeckelt_oa, brtvol_ladung_gedeckelt, brtvol_hu_gedeckelt_oa
, hu_relevant_fg, kunde_id, mandant_id_kunde, lief_beleg_id) AS SELECT BL.lagernummer_id,
 BL.lagersortiment_id,
  CASE
  WHEN LEFT(RIGHT(BL.versandstelle_id, 2), 1) = '5'
  THEN '1'
  WHEN LEFT(RIGHT(BL.versandstelle_id, 2), 1) = '7'
  THEN '2'
  ELSE LEFT(RIGHT(BL.versandstelle_id, 2), 1)
  END AS artikelsortiment_id,
 BL.mandant_id,
 COALESCE(BL.handling_unit_id_ext, '-1') AS handling_unit_id_ext,
 BL.dat_lief_soll,
 BL.lief_typ_id,
 BL.lief_pal_typ_id,
 BL.werbeware_id,
 BL.wg_verkett_lief,
 BL.wg_verkett_fg,
  CASE
  WHEN BL.handling_unit_id_parent <> 0
  THEN 1
  ELSE 0
  END AS hu_aufgepackt,
  CASE
  WHEN BL.wg_verkett_fg = 1
  THEN SUBSTR(CAST(WGVER.wg_verkett_hier_id AS STRING), 1, 4)
  ELSE ''
  END AS wg_verkett_hier_id,
  CASE
  WHEN WGVERPER.klapp_pal_fg = 1 AND CASE
      WHEN WGVERPER.palettengroesse_einh_id = 'CM'
      THEN WGVERPER.palettenvolumen / 1000
      ELSE WGVERPER.palettenvolumen
      END > 800 AND BL.lief_pal_typ_id = '9'
  THEN WGVERPER.palettenvolumen / 2
  ELSE WGVERPER.palettenvolumen
  END AS palettenvolumen_wgrvk,
  CASE
  WHEN WUPWGVERHIE.klapp_pal_fg = 1 AND CASE
      WHEN WUPWGVERHIE.palettengroesse_einh_id = 'CM'
      THEN WUPWGVERHIE.palettenvolumen / 1000
      ELSE WUPWGVERHIE.palettenvolumen
      END > 800 AND BL.lief_pal_typ_id = '9'
  THEN WUPWGVERHIE.palettenvolumen / 2
  ELSE WUPWGVERHIE.palettenvolumen
  END AS palettenvolumen_hierarchie,
  CASE
  WHEN WUPWGVERHIE.palettengroesse_einh_id = 'CM'
  THEN CASE
    WHEN WUPWGVERHIE.klapp_pal_fg = 1 AND CASE
        WHEN WUPWGVERHIE.palettengroesse_einh_id = 'CM'
        THEN WUPWGVERHIE.palettenvolumen / 1000
        ELSE WUPWGVERHIE.palettenvolumen
        END > 800 AND BL.lief_pal_typ_id = '9'
    THEN WUPWGVERHIE.palettenvolumen / 2
    ELSE WUPWGVERHIE.palettenvolumen
    END / 1000
  ELSE CASE
   WHEN WUPWGVERHIE.klapp_pal_fg = 1 AND CASE
       WHEN WUPWGVERHIE.palettengroesse_einh_id = 'CM'
       THEN WUPWGVERHIE.palettenvolumen / 1000
       ELSE WUPWGVERHIE.palettenvolumen
       END > 800 AND BL.lief_pal_typ_id = '9'
   THEN WUPWGVERHIE.palettenvolumen / 2
   ELSE WUPWGVERHIE.palettenvolumen
   END
  END AS theoretisches_sap_volumen_hier,
  CASE
  WHEN WGVERPER.palettengroesse_einh_id = 'CM'
  THEN CASE
    WHEN WGVERPER.klapp_pal_fg = 1 AND CASE
        WHEN WGVERPER.palettengroesse_einh_id = 'CM'
        THEN WGVERPER.palettenvolumen / 1000
        ELSE WGVERPER.palettenvolumen
        END > 800 AND BL.lief_pal_typ_id = '9'
    THEN WGVERPER.palettenvolumen / 2
    ELSE WGVERPER.palettenvolumen
    END / 1000
  ELSE CASE
   WHEN WGVERPER.klapp_pal_fg = 1 AND CASE
       WHEN WGVERPER.palettengroesse_einh_id = 'CM'
       THEN WGVERPER.palettenvolumen / 1000
       ELSE WGVERPER.palettenvolumen
       END > 800 AND BL.lief_pal_typ_id = '9'
   THEN WGVERPER.palettenvolumen / 2
   ELSE WGVERPER.palettenvolumen
   END
  END AS theoretisches_sap_volumen_wgrvk,
 BL.lief_pal_typ_dwh_id,
  CASE
  WHEN BL.lief_pal_typ_dwh_id = 'J4'
  THEN 1728
  WHEN BL.lief_pal_typ_dwh_id = 'J9'
  THEN 756
  WHEN BL.lief_pal_typ_id = '6' AND WGVERPER.max_volumen_aufpackpal / 1000 <> 0
  THEN WGVERPER.max_volumen_aufpackpal / 1000
  ELSE CASE
   WHEN BL.wg_verkett_fg = 1 AND BL.lief_pal_typ_dwh_id NOT IN ('J4', 'J9')
   THEN CASE
    WHEN WUPWGVERHIE.palettengroesse_einh_id = 'CM'
    THEN CASE
      WHEN WUPWGVERHIE.klapp_pal_fg = 1 AND CASE
          WHEN WUPWGVERHIE.palettengroesse_einh_id = 'CM'
          THEN WUPWGVERHIE.palettenvolumen / 1000
          ELSE WUPWGVERHIE.palettenvolumen
          END > 800 AND BL.lief_pal_typ_id = '9'
      THEN WUPWGVERHIE.palettenvolumen / 2
      ELSE WUPWGVERHIE.palettenvolumen
      END / 1000
    ELSE CASE
     WHEN WUPWGVERHIE.klapp_pal_fg = 1 AND CASE
         WHEN WUPWGVERHIE.palettengroesse_einh_id = 'CM'
         THEN WUPWGVERHIE.palettenvolumen / 1000
         ELSE WUPWGVERHIE.palettenvolumen
         END > 800 AND BL.lief_pal_typ_id = '9'
     THEN WUPWGVERHIE.palettenvolumen / 2
     ELSE WUPWGVERHIE.palettenvolumen
     END
    END
   ELSE CASE
    WHEN WGVERPER.palettengroesse_einh_id = 'CM'
    THEN CASE
      WHEN WGVERPER.klapp_pal_fg = 1 AND CASE
          WHEN WGVERPER.palettengroesse_einh_id = 'CM'
          THEN WGVERPER.palettenvolumen / 1000
          ELSE WGVERPER.palettenvolumen
          END > 800 AND BL.lief_pal_typ_id = '9'
      THEN WGVERPER.palettenvolumen / 2
      ELSE WGVERPER.palettenvolumen
      END / 1000
    ELSE CASE
     WHEN WGVERPER.klapp_pal_fg = 1 AND CASE
         WHEN WGVERPER.palettengroesse_einh_id = 'CM'
         THEN WGVERPER.palettenvolumen / 1000
         ELSE WGVERPER.palettenvolumen
         END > 800 AND BL.lief_pal_typ_id = '9'
     THEN WGVERPER.palettenvolumen / 2
     ELSE WGVERPER.palettenvolumen
     END
    END
   END
  END AS theoretisches_sap_volumen,
 BL.menge_lief_ist_kolli_hu,
 BL.ntvol_ladung_gedeckelt,
 BL.ntvol_hu_gedeckelt_oa,
 BL.brtvol_ladung_gedeckelt,
 BL.brtvol_hu_gedeckelt_oa,
 BL.hu_relevant_fg,
 W.aktuell_wup_id AS kunde_id,
 BL.mandant_id_kunde,
 BL.lief_beleg_id
FROM kfl_production_dbp_view.v_besch_lief_wa_hu_sum_2 AS BL
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS W ON W.mandant_id = CASE
     WHEN BL.mandant_id_kunde IS NULL OR BL.mandant_id_kunde = 0
     THEN BL.mandant_id
     ELSE BL.mandant_id_kunde
     END AND BL.kunde_id = W.wup_id AND (W.nb_id IN (2, 0, - 111) AND W.wup_id > 0 OR W.nb_id = - 1 AND W.wup_id = 0)
 LEFT JOIN kfl_production_dbp_view.v_wg_verkettung_hierarchie_zu_per_2 AS WGVER ON BL.wup_id = WGVER.wup_id AND BL.mandant_id
      = WGVER.mandant_id AND BL.wg_verkett_lief = WGVER.wg_verkett_id AND BL.dat_lief_soll BETWEEN WGVER.dat_von AND
   WGVER.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_wup_wg_verkettung_hierarchie_per_2 AS WUPWGVERHIE ON WGVER.wup_id = WUPWGVERHIE.wup_id
      AND WGVER.mandant_id = WUPWGVERHIE.mandant_id AND WGVER.wg_verkett_hier_id = WUPWGVERHIE.wg_verkett_hier_id AND BL
   .dat_lief_soll BETWEEN WUPWGVERHIE.dat_von AND WUPWGVERHIE.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_wg_verkettung_per_2 AS WGVERPER ON BL.wup_id = WGVERPER.wup_id AND BL.mandant_id =
     WGVERPER.mandant_id AND BL.wg_verkett_lief = WGVERPER.wg_verkett_id AND BL.dat_lief_soll BETWEEN WGVERPER.dat_von
   AND WGVERPER.dat_bis;