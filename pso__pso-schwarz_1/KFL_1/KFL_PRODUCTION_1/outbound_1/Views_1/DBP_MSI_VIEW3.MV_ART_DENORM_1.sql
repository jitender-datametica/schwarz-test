-- 2024-05-14, dknop, initial
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_art_denorm_1 (mandant_id, art_id,
kl_art_id, art_bez_de, wausm, wg_id, wg_bez, hwg_id, hwg_bez, owg_id, owg_bez, abt_id, abt_bez, sortimentsbereich_id,
sortimentsbereich_bez_de, sortimentsgruppe_id, sortimentsgruppe_bez_de) AS -- mara_1
 -- makt_1
 -- art_wg_zu_per_1
 SELECT
 MARA.mandant_id,
 MARA.art_id,
 MARA.kl_art_id,
 MAKT.art_bez AS art_bez_de,
 MAW1.ausg_menge_einh_id AS wausm,
 WG_SPR.wg_id,
 WG_SPR.wg_bez,
 HWG_PER.hwg_id,
 HWG_SPR.hwg_bez,
 OWG_SPR.owg_id,
 OWG_SPR.owg_bez,
 ABT_SPR.abt_id,
 ABT_SPR.abt_bez,
 COALESCE(SCM.wg_hierarchie_mutter_id, - 1) AS sortimentsbereich_id,
 SCM_SPR.wg_hierarchie_bez AS sortimentsbereich_bez_de,
 COALESCE(SCMG.wg_hierarchie_mutter_id, - 1) AS sortimentsgruppe_id,
 SCMG_SPR.wg_hierarchie_bez AS sortimentsgruppe_bez_de
FROM kfl_production_dbp_data.art_1 AS MARA_1
 INNER JOIN kfl_production_dbp_data.art_spr_zu_1 AS MAKT_1 ON MARA.mandant_id = MAKT.mandant_id AND MARA.art_id = MAKT.art_id
     AND MAKT.spr_id = 22
 INNER JOIN kfl_production_dbp_data.art_vorschlagswert_per_1 AS MAW1_1 ON MARA.mandant_id = MAW1.mandant_id AND MARA.art_id
    = MAW1.art_id AND MAW1.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_data.art_wg_zu_per_1 AS WG ON MARA.mandant_id = WG.mandant_id AND MARA.art_id = WG.art_id
   AND WG.dat_bis = DATE '9999-12-31' AND WG.arthiertyp_id = 2 -- wg_per_1

 INNER JOIN kfl_production_dbp_data.wg_per_1 AS WG_PER_1 ON WG.mandant_id = WG_PER.mandant_id AND WG.wg_id = WG_PER.wg_id
   AND WG_PER.dat_bis = DATE '9999-12-31' AND WG_PER.arthiertyp_id = 2 -- wg_per_1

 INNER JOIN kfl_production_dbp_data.wg_spr_zu_1 AS WG_SPR ON WG.mandant_id = WG_SPR.mandant_id AND WG.wg_id = WG_SPR.wg_id
     AND WG_SPR.spr_id = 22 -- owg_per_1

 INNER JOIN kfl_production_dbp_data.owg_per_1 AS OWG_PER_1 ON MARA.mandant_id = OWG_PER.mandant_id AND WG_PER.owg_id =
     OWG_PER.owg_id AND OWG_PER.dat_bis = DATE '9999-12-31' AND OWG_PER.arthiertyp_id = 2 -- hwg_per_1

 INNER JOIN kfl_production_dbp_data.hwg_per_1 AS HWG_PER_1 ON MARA.mandant_id = HWG_PER.mandant_id AND OWG_PER.hwg_id =
     HWG_PER.hwg_id AND HWG_PER.dat_bis = DATE '9999-12-31' AND HWG_PER.arthiertyp_id = 2 -- owg_spr

 INNER JOIN kfl_production_dbp_data.owg_spr_zu_1 AS OWG_SPR ON OWG_PER.owg_id = OWG_SPR.owg_id AND MARA.mandant_id =
    OWG_SPR.mandant_id AND OWG_SPR.spr_id = 22 -- owg_spr

 INNER JOIN kfl_production_dbp_data.hwg_spr_zu_1 AS HWG_SPR ON MARA.mandant_id = HWG_SPR.mandant_id AND OWG_PER.hwg_id =
    HWG_SPR.hwg_id AND HWG_SPR.spr_id = 22 -- abt_spr

 INNER JOIN kfl_production_dbp_data.abt_spr_zu_1 AS ABT_SPR ON HWG_PER.mandant_id = ABT_SPR.mandant_id AND HWG_PER.abt_id
    = ABT_SPR.abt_id AND ABT_SPR.spr_id = 22
 LEFT JOIN kfl_production_dbp_view.v_wg_hierarchie_zu_per_1 AS SCM ON HWG_PER.mandant_id = SCM.mandant_id AND HWG_PER.hwg_id
     = SCM.wg_hierarchie_id AND SCM.arthiertyp_id = 13
 LEFT JOIN kfl_production_dbp_view.v_wg_hierarchie_spr_zu_1 AS SCM_SPR ON SCM.mandant_id = SCM_SPR.mandant_id AND SCM.wg_hierarchie_mutter_id
      = SCM_SPR.wg_hierarchie_id AND SCM_SPR.arthiertyp_id = 13 AND SCM_SPR.spr_id = 22
 LEFT JOIN kfl_production_dbp_view.v_wg_hierarchie_zu_per_1 AS SCMG ON WG_PER.mandant_id = SCMG.mandant_id AND WG_PER.wg_id
     = SCMG.wg_hierarchie_id AND SCMG.arthiertyp_id = 11
 LEFT JOIN kfl_production_dbp_view.v_wg_hierarchie_spr_zu_1 AS SCMG_SPR ON SCMG.mandant_id = SCMG_SPR.mandant_id AND SCMG
     .wg_hierarchie_mutter_id = SCMG_SPR.wg_hierarchie_id AND SCMG_SPR.arthiertyp_id = 11 AND SCMG_SPR.spr_id = 22;