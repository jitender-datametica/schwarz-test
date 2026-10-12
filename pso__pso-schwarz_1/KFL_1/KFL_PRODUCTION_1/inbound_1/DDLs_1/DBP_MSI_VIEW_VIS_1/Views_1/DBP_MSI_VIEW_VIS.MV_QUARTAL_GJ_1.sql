CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_QUARTAL_GJ_1
AS
   -- ZEIT_1 LOOKUP Quartal  im Geschäftsjahr
   -- Zeitraum 4 GJ
   -- 20120504 Update, Basis Monat_1

   SELECT
   gjqu,
   akt_gjqu,
   akt_gjqu_komplett,
   gj,
   akt_gj,
   akt_gj_komplett,
   MIN(min_dat /*Warning, Format 'DD.MM.YY' removed, semantic information not found.*/) || ' - ' || MAX(max_dat /*Warning, Format 'DD.MM.YY' removed, semantic information not found.*/)::VARCHAR (20)  AS gjqu_bez,
   MAX(TRIM(gj)) || ' / ' || CASE WHEN MOD( gjqu, 4) = 1 THEN 'I' WHEN MOD( gjqu, 4) = 2 THEN 'II' WHEN MOD( gjqu, 4) = 3 THEN 'III' ELSE 'IV' END::VARCHAR(10) AS gjqu_kbez

   FROM dbp_view.v_monat_1  v01

   WHERE akt_gj BETWEEN -10 AND 1

   GROUP BY
   gjqu
   , akt_gjqu
   , akt_gjqu_komplett
   , gj
   , akt_gj
   , akt_gj_komplett;