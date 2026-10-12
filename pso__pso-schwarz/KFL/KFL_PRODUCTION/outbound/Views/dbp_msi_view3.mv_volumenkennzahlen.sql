CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_volumenkennzahlen (handling_unit_id_ext, handling_unit_id,
hu_status_id, mandant_id_kunde, kunde_id, traegertyp_bez, hu_aufgepackt, lief_beleg_id, kj_lief_beleg, wup_id,
lagernummer_id, mandant_id, nb_id, dat_lief_soll, lief_typ_id, lief_pal_typ_id, werbeware_id, wg_verkett_lief,
wg_verkett_fg, wg_verkett_hier_id, palettenvolumen_wgrvk, palettenvolumen_hierarchie, menge_handling_kolli_orig,
netto_vol_ladung, theoretisches_sap_volumen, brtvol_ladung_gedeckelt) AS SELECT HU.handling_unit_id_ext,
 HU.handling_unit_id,
 HU.hu_status_id,
 BL.mandant_id_kunde,
 W.aktuell_wup_id AS kunde_id,
  CASE
  WHEN HU.versandeinheit_id NOT IN (1, - 1)
  THEN 'AUFGEPACKT'
  WHEN HU.versandeinheit_id = - 1
  THEN 'NORMAL'
  WHEN HU.versandeinheit_id = 1
  THEN 'TRÄGER'
  ELSE NULL
  END AS traegertyp_bez,
  CASE
  WHEN HU.versandeinheit_id NOT IN (1, - 1)
  THEN 1
  ELSE 0
  END AS hu_aufgepackt,
 HU.lief_beleg_id,
 HU.kj_lief_beleg,
 HU.wup_id,
 HU.lagernummer_id,
 HU.mandant_id,
 HU.nb_id,
 BL.dat_lief_soll,
 BL.lief_typ_id,
 BL.lief_pal_typ_id,
 BL.werbeware_id,
 BL.wg_verkett_lief,
 BL.wg_verkett_fg,
  CASE
  WHEN BL.wg_verkett_fg = 1
  THEN CAST(WGVER.wg_verkett_hier_id AS STRING)
  ELSE ''
  END AS wg_verkett_hier_id,
  CASE
  WHEN VOLWARERK.klapp_pal_fg = 1 AND CASE
      WHEN VOLWARERK.palettengroesse_einh_id = 'CM'
      THEN VOLWARERK.palettenvolumen / 1000
      ELSE VOLWARERK.palettenvolumen
      END > 800 AND BL.lief_pal_typ_id = '9'
  THEN VOLWARERK.palettenvolumen / 2
  ELSE VOLWARERK.palettenvolumen
  END AS palettenvolumen_wgrvk,
  CASE
  WHEN VOLWARERKHIE.klapp_pal_fg = 1 AND CASE
      WHEN VOLWARERKHIE.palettengroesse_einh_id = 'CM'
      THEN VOLWARERKHIE.palettenvolumen / 1000
      ELSE VOLWARERKHIE.palettenvolumen
      END > 800 AND BL.lief_pal_typ_id = '9'
  THEN VOLWARERKHIE.palettenvolumen / 2
  ELSE VOLWARERKHIE.palettenvolumen
  END AS palettenvolumen_hierarchie,
 HU.menge_handling_kolli_orig,
  CASE
  WHEN HU.vol_ladung > 2304
  THEN 2304
  ELSE HU.vol_ladung
  END AS netto_vol_ladung,
  CASE
  WHEN BL.lief_pal_typ_id = '6' AND VOLWARERK.max_volumen_aufpackpal / 1000 <> 0
  THEN VOLWARERK.max_volumen_aufpackpal / 1000
  WHEN BL.wg_verkett_fg = 1
  THEN CASE
   WHEN VOLWARERKHIE.palettengroesse_einh_id = 'CM'
   THEN CASE
     WHEN VOLWARERKHIE.klapp_pal_fg = 1 AND CASE
         WHEN VOLWARERKHIE.palettengroesse_einh_id = 'CM'
         THEN VOLWARERKHIE.palettenvolumen / 1000
         ELSE VOLWARERKHIE.palettenvolumen
         END > 800 AND BL.lief_pal_typ_id = '9'
     THEN VOLWARERKHIE.palettenvolumen / 2
     ELSE VOLWARERKHIE.palettenvolumen
     END / 1000
   ELSE CASE
    WHEN VOLWARERKHIE.klapp_pal_fg = 1 AND CASE
        WHEN VOLWARERKHIE.palettengroesse_einh_id = 'CM'
        THEN VOLWARERKHIE.palettenvolumen / 1000
        ELSE VOLWARERKHIE.palettenvolumen
        END > 800 AND BL.lief_pal_typ_id = '9'
    THEN VOLWARERKHIE.palettenvolumen / 2
    ELSE VOLWARERKHIE.palettenvolumen
    END
   END
  ELSE CASE
   WHEN VOLWARERK.palettengroesse_einh_id = 'CM'
   THEN CASE
     WHEN VOLWARERK.klapp_pal_fg = 1 AND CASE
         WHEN VOLWARERK.palettengroesse_einh_id = 'CM'
         THEN VOLWARERK.palettenvolumen / 1000
         ELSE VOLWARERK.palettenvolumen
         END > 800 AND BL.lief_pal_typ_id = '9'
     THEN VOLWARERK.palettenvolumen / 2
     ELSE VOLWARERK.palettenvolumen
     END / 1000
   ELSE CASE
    WHEN VOLWARERK.klapp_pal_fg = 1 AND CASE
        WHEN VOLWARERK.palettengroesse_einh_id = 'CM'
        THEN VOLWARERK.palettenvolumen / 1000
        ELSE VOLWARERK.palettenvolumen
        END > 800 AND BL.lief_pal_typ_id = '9'
    THEN VOLWARERK.palettenvolumen / 2
    ELSE VOLWARERK.palettenvolumen
    END
   END
  END AS theoretisches_sap_volumen,
 HU.brtvol_ladung_gedeckelt
