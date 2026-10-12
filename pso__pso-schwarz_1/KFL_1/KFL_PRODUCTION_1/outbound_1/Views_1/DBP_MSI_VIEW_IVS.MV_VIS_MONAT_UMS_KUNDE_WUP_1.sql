-- k.kaiser 20150310 - neu für Bericht 1.200, KL-Kunde uns Umsatz SBW
 -- aktuelles GJ

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_vis_monat_ums_kunde_wup_1 (mandant_id, wrg_id, wrg_typ_id,
wup_id, immo_objekt_id, gj, gj_vj_kz, kjmo_buchungsschluss, akt_buchungs_schluss, ums_netto, anz_kunde) AS
-- Vorjahres GJ
 -- Vorvorjahres GJ
 -- Vorvorjvorahres GJ
 SELECT ALLES.mandant_id,
 ALLES.wrg_id,
 ALLES.wrg_typ_id,
 ALLES.wup_id,
 IMMO.immo_objekt_id,
 ALLES.gj,
 ALLES.gj_vj_kz,
 ALLES.kjmo_buchungsschluss,
 0 AS akt_buchungs_schluss,
 SUM(ALLES.ums_netto) AS ums_netto,
 SUM(ALLES.anz_kunde) AS anz_kunde
FROM (((SELECT VIS.mandant_id,
      VIS.wrg_id,
      MWT.wrg_typ_id,
      VIS.wup_id,
      MO.gj,
      0 AS gj_vj_kz,
      MO.kjmo_buchungsschluss,
      0 AS akt_buchungs_schluss,
      SUM(VIS.ums_netto) AS ums_netto,
      SUM(VIS.anz_kunde) AS anz_kunde
     FROM kfl_production_dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_1 AS VIS
      INNER JOIN kfl_production_dbp_msi_view_ivs.mv_monat_3gj_1 AS MO ON VIS.kjmo BETWEEN MO.kjmo_min AND MO.gjmo_max AND
        MO.gj_vj_kz = 0
      INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS MWT ON VIS.mandant_id = MWT.mandant_id AND VIS.wrg_id =
        MWT.wrg_id
     GROUP BY VIS.mandant_id,
      VIS.wrg_id,
      MWT.wrg_typ_id,
      VIS.wup_id,
      MO.gj,
      MO.gj_vj_kz,
      MO.kjmo_buchungsschluss,
      akt_buchungs_schluss
     UNION DISTINCT
     SELECT VIS.mandant_id,
      VIS.wrg_id,
      MWT.wrg_typ_id,
      VIS.wup_id,
       MO.gj - 1 AS gj,
      - 1 AS gj_vj_kz,
      MO.kjmo_buchungsschluss,
      0 AS akt_buchungs_schluss,
      SUM(VIS.ums_netto_kvj) AS ums_netto,
      SUM(VIS.anz_kunde_kvj) AS anz_kunde
     FROM kfl_production_dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_1 AS VIS
      INNER JOIN kfl_production_dbp_msi_view_ivs.mv_monat_3gj_1 AS MO ON VIS.kjmo BETWEEN MO.kjmo_min AND MO.kjmo_max AND
        MO.gj_vj_kz = 0
      INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS MWT ON VIS.mandant_id = MWT.mandant_id AND VIS.wrg_id =
        MWT.wrg_id
     GROUP BY VIS.mandant_id,
      VIS.wrg_id,
      MWT.wrg_typ_id,
      VIS.wup_id,
      MO.gj,
      MO.gj_vj_kz,
      MO.kjmo_buchungsschluss,
      akt_buchungs_schluss)
    UNION DISTINCT
    SELECT VIS.mandant_id,
     VIS.wrg_id,
     MWT.wrg_typ_id,
     VIS.wup_id,
      MO.gj - 2 AS gj,
     - 2 AS gj_vj_kz,
     MO.kjmo_buchungsschluss,
     0 AS akt_buchungs_schluss,
     SUM(VIS.ums_netto_kvvj) AS ums_netto,
     SUM(VIS.anz_kunde_kvvj) AS anz_kunde
    FROM kfl_production_dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_1 AS VIS
     INNER JOIN kfl_production_dbp_msi_view_ivs.mv_monat_3gj_1 AS MO ON VIS.kjmo BETWEEN MO.kjmo_min AND MO.kjmo_max AND
       MO.gj_vj_kz = 0
     INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS MWT ON VIS.mandant_id = MWT.mandant_id AND VIS.wrg_id =
       MWT.wrg_id
    GROUP BY VIS.mandant_id,
     VIS.wrg_id,
     MWT.wrg_typ_id,
     VIS.wup_id,
     MO.gj,
     MO.gj_vj_kz,
     MO.kjmo_buchungsschluss,
     akt_buchungs_schluss)
   UNION DISTINCT
   SELECT VIS.mandant_id,
    VIS.wrg_id,
    MWT.wrg_typ_id,
    VIS.wup_id,
     MO.gj - 2 AS gj,
    - 3 AS gj_vj_kz,
    MO.kjmo_buchungsschluss,
    0 AS akt_buchungs_schluss,
    SUM(VIS.ums_netto_kvvj) AS ums_netto,
    SUM(VIS.anz_kunde_kvvj) AS anz_kunde
   FROM kfl_production_dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_1 AS VIS
    INNER JOIN kfl_production_dbp_msi_view_ivs.mv_monat_3gj_1 AS MO ON VIS.kjmo BETWEEN MO.kjmo_min AND MO.kjmo_max AND MO
      .gj_vj_kz = - 1
    INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS MWT ON VIS.mandant_id = MWT.mandant_id AND VIS.wrg_id =
      MWT.wrg_id
   GROUP BY VIS.mandant_id,
    VIS.wrg_id,
    MWT.wrg_typ_id,
    VIS.wup_id,
    MO.gj,
    MO.gj_vj_kz,
    MO.kjmo_buchungsschluss,
    akt_buchungs_schluss) AS ALLES
 LEFT JOIN (SELECT mandant_id,
   immo_objekt_id,
   immo_objekt_bez
  FROM kfl_production_dbp_view.v_ivs_immo_objekt_per_1 AS IMMO
  WHERE dat_bis = DATE '9999-12-31'
  GROUP BY mandant_id,
   immo_objekt_id,
   immo_objekt_bez) AS IMMO ON ALLES.mandant_id = IMMO.mandant_id AND ALLES.wup_id = IMMO.immo_objekt_bez
 INNER JOIN kfl_production_dbp_msi_view_ivs.mv_monat_1 AS M ON ALLES.kjmo_buchungsschluss = M.kjmo AND M.akt_buchungs_schluss
    = 0
GROUP BY ALLES.mandant_id,
 IMMO.immo_objekt_id,
 ALLES.wup_id,
 ALLES.wrg_id,
 ALLES.wrg_typ_id,
 ALLES.gj,
 ALLES.gj_vj_kz,
 ALLES.kjmo_buchungsschluss,
 M.akt_buchungs_schluss;