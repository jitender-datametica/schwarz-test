-- 20161202 kkaiser: 2 neue Felder besitzverhaeltnis_id, massnahmentyp_id

-- 20151223 ssch0611 : Review im Rahmen 0533 BVV
 -- 20241121 alavih  : Anpassung Filialumgliederung

-- STAMMDATEN - RPM Element/Immobilie angereichert

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_rpm_element_2 AS
-- CASE WHEN IMMO_FG = 1 THEN rip.wup_id ELSE rpm.wup_id END                    AS wup_id,
 -- auf die aktuelle Filiale

-- Nicht alle Elemente haben Immo zugeordnet
 SELECT RPM.land_id,
 RPM.rpm_hierarchie_id,
 RPM.rpm_immobilie_id,
 RPM.dat_von,
 RPM.dat_bis,
 RPM.projekt_id AS projekt_nr,
 CPR.projekt_id,
 RPM.wrg_id,
 RPM.dat_start_prognose,
 RPM.dat_start_plan,
 RPM.dat_start,
 RPM.dat_ende_prognose,
 RPM.dat_ende_plan,
 RPM.dat_ende,
 RPM.rpm_status_id,
 RPM.rpm_projekt_typ_id,
 1 AS rpm_projektart_id,
 RPM.rpm_phase_id,
 RPSZ.rpm_phase_bez,
 RPM.testmarkt_fg,
 COALESCE(RPM.expansionauftrag_nr, '') AS expansionauftrag_nr,
 COALESCE(RPM.eigenentw, '') AS eigenentw,
 COALESCE(RPM.angebot_nr, '') AS angebot_nr,
 COALESCE(RPM.auftraggeber_name, '') AS auftraggeber_name,
 COALESCE(RPM.objekt_planer_name, '') AS objekt_planer_name,
 COALESCE(RPM.gj_umbvorschl, 0) AS gj_umbvorschl,
 COALESCE(RPM.bereich_name, '') AS bereich_name,
 RPM.mandant_id,
 CAST(CASE
   WHEN RPM.wup_id = 0 AND RIP.wup_id <> 0
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS immo_fg,
 COALESCE(CASE
   WHEN CAST(CASE
      WHEN RPM.wup_id = 0 AND RIP.wup_id <> 0
      THEN 1
      ELSE 0
      END AS BIGNUMERIC) = 1
   THEN RIP.nb_id
   ELSE RPM.nb_id
   END, - 1) AS nb_id,
 COALESCE(V01.aktuell_wup_id, 0) AS wup_id,
 COALESCE(RPM.wup_standort, RIP.wup_standort, ' ') AS wup_standort,
 COALESCE(RIP.strasse, RPM.strasse, ' ') AS strasse,
 COALESCE(RPM.plz, RIP.plz, ' ') AS plz,
 COALESCE(CPR.markt_typ_ea, '') AS markt_typ_ea,
 COALESCE(RFASZ_I.rpm_feld_auspr_bez, RFASZ.rpm_feld_auspr_bez, ' ') AS eigentum_bez,
 COALESCE(RPM.besitzverhaeltnis_id, ' -1') AS besitzverhaeltnis_id,
 COALESCE(RPM.massnahmentyp_id, - 1) AS massnahmentyp_id,
 RPM.rpm_projekt_typ_id AS massnahme_id
FROM kfl_production_dbp_view.v_rpm_element_per_2 AS RPM
 INNER JOIN kfl_production_dbp_view.v_rpm_phase_spr_zu_2 AS RPSZ ON RPM.rpm_phase_id = RPSZ.rpm_phase_id AND RPM.rpm_projekt_typ_id
     = RPSZ.rpm_projekt_typ_id AND RPSZ.spr_id = 22 -- Nicht alle Elemente haben cProjekt zugeordnet

 LEFT JOIN kfl_production_dbp_view.v_cpr_projekt_per_2 AS CPR ON RPM.projekt_id = CPR.cpr_ext_id AND CPR.dat_bis =
   DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_rpm_immobilie_per_2 AS RIP ON RPM.rpm_immobilie_id = RIP.rpm_hierarchie_id AND RIP.dat_bis
    = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_rpm_feld_zu_per_2 AS RFZP_I ON RIP.rpm_hierarchie_id = RFZP_I.rpm_hierarchie_id AND
     RFZP_I.rpm_tab_id = 2 -- INM_INITIATIVE
 AND RFZP_I.rpm_feld_id = 8 -- ZPPM_BESITZVERH Besitzverhaeltnis
 AND
   RFZP_I.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_rpm_feld_auspr_spr_zu_2 AS RFASZ_I ON RFZP_I.rpm_feld_auspr_id = RFASZ_I.rpm_feld_auspr_id
      AND RFASZ_I.rpm_tab_id = 2 -- INM_INITIATIVE
 AND RFASZ_I.rpm_feld_id = 8 -- ZPPM_BESITZVERH Besitzverhaeltnis

  AND RFASZ_I.spr_id = 22
 LEFT JOIN kfl_production_dbp_view.v_rpm_feld_zu_per_2 AS RFZP ON RPM.rpm_hierarchie_id = RFZP.rpm_hierarchie_id AND RFZP
     .rpm_tab_id = 1 -- '/RPM/ITEM_D'
 AND RFZP.rpm_feld_id = 8 -- ZPPM_BESITZVERH Besitzverhaeltnis
 AND RFZP.dat_bis =
   DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_rpm_feld_auspr_spr_zu_2 AS RFASZ ON RFZP.rpm_feld_auspr_id = RFASZ.rpm_feld_auspr_id
    AND RFASZ.rpm_tab_id = 1 -- '/RPM/ITEM_D'
 AND RFASZ.rpm_feld_id = 8 -- ZPPM_BESITZVERH Besitzverhaeltnis
 AND RFASZ
   .spr_id = 22
 LEFT JOIN kfl_production_dbp_view.v_wup_2 AS V01 ON CASE
    WHEN CAST(CASE
       WHEN RPM.wup_id = 0 AND RIP.wup_id <> 0
       THEN 1
       ELSE 0
       END AS BIGNUMERIC) = 1
    THEN RIP.wup_id
    ELSE RPM.wup_id
    END = V01.wup_id AND RPM.mandant_id = V01.mandant_id -- CROSS JOIN um aktuelle Filialen zu erhalten

WHERE RPM.dat_bis = DATE '9999-12-31'
 AND RPM.rpm_status_id <> - 1;