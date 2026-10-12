CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_GINFO_FLAECHE_2(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	TECHN_PLATZ_ID,
	LAND_ID,
	GINFO_FLAECHE_TYP_ID,
	GINFO_FLAECHE_ID,
	GINFO_FLAECHE_BRUTTO,
	GINFO_ACHSE_TYP_ID,
	GINFO_ACHSE_WERT,
	KJMO
) AS
   -- FAKT : G-Info Flaechen pro Filiale/Kalendermonat
   -- Historisch auf Kalendermonat gemappt (2 GJ)
   -- 2012KW46 : Initial
   -- 2024-06-20 muellerpatri : Filialumgliederung [P1760-DWH]

   SELECT
      v01.mandant_id
      , v01.nb_id
      , v01.wup_id
      , v02.techn_platz_id
      , v02.land_id
      , v03.ginfo_flaeche_typ_id
      , v03.ginfo_flaeche_id
      , v03.ginfo_flaeche_brutto
      , v03.ginfo_achse_typ_id
      , v03.ginfo_achse_wert
      , v03.kjmo
   FROM
   ( -- Marktstamm
      SELECT mandant_id, nb_id, wup_id
      FROM dbp_view.v_wup_2
      WHERE nb_id IN (0) AND dat_eroeffnung > '1900-01-01'
      AND aktuell_wup_id = wup_id
   ) v01

   JOIN
   ( -- Techn. Platz
      SELECT mandant_id, techn_platz_id, wup_id, land_id
      FROM dbp_view.v_techn_platz_per_2
      WHERE techn_platz_ebene_id = 2 AND dat_bis = '9999-12-31'
   ) v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.wup_id = v02.wup_id

   JOIN
   ( -- G-Info
      SELECT
         s01.mandant_id
         , s01.techn_platz_id
         , s01.ginfo_flaeche_typ_id
         , s01.ginfo_flaeche_id
         , s01.ginfo_flaeche_brutto
         , s01.ginfo_achse_typ_id
         , s01.ginfo_achse_wert
         , s02.kjmo
      FROM dbp_view.v_ginfo_flaeche_per_2  s01

      JOIN
      ( -- letzter Tag_2 im Monat_2 / 2 GJ
         SELECT kjmo, max_dat
         FROM dbp_view.v_monat_2
         WHERE akt_gj IN (-1, 0)
      ) s02
      ON s02.max_dat BETWEEN s01.dat_von AND s01.dat_bis
   ) v03
   ON v02.techn_platz_id = v03.techn_platz_id;