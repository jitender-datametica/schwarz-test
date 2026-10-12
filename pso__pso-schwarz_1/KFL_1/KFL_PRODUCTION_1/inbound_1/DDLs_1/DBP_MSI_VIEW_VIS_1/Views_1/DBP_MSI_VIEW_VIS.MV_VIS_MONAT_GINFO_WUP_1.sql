CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_GINFO_WUP_1(
      MANDANT_ID,
      NB_ID,
      WUP_ID,
      TECHN_PLATZ_ID,
      LAND_ID,
      KJMO,
      VK_FLAECHE,
      KONZ_FLAECHE,
      BETRIEB_FLAECHE,
      SBW_FLAECHE,
      ALLG_FLAECHE,
      NEBEN_FLAECHE,
      AUSSEN_FLAECHE,
      OBJEKT_FLAECHE,
      ANZ_PARKPL,
      ACHS_01,
      ACHS_02,
      ACHS_03,
      ACHS_04,
      ACHS_05,
      ACHS_06,
      ACHS_07,
      FLAECH_01,
      FLAECH_02,
      FLAECH_03,
      FLAECH_04,
      FLAECH_05,
      FLAECH_06,
      FLAECH_07,
      GETRAENKEMARKT_FG,
      NACHTANLIEF_FG,
      BAECKER_KZ,
      BAECKER_BEZ
)
AS
   -- FAKT : Flaechen summiert pro Filiale/Kalendermonat
   -- Historisch auf Kalendermonat gemappt (2 GJ)
   -- 2012KW46 : Initial
   -- 2015KW16 : Erweiterung auf 3 GJ (EIS)
   -- 2017.0307 : Erweiterung auf 4 GJ (SDL)
   -- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]

   SELECT
      v01.mandant_id
      , v01.nb_id
      , v01.wup_id
      , v02.techn_platz_id
      , v02.land_id
      , COALESCE(v03.kjmo, 0) AS kjmo
      , COALESCE(fl_vkf_kasse + fl_vkf_info + fl_vkf_roll+ fl_vkf_getraenke + fl_vkf_sbw, 0) AS vk_flaeche
      , COALESCE(fl_kof + fl_kofe, 0)                                                        AS konz_flaeche
      , COALESCE(vk_flaeche + konz_flaeche + (fl_vf) + (fl_snf + fl_tf), 0)                AS betrieb_flaeche
      , (fl_sbw)                                                                             AS sbw_flaeche
      , (fl_vf)                                                                              AS allg_flaeche
      , (fl_snf + fl_tf)                                                                     AS neben_flaeche
      , (fl_anf + fl_ubf + fl_bbf)                                                           AS aussen_flaeche
      , (betrieb_flaeche + aussen_flaeche)                                                   AS objekt_flaeche
      , (anz_ppl + anz_ppx)                                                                  AS anz_parkpl
      , achs_01
      , achs_02
      , achs_03
      , achs_04
      , achs_05
      , achs_06
      , achs_07
      , flaech_01
      , flaech_02
      , flaech_03
      , flaech_04
      , flaech_05
      , flaech_06
      , flaech_07
      , COALESCE (fg_getraenke, -1)                                               AS getraenkemarkt_fg
      , COALESCE (fg_nacht, -1)                                                   AS nachtanlief_fg
      , COALESCE (kz_baecker, 0)                                                  AS baecker_kz
      , CASE
        WHEN baecker_kz = 1 THEN 'Discountbäckerei'
        WHEN baecker_kz = 2 THEN 'Frischebäcker'
        WHEN baecker_kz = 3 THEN 'Backshop Typ 3'
        WHEN baecker_kz = 4 THEN 'Frischebäcker Bedienung'
        WHEN baecker_kz = 0 THEN '-'
        ELSE '' END                                                               AS baecker_bez

   FROM
   ( -- Marktstamm
      SELECT mandant_id, nb_id, wup_id, dat_eroeffnung, verkaufsflaeche
      FROM dbp_view.v_wup_1
      WHERE nb_id IN (0) AND dat_eroeffnung > '1900-01-01'
      AND wup_id = aktuell_wup_id
   ) v01
   LEFT JOIN
   ( -- Techn. Platz
      SELECT mandant_id, techn_platz_id, wup_id, land_id
      FROM dbp_view.v_techn_platz_per_1
      WHERE techn_platz_ebene_id = 2 AND dat_bis = '9999-12-31'
   ) v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.wup_id = v02.wup_id
   LEFT JOIN
   ( -- G-Info
      SELECT
        mandant_id
        , techn_platz_id
        , kjmo
        , SUM(CASE WHEN f_typ LIKE ('VKF-A%') THEN f_wert ELSE 0 END) AS fl_sbw
        , SUM(CASE WHEN f_typ IN ('VKF') AND f_id = '02.01' THEN f_wert ELSE 0 END) AS fl_vkf_kasse
        , SUM(CASE WHEN f_typ IN ('VKF') AND f_id = '02.10' THEN f_wert ELSE 0 END) AS fl_vkf_info
        , SUM(CASE WHEN f_typ IN ('VKF') AND f_id = '02.08' THEN f_wert ELSE 0 END) AS fl_vkf_roll
        , SUM(CASE WHEN f_typ IN ('VKF') AND f_id = '02.18' THEN f_wert ELSE 0 END) AS fl_vkf_getraenke
        , SUM(CASE WHEN f_typ IN ('VKF') AND f_id = '02.02' THEN f_wert ELSE 0 END) AS fl_vkf_sbw
        , SUM(CASE WHEN f_typ IN ('KOF') THEN f_wert ELSE 0 END)   AS fl_kof
        , SUM(CASE WHEN f_typ IN ('KOF-E') THEN f_wert ELSE 0 END) AS fl_kofe
        , SUM(CASE WHEN f_typ IN ('SNF') THEN f_wert ELSE 0 END) AS fl_snf
        , SUM(CASE WHEN f_typ IN ('TF')  THEN f_wert ELSE 0 END) AS fl_tf
        , SUM(CASE WHEN f_typ IN ('VF_1')  THEN f_wert ELSE 0 END) AS fl_vf
        , SUM(CASE WHEN f_typ IN ('ANF') THEN f_wert ELSE 0 END) AS fl_anf
        , SUM(CASE WHEN f_typ IN ('UBF') THEN f_wert ELSE 0 END) AS fl_ubf
        , SUM(CASE WHEN f_typ IN ('BBF') AND f_id NOT IN ('PPL','PPE','PPB') THEN f_wert ELSE 0 END) AS fl_bbf
        , SUM(CASE WHEN f_typ IN ('BBF') AND  f_id = 'PPL' THEN f_wert ELSE 0 END) AS anz_ppl
        , SUM(CASE WHEN f_typ IN ('BBF') AND  f_id IN ('PPE','PPB') THEN f_wert ELSE 0 END) AS anz_ppx
        , SUM(CASE WHEN f_typ = ('VKF-A01') THEN a_wert ELSE 0 END) AS achs_01
        , SUM(CASE WHEN f_typ = ('VKF-A02') THEN a_wert ELSE 0 END) AS achs_02
        , SUM(CASE WHEN f_typ = ('VKF-A03') THEN a_wert ELSE 0 END) AS achs_03
        , SUM(CASE WHEN f_typ = ('VKF-A04') THEN a_wert ELSE 0 END) AS achs_04
        , SUM(CASE WHEN f_typ = ('VKF-A05') THEN a_wert ELSE 0 END) AS achs_05
        , SUM(CASE WHEN f_typ = ('VKF-A06') THEN a_wert ELSE 0 END) AS achs_06
        , SUM(CASE WHEN f_typ = ('VKF-A07') THEN a_wert ELSE 0 END) AS achs_07
        , SUM(CASE WHEN f_typ = ('VKF-A01') THEN f_wert ELSE 0 END) AS flaech_01
        , SUM(CASE WHEN f_typ = ('VKF-A02') THEN f_wert ELSE 0 END) AS flaech_02
        , SUM(CASE WHEN f_typ = ('VKF-A03') THEN f_wert ELSE 0 END) AS flaech_03
        , SUM(CASE WHEN f_typ = ('VKF-A04') THEN f_wert ELSE 0 END) AS flaech_04
        , SUM(CASE WHEN f_typ = ('VKF-A05') THEN f_wert ELSE 0 END) AS flaech_05
        , SUM(CASE WHEN f_typ = ('VKF-A06') THEN f_wert ELSE 0 END) AS flaech_06
        , SUM(CASE WHEN f_typ = ('VKF-A07') THEN f_wert ELSE 0 END) AS flaech_07
        , MAX(CASE WHEN f_typ IN ('VKF') AND f_id = '02.18' AND f_wert > 0 THEN 1 ELSE 0 END) AS fg_getraenke
        , MAX(CASE WHEN f_typ IN ('SNF') AND f_id = '04.04' AND f_wert > 0 THEN 1 ELSE 0 END) AS fg_nacht
        , MAX(CASE WHEN f_id = 'ABF-F2.01' AND f_wert > 0 THEN 1 -- Discountbäckerei
              WHEN f_id = 'ABF-F2.02' AND f_wert > 0 THEN 2 -- Frischebäcker
              WHEN f_id = 'ABF-F2.10' AND f_wert > 0 THEN 3 -- Backshop Typ 3
              WHEN f_id IN ('ABF-F2.06', 'ABF-F2.07') AND f_wert > 0 THEN 4 -- Frischebäcker Bedienung
              ELSE 0 END) AS kz_baecker
      FROM ( -- G-Info Details
      SELECT
          s01.mandant_id
          , s01.techn_platz_id
          , s01.ginfo_flaeche_id     AS f_id
          , s01.ginfo_flaeche_typ_id AS f_typ
          , s01.ginfo_flaeche_brutto AS f_wert
          , s01.ginfo_achse_typ_id   AS a_typ
          , s01.ginfo_achse_wert     AS a_wert
          , s02.kjmo
      FROM dbp_view.v_ginfo_flaeche_per_1  s01

      JOIN
      ( -- Projektion letzter Tag_1 des Monats fuer 3 GJ
          SELECT kjmo, max_dat
          FROM dbp_view.v_monat_1
          WHERE akt_gj IN (-3, -2, -1, 0)
      ) s02
      ON s02.max_dat BETWEEN s01.dat_von AND s01.dat_bis
      ) sub01
      GROUP BY 1,2,3
   ) v03
   ON v02.techn_platz_id = v03.techn_platz_id
   ;