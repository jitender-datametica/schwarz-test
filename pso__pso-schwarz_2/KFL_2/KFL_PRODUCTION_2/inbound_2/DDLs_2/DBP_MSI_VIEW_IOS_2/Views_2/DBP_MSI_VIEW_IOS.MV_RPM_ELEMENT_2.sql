CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_RPM_ELEMENT_2 AS
   -- STAMMDATEN - RPM Element/Immobilie angereichert
   -- 20151223 ssch0611 : Review im Rahmen 0533 BVV
   -- 20161202 kkaiser: 2 neue Felder besitzverhaeltnis_id, massnahmentyp_id
   -- 20241121 alavih  : Anpassung Filialumgliederung

   SELECT
   rpm.land_id,
   rpm.rpm_hierarchie_id, 
   rpm.rpm_immobilie_id, 
   rpm.dat_von, 
   rpm.dat_bis, 
   rpm.projekt_id   AS projekt_nr, 
   cpr.projekt_id, 
   rpm.wrg_id, 
   rpm.dat_start_prognose, 
   rpm.dat_start_plan, 
   rpm.dat_start, 
   rpm.dat_ende_prognose, 
   rpm.dat_ende_plan, 
   rpm.dat_ende, 
   rpm.rpm_status_id,
   rpm.rpm_projekt_typ_id, 
   1 AS rpm_projektart_id, 
   rpm.rpm_phase_id, 
   rpsz.rpm_phase_bez,
   rpm.testmarkt_fg, 
   COALESCE(rpm.expansionauftrag_nr, '')   AS expansionauftrag_nr, 
   COALESCE(rpm.eigenentw, '')             AS eigenentw, 
   COALESCE(rpm.angebot_nr, '')        AS angebot_nr, 
   COALESCE(rpm.auftraggeber_name,'')      AS auftraggeber_name,
   COALESCE(rpm.objekt_planer_name,'')     AS objekt_planer_name, 
   COALESCE(rpm.gj_umbvorschl, 0)          AS gj_umbvorschl, 
   COALESCE(rpm.bereich_name, '')          AS bereich_name,
   rpm.mandant_id,
   CASE WHEN rpm.wup_id = 0 AND rip.wup_id <> 0 THEN 1 ELSE 0 END::BYTEINT    AS IMMO_FG,
   COALESCE(CASE WHEN IMMO_FG = 1 THEN rip.nb_id ELSE rpm.nb_id END, -1)       AS nb_id,
   --CASE WHEN IMMO_FG = 1 THEN rip.wup_id ELSE rpm.wup_id END                    AS wup_id,
   COALESCE(v01.aktuell_wup_id,0) AS wup_id, --auf die aktuelle Filiale
   COALESCE(rpm.wup_standort, rip.wup_standort, ' ')                           AS wup_standort, 
   COALESCE(rip.strasse,rpm.strasse, ' ')                                      AS strasse, 
   COALESCE(rpm.plz, rip.plz, ' ')                                             AS plz, 
   COALESCE(cpr.markt_typ_ea, '')                                              AS markt_typ_ea, 
   COALESCE(rfasz_i.rpm_feld_auspr_bez, rfasz.rpm_feld_auspr_bez,' ')          AS eigentum_bez, 
   COALESCE(rpm.besitzverhaeltnis_id, ' -1') AS besitzverhaeltnis_id, 
   COALESCE(rpm.massnahmentyp_id, -1)     AS massnahmentyp_id, 
   rpm.rpm_projekt_typ_id AS massnahme_id

   FROM dbp_view.v_rpm_element_per_2  rpm

   JOIN dbp_view.v_rpm_phase_spr_zu_2 rpsz
   ON  rpsz.rpm_phase_id = rpm.rpm_phase_id AND rpsz.rpm_projekt_typ_id = rpm.rpm_projekt_typ_id
   AND rpsz.spr_id = 22
   LEFT OUTER JOIN dbp_view.v_cpr_projekt_per_2  cpr -- Nicht alle Elemente haben cProjekt zugeordnet

   ON cpr.cpr_ext_id = rpm.projekt_id
   AND cpr.dat_bis = '9999-12-31'

   LEFT OUTER JOIN dbp_view.v_rpm_immobilie_per_2 rip -- Nicht alle Elemente haben Immo zugeordnet
   ON  rip.rpm_hierarchie_id = rpm.rpm_immobilie_id

   AND rip.dat_bis = '9999-12-31'
   LEFT OUTER JOIN dbp_view.v_rpm_feld_zu_per_2  rfzp_i
   ON  rfzp_i.rpm_hierarchie_id = rip.rpm_hierarchie_id
   AND rfzp_i.rpm_tab_id = 2    -- INM_INITIATIVE
   AND rfzp_i.rpm_feld_id = 8    -- ZPPM_BESITZVERH Besitzverhaeltnis
   AND rfzp_i.dat_bis = '9999-12-31'
   LEFT OUTER JOIN dbp_view.v_rpm_feld_auspr_spr_zu_2  rfasz_i
   ON  rfasz_i.rpm_feld_auspr_id = rfzp_i.rpm_feld_auspr_id
   AND rfasz_i.rpm_tab_id = 2    -- INM_INITIATIVE
   AND rfasz_i.rpm_feld_id = 8   -- ZPPM_BESITZVERH Besitzverhaeltnis
   AND rfasz_i.spr_id = 22
   LEFT OUTER JOIN dbp_view.v_rpm_feld_zu_per_2 rfzp
   ON  rfzp.rpm_hierarchie_id = rpm.rpm_hierarchie_id
   AND rfzp.rpm_tab_id = 1      -- '/RPM/ITEM_D'
   AND rfzp.rpm_feld_id = 8     -- ZPPM_BESITZVERH Besitzverhaeltnis
   AND rfzp.dat_bis = '9999-12-31'
   LEFT OUTER JOIN dbp_view.v_rpm_feld_auspr_spr_zu_2 rfasz
   ON rfasz.rpm_feld_auspr_id = rfzp.rpm_feld_auspr_id
   AND rfasz.rpm_tab_id = 1      -- '/RPM/ITEM_D'
   AND rfasz.rpm_feld_id = 8     -- ZPPM_BESITZVERH Besitzverhaeltnis
   AND rfasz.spr_id = 22
   LEFT JOIN dbp_view.v_wup_2 AS v01
   ON (CASE WHEN IMMO_FG = 1 THEN rip.wup_id ELSE rpm.wup_id END) = v01.wup_id AND rpm.mandant_id = v01.mandant_id -- Join um aktuelle Filialen zu erhalten

   WHERE rpm.dat_bis = '9999-12-31'
   AND rpm.rpm_status_id <> -1
   
   ;