FROM kfl_production_dbp_view.v_handling_unit AS HU
 INNER JOIN kfl_production_dbp_view.v_besch_lief AS BL ON HU.lief_beleg_id = BL.lief_beleg_id AND HU.kj_lief_beleg = BL
    .kj AND HU.mandant_id = BL.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_wup AS W ON W.mandant_id = CASE
     WHEN BL.mandant_id_kunde IS NULL OR BL.mandant_id_kunde = 0
     THEN BL.mandant_id
     ELSE BL.mandant_id_kunde
     END AND W.wup_id = CASE
     WHEN ROUND(SAFE_CAST(BL.kunde_id AS BIGNUMERIC), 0) = 0
     THEN NULL
     ELSE ROUND(SAFE_CAST(BL.kunde_id AS BIGNUMERIC), 0)
     END AND (W.nb_id IN (2, 0, - 111) AND W.wup_id > 0 OR W.nb_id = - 1 AND W.wup_id = 0)
 LEFT JOIN kfl_production_dbp_view.v_wg_verkettung_hierarchie_zu_per AS WGVER ON HU.wup_id = WGVER.wup_id AND HU.mandant_id
      = WGVER.mandant_id AND BL.wg_verkett_lief = WGVER.wg_verkett_id AND BL.dat_lief_soll BETWEEN WGVER.dat_von AND
   WGVER.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_wg_verkettung_per AS VOLWARERK ON HU.wup_id = VOLWARERK.wup_id AND HU.mandant_id =
     VOLWARERK.mandant_id AND BL.wg_verkett_lief = VOLWARERK.wg_verkett_id AND BL.dat_lief_soll BETWEEN VOLWARERK.dat_von
   AND VOLWARERK.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_wup_wg_verkettung_hierarchie_per AS VOLWARERKHIE ON HU.wup_id = VOLWARERKHIE.wup_id
      AND HU.mandant_id = VOLWARERKHIE.mandant_id AND WGVER.wg_verkett_hier_id = VOLWARERKHIE.wg_verkett_hier_id AND BL
   .dat_lief_soll BETWEEN VOLWARERKHIE.dat_von AND VOLWARERKHIE.dat_bis;