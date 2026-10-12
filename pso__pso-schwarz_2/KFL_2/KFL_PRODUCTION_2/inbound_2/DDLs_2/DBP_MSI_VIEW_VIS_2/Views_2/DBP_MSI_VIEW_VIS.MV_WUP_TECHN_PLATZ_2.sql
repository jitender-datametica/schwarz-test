CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUP_TECHN_PLATZ_2(
      MANDANT_ID,
      NB_ID,
      WUP_ID,
      TECHN_PLATZ_ID,
      LAND_ID,
      MARKTYP_KATEGORIE_ID,
      GINFO_MARKT_TYP,
      GINFO_MARKT_TYP_BEZ,
      GINFO_KONZ_TYP_KZ,
      GINFO_KONZ_TYP_BEZ,
      GINFO_BAUFORM_ID,
      GINFO_BAUFORM_BEZ,
      BAUJAHR,
      UEBERNAHME_VON,
      TANKSTELLE_VORH_FG,
      ANZ_KASSEN,
      ANZ_KASSEN_GETRAENKEMARKT,
      ANZ_ZUSATZKASSEN,
      KASSEN_HARDWARE,
      KASSEN_SOFTWARE,
      KASSENTISCH_SITUATION,
      EINKAUFSWAGEN_FABRIKAT,
      EINKAUFSWAGEN_TYP,
      EINKAUFSWAGEN_GRIFF,
      EINKAUFSWAGEN_ROLLEN,
      KBL_NL_BEZ,
      TP_BETREUER_KBL_NAME,
      TP_ARBEITSRECHT_NAME,
      ANZ_PARKPL_OLD,
      PARKDECK_FG,
      ANZ_PARKPL,
      ANZ_PARKPL_BEHIND,
      ANZ_PARKPL_ELTERN_KIND,
      PARKPL_EBEN_KZ,
      PARKPL_DACH_KZ,
      PARKPL_DACH_MG_KZ,
      PARKHAUS_KZ,
      TIEFGARAGE_EG_KZ,
      TIEFGARAGE_MG_KZ,
      SBW_FLAECHE,
      VK_FLAECHE,
      KONZ_FLAECHE,
      ALLG_FLAECHE,
      NEBEN_FLAECHE,
      BETRIEB_FLAECHE,
      AUSSEN_FLAECHE,
      OBJEKT_FLAECHE,
      ANZ_FRISCHE_BEDIEN_BEREICHE,
      ANZ_TISCHE_OBST_GEMUESE,
      ANZ_ACHSEN_FOOD,
      ANZ_ACHSEN_NONFOOD,
      GETRAENKEMARKT_FG,
      NACHTANLIEF_FG,
      BAECKER_KZ,
      BAECKER_BEZ,
      FL_SBW,
      FL_VKF_KASSE,
      FL_VKF_INFO,
      FL_VKF_ROLL,
      FL_VKF_GETRAENKE,
      FL_VKF_SBW,
      FL_KOF,
      FL_KOFE,
      FL_SNF,
      FL_TF,
      FL_VF,
      FL_ANF,
      FL_UBF,
      FL_BBF
) AS
   -- FAKT Stammdaten Techn. Platz + G-Info pro Filiale (Techn. Platz)
   -- Verknüpfung Filiale (wup_2) mit Techn. Platz (Stammdaten) denorm. + G-Info (Flaechen) gruppiert
   -- 2009-08-03 Initial
   -- 2009KW37 Update Felder + Datum
   -- 2011KW28 Erweiterung Felder
   -- AL 07.10.2011 Ergänzung um die Quellfelder Bedienkonzept ...
   -- AL 17.10.2011 Spallten , tpl01.tp_ol_vermietung , tpl01.tp_betreuer_kbl_name hinzugefügt, bertieb_flaeche, anz_parkpl
   -- AL 05.12.2011 getraenke_markt_fg hinzugefügt
   -- MR 06.12.2011 parkdeck_fg,kassentisch_situation,nachtanlief_fg hinzugefügt
   -- MR 16.12.2011 einkaufswagen_fabrikat,einkaufswagen_griff,einkaufswagen_rollen,tankstelle_vorh_fg hinzugefügt
   -- AL 30.01.2012 marktyp_kategorie_id Ermittlung hinzugefügt
   -- MR 13.03.2012  ol_vermietung, betreuer_kbl_name anpassen
   -- AL 15.03.2012 Achsenanzahl Ermittlung entsprechend neuer Warenhierarchie angepasst
   -- AL 27.03.2012 Nachtanlieferung mit -1 als Default Wert vorbelegt
   -- AL 18.06.2012 uebername_von Spalte aufgenommen
   -- 2012KW46 Review : Flaechen ueberarbeitet, Bedienkonzept Techn. Platz entfernt
   -- 20140721 Erweiterung : Parkplaetze, Parkdecks > neue Datenquelle
   -- 20151130 Erweiterung : Personenzuordnung Arbeitsrechtler
   -- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]

   SELECT
      wp.mandant_id
      , wp.nb_id
      , wp.wup_id
      , tpl.techn_platz_id
      , tpl.land_id
      , CASE WHEN ginfo_markt_typ <> '' THEN ginfo_markt_typ ELSE '-' END || '/' ||
         CASE WHEN ginfo_konz_typ_kz = 'F' THEN ginfo_konz_typ_kz ELSE '-' END || '/' ||
         CASE WHEN ginfo_bauform_id > -1 THEN TRIM(ginfo_bauform_id) ELSE '-' END
         AS marktyp_kategorie_id
      , ginfo_markt_typ
      , ginfo_markt_typ_bez
      , ginfo_konz_typ_kz
      , ginfo_konz_typ_bez
      , ginfo_bauform_id
      , ginfo_bauform_bez
      , baujahr
      , COALESCE (uebernahme_von,'')                                              AS uebernahme_von
      , COALESCE (tankstelle_vorh_fg, 0)                                          AS tankstelle_vorh_fg
      , anz_kassen
      , anz_kassen_getraenkemarkt
      , anz_zusatzkassen
      , kassen_hardware
      , kassen_software
      , kassentisch_situation
      , einkaufswagen_fabrikat
      , einkaufswagen_typ
      , einkaufswagen_griff
      , einkaufswagen_rollen
      , kbl_nl_bez
      , tp_betreuer_kbl_name
      , tp_arbeitsrecht_name  -- NEU
      , ZEROIFNULL(anz_ppl)                                                       AS anz_parkpl_old  -- GINFO (alte version)
      , COALESCE (parkdeck_fg, -1)                                                AS parkdeck_fg     -- GINFO (alte version)
      , COALESCE (anz_parkpl, anz_ppl, 0)                                         AS anz_parkpl      -- BACKUP (inkl. alte version)
      , COALESCE (anz_parkpl_behind, -1)                                          AS anz_parkpl_behind
      , COALESCE (anz_parkpl_eltern_kind, -1)                                     AS anz_parkpl_eltern_kind
      , COALESCE (parkpl_eben_kz, -1)                                             AS parkpl_eben_kz
      , COALESCE (parkpl_dach_kz, -1)                                             AS parkpl_dach_kz
      , COALESCE (parkpl_dach_mg_kz, -1)                                          AS parkpl_dach_mg_kz
      , COALESCE (parkhaus_kz, -1)                                                AS parkhaus_kz
      , COALESCE (tiefgarage_eg_kz, -1)                                           AS tiefgarage_eg_kz
      , COALESCE (tiefgarage_mg_kz, -1)                                           AS tiefgarage_mg_kz
      , (fl_sbw)                                                                  AS sbw_flaeche
      , (fl_vkf_kasse + fl_vkf_info + fl_vkf_roll+ fl_vkf_getraenke + fl_vkf_sbw) AS vk_flaeche
      , (fl_kof + fl_kofe)                                                        AS konz_flaeche
      , (fl_vf)                                                                   AS allg_flaeche
      , (fl_snf + fl_tf)                                                          AS neben_flaeche
      , (vk_flaeche + konz_flaeche + allg_flaeche + neben_flaeche)                AS betrieb_flaeche
      , (fl_anf + fl_ubf + fl_bbf)                                                AS aussen_flaeche
      , (betrieb_flaeche + aussen_flaeche)                                        AS objekt_flaeche
      , (achs_01 + achs_02 + achs_03 + achs_04 + achs_05)                         AS anz_frische_bedien_bereiche
      , (achs_04)                                                                 AS anz_tische_obst_gemuese
      , (achs_06)                                                                 AS anz_achsen_food
      , (achs_07)                                                                 AS anz_achsen_nonfood
      , COALESCE (fg_getraenke, -1)                                               AS getraenkemarkt_fg
      , COALESCE (fg_nacht, -1)                                                   AS nachtanlief_fg
      , COALESCE (kz_baecker, 0)                                                  AS baecker_kz
      , CASE
         WHEN baecker_kz = 1 THEN 'Discountbäckerei'
         WHEN baecker_kz = 2 THEN 'Frischebäcker'
         WHEN baecker_kz = 3 THEN 'Backshop Typ 3'
         WHEN baecker_kz = 4 THEN 'Frischebäcker Bedienung'
         WHEN baecker_kz = 0 THEN '-'
         ELSE '' END  AS baecker_bez
      , fl_sbw
      , fl_vkf_kasse
      , fl_vkf_info
      , fl_vkf_roll
      , fl_vkf_getraenke
      , fl_vkf_sbw
      , fl_kof
      , fl_kofe
      , fl_snf
      , fl_tf
      , fl_vf
      , fl_anf
      , fl_ubf
      , fl_bbf
   FROM
   ( -- Marktstamm
      SELECT mandant_id, nb_id, wup_id
      FROM dbp_view.v_wup_2
      WHERE nb_id IN (0)                            -- ausschliesslich Filialen!
      AND (dat_von > '1900-01-01' AND dat_eroeffnung > '1900-01-01')  -- Filterung wup_2 Sumpf
      AND umzugsfiliale_fg = 0                      -- ohne Umzugsfilialen (alt)
      AND WUP_ID = AKTUELL_WUP_ID   
   ) wp
   LEFT JOIN
   ( -- Techn. Platz
      SELECT mandant_id, techn_platz_id, wup_id, land_id
      FROM dbp_view.v_techn_platz_per_2
      WHERE techn_platz_ebene_id = 2 AND dat_bis = '9999-12-31'
   ) tpl
   ON wp.mandant_id = tpl.mandant_id
   AND wp.wup_id = tpl.wup_id
   LEFT JOIN
   ( -- G-Info
      SELECT
      mandant_id, techn_platz_id, SUM(CASE WHEN f_typ LIKE ('VKF-A%') THEN f_wert ELSE 0 END) AS fl_sbw, SUM(CASE WHEN f_typ IN ('VKF') AND f_id = '02.01' THEN f_wert ELSE 0 END) AS fl_vkf_kasse, SUM(CASE WHEN f_typ IN ('VKF') AND f_id = '02.10' THEN f_wert ELSE 0 END) AS fl_vkf_info, SUM(CASE WHEN f_typ IN ('VKF') AND f_id = '02.08' THEN f_wert ELSE 0 END) AS fl_vkf_roll, SUM(CASE WHEN f_typ IN ('VKF') AND f_id = '02.18' THEN f_wert ELSE 0 END) AS fl_vkf_getraenke, SUM(CASE WHEN f_typ IN ('VKF') AND f_id = '02.02' THEN f_wert ELSE 0 END) AS fl_vkf_sbw, SUM(CASE WHEN f_typ IN ('KOF') THEN f_wert ELSE 0 END) AS fl_kof, SUM(CASE WHEN f_typ IN ('KOF-E') THEN f_wert ELSE 0 END) AS fl_kofe, SUM(CASE WHEN f_typ IN ('SNF') THEN f_wert ELSE 0 END) AS fl_snf, SUM(CASE WHEN f_typ IN ('TF')  THEN f_wert ELSE 0 END) AS fl_tf, SUM(CASE WHEN f_typ IN ('VF_2')  THEN f_wert ELSE 0 END) AS fl_vf, SUM(CASE WHEN f_typ IN ('ANF') THEN f_wert ELSE 0 END) AS fl_anf, SUM(CASE WHEN f_typ IN ('UBF') THEN f_wert ELSE 0 END) AS fl_ubf, SUM(CASE WHEN f_typ IN ('BBF') AND f_id NOT IN ('PPL','PPE','PPB') THEN f_wert ELSE 0 END) AS fl_bbf, SUM(CASE WHEN f_typ IN ('BBF') AND  f_id = 'PPL' THEN f_wert ELSE 0 END) AS anz_ppl, SUM(CASE WHEN f_typ IN ('BBF') AND  f_id IN ('PPE','PPB') THEN f_wert ELSE 0 END) AS anz_ppx, SUM(CASE WHEN f_typ = ('VKF-A01') THEN a_wert ELSE 0 END) AS achs_01, SUM(CASE WHEN f_typ = ('VKF-A02') THEN a_wert ELSE 0 END) AS achs_02, SUM(CASE WHEN f_typ = ('VKF-A03') THEN a_wert ELSE 0 END) AS achs_03, SUM(CASE WHEN f_typ = ('VKF-A04') THEN a_wert ELSE 0 END) AS achs_04, SUM(CASE WHEN f_typ = ('VKF-A05') THEN a_wert ELSE 0 END) AS achs_05, SUM(CASE WHEN f_typ = ('VKF-A06') THEN a_wert ELSE 0 END) AS achs_06, SUM(CASE WHEN f_typ = ('VKF-A07') THEN a_wert ELSE 0 END) AS achs_07, MAX(CASE WHEN f_typ IN ('VKF') AND f_id = '02.18' AND f_wert > 0 THEN 1 ELSE 0 END) AS fg_getraenke, MAX(CASE WHEN f_typ IN ('SNF') AND f_id = '04.04' AND f_wert > 0 THEN 1 ELSE 0 END) AS fg_nacht, MAX(CASE
      WHEN f_id = 'ABF-F2.01' AND f_wert > 0 THEN 1
      WHEN f_id = 'ABF-F2.02' AND f_wert > 0 THEN 2
      WHEN f_id = 'ABF-F2.10' AND f_wert > 0 THEN 3
      WHEN f_id IN ('ABF-F2.06', 'ABF-F2.07') AND f_wert > 0 THEN 4
      ELSE 0 END) AS kz_baecker
      FROM
      ( -- G-Info Details
         SELECT
         s01.mandant_id, s01.techn_platz_id, s01.ginfo_flaeche_id     AS f_id, s01.ginfo_flaeche_typ_id AS f_typ, s01.ginfo_flaeche_brutto AS f_wert, s01.ginfo_achse_typ_id   AS a_typ, s01.ginfo_achse_wert     AS a_wert
         FROM dbp_view.v_ginfo_flaeche_per_2  s01
         WHERE s01.dat_bis = '9999-12-31'
      ) sub01
      GROUP BY 1,2
   ) ginf
   ON tpl.techn_platz_id = ginf.techn_platz_id
   LEFT JOIN
      ( -- Techn Platz Ebene 2 + Lookup/Sprachen
      SELECT
      s01.mandant_id, s01.techn_platz_id, s01.baujahr, s01.uebernahme_von, s01.ginfo_markt_typ, s02.ginfo_markt_typ_bez, s01.ginfo_konz_typ_kz, s03.ginfo_konz_typ_bez, s01.ginfo_bauform_id, s04.ginfo_bauform_bez, CASE WHEN s01.ginfo_bauform_id = 2 THEN 1 ELSE 0 END  AS parkdeck_fg, s01.tankstelle_vorh_fg, s01.anz_kassen, s01.anz_kassen_getraenkemarkt, s01.anz_zusatzkassen, s01.kassen_hardware, s01.kassen_software, s01.kassentisch_situation, s01.einkaufswagen_fabrikat, s01.einkaufswagen_typ, s01.einkaufswagen_griff, s01.einkaufswagen_rollen, s01.kbl_nl_bez, s01.tp_betreuer_kbl_name, s01.tp_arbeitsrecht_name  --NEU
      , s01.anz_parkpl, s01.anz_parkpl_behind, s01.anz_parkpl_eltern_kind, s01.parkpl_eben_kz, s01.parkpl_dach_kz, s01.parkpl_dach_mg_kz, s01.parkhaus_kz, s01.tiefgarage_eg_kz, s01.tiefgarage_mg_kz
      FROM dbp_view.v_techn_platz_ebene_2_per_2  s01
      LEFT JOIN dbp_view.v_l_ginfo_markt_typ_2  s02
      ON s01.ginfo_markt_typ = s02.ginfo_markt_typ
      LEFT JOIN dbp_view.v_l_ginfo_konz_typ_2 s03
      ON s01.ginfo_konz_typ_kz = s03.ginfo_konz_typ_kz
      LEFT JOIN dbp_view.v_ginfo_bauform_spr_zu_2 s04
      ON s01.ginfo_bauform_id = s04.ginfo_bauform_id AND s04.spr_id = 22

      WHERE s01.dat_bis = '9999-12-31'
   ) tpl2
   ON   tpl.techn_platz_id = tpl2.techn_platz_id
   ;