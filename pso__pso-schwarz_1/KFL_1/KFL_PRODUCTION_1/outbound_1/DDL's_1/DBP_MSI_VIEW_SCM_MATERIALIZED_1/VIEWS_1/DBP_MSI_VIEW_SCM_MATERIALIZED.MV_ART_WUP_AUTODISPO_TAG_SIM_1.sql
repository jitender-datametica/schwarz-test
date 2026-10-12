CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_art_wup_autodispo_tag_sim_1 (mandant_id, wup_id,
wup_id_fleischwerk, nb_id, nb_id_vz, art_id, dat, kjwo, menge_einh_id, anz_dif_mult, anz_dif_add, anz_dif_abs,
udf_prognose_menge_gesteuert, prog_mit_dif_mult, prog_mit_dif_add, prog_mit_dif_abs, verkaufslistung_fg,
we_bearbeitungszeit, planlieferzeit, nullbestand_fg, sa_af_fg, kdis, fur_prognose_menge_sim_tmp, fur_prognose_menge_sim
, menge_we_geplant, display_art_id, komponentenmenge) AS SELECT F.mandant_id,
 V05.aktuell_wup_id AS wup_id,
 F.wup_id AS wup_id_fleischwerk,
 F.nb_id_kunde AS nb_id,
 F.nb_id_lieferant AS nb_id_vz,
 F.art_id,
 F.dat,
 T.kjwo,
 F.menge_einh_id,
 DIF.anz_dif_mult,
 DIF.anz_dif_add,
 DIF.anz_dif_abs,
 F.udf_prognose_menge_gesteuert,
  F.udf_prognose_menge_gesteuert * DIF.dif_mult AS prog_mit_dif_mult,
  F.udf_prognose_menge_gesteuert + DIF.dif_add * F.egalisierungsfaktor AS prog_mit_dif_add,
  DIF.dif_abs * F.egalisierungsfaktor AS prog_mit_dif_abs,
 F.verkaufslistung_fg,
 COALESCE(F.we_bearbeitungszeit, -1) AS we_bearbeitungszeit,
 COALESCE(F.planlieferzeit, -1) AS planlieferzeit,
 COALESCE(F.nullbestand_fg, -1) AS nullbestand_fg,
 F.sa_af_fg,
 F.kdis,
  CASE
  WHEN DIF.dif_abs IS NOT NULL
  THEN DIF.dif_abs * F.egalisierungsfaktor
  WHEN DIF.dif_mult IS NOT NULL AND DIF.dif_add IS NOT NULL
  THEN F.udf_prognose_menge_gesteuert * DIF.dif_mult + DIF.dif_add * F.egalisierungsfaktor
  WHEN DIF.dif_mult IS NOT NULL
  THEN F.udf_prognose_menge_gesteuert * DIF.dif_mult
  WHEN DIF.dif_add IS NOT NULL
  THEN CAST(F.udf_prognose_menge_gesteuert + DIF.dif_add * F.egalisierungsfaktor AS FLOAT64)
  ELSE CAST(F.udf_prognose_menge_gesteuert AS FLOAT64)
  END AS fur_prognose_menge_sim_tmp,
  CASE
  WHEN CASE
    WHEN DIF.dif_abs IS NOT NULL
    THEN DIF.dif_abs * F.egalisierungsfaktor
    WHEN DIF.dif_mult IS NOT NULL AND DIF.dif_add IS NOT NULL
    THEN F.udf_prognose_menge_gesteuert * DIF.dif_mult + DIF.dif_add * F.egalisierungsfaktor
    WHEN DIF.dif_mult IS NOT NULL
    THEN F.udf_prognose_menge_gesteuert * DIF.dif_mult
    WHEN DIF.dif_add IS NOT NULL
    THEN CAST(F.udf_prognose_menge_gesteuert + DIF.dif_add * F.egalisierungsfaktor AS FLOAT64)
    ELSE CAST(F.udf_prognose_menge_gesteuert AS FLOAT64)
    END < 0
  THEN 0.00
  ELSE CASE
   WHEN DIF.dif_abs IS NOT NULL
   THEN DIF.dif_abs * F.egalisierungsfaktor
   WHEN DIF.dif_mult IS NOT NULL AND DIF.dif_add IS NOT NULL
   THEN F.udf_prognose_menge_gesteuert * DIF.dif_mult + DIF.dif_add * F.egalisierungsfaktor
   WHEN DIF.dif_mult IS NOT NULL
   THEN F.udf_prognose_menge_gesteuert * DIF.dif_mult
   WHEN DIF.dif_add IS NOT NULL
   THEN CAST(F.udf_prognose_menge_gesteuert + DIF.dif_add * F.egalisierungsfaktor AS FLOAT64)
   ELSE CAST(F.udf_prognose_menge_gesteuert AS FLOAT64)
   END
  END AS fur_prognose_menge_sim,
 F.menge_we_geplant,
 F.display_art_id,
 F.komponentenmenge
FROM kfl_production_dbp_view.v_art_wup_autodispo_flw_tag_1 AS F
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON F.mandant_id = V05.mandant_id AND F.kunde_id = V05.wup_id AND F.nb_id_kunde
    = V05.nb_id
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS T ON F.dat = T.dat
 LEFT JOIN kfl_production_dbp_msi_view_scm_materialized.mv_art_wup_autodispo_tag_dif_bme_1 AS DIF ON F.mandant_id = DIF.mandant_id
      AND F.kunde_id = DIF.kunde_id AND F.art_id = DIF.art_id AND F.dat = DIF.dat;