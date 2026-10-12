CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_PEP_MA_1
AS
   -- LOOKUP Mitarbeiter (HL_1)
   -- Basis: Stammdaten Mitarbeiter
   -- 2013-03-18 : INITIAL

   SELECT
   peper.idpersonal  AS pep_ma_id, pep.pep_ma_name, pep.pep_ma_vorname, pep.geschlecht_id, CASE
   WHEN pep.geschlecht_id = 1 THEN 'Herr'
   WHEN pep.geschlecht_id = 2 THEN 'Frau'
   ELSE ' - '
   END AS pep_ma_anrede, peper.pep_ma_funktion_id, CASE
   WHEN pep_ma_funktion_id = 2206 THEN 'HL_1'
   WHEN pep_ma_funktion_id = 2215 THEN 'stv. HML'
   WHEN pep_ma_funktion_id = 2279 THEN 'CL'
   WHEN pep_ma_funktion_id = 2280 THEN 'HML'
   WHEN pep_ma_funktion_id = 2309 THEN 'RL'
   ELSE ' - '
   END::VARCHAR(20) AS pep_ma_funktion, peper.idabteilungen AS pep_abt_id, peper.idmastatus  AS pep_ma_status_id, peper.stunden_woche as pep_ma_std_woche, peper.stunden_monat as pep_ma_std_monat, peper.dat_von, peper.dat_bis, pep.dat_austritt
   FROM dbp_view.v_pep_personal_per_1 peper

   JOIN dbp_view.v_pep_personal_1 pep
   ON peper.idpersonal = pep.idpersonal

   JOIN dbp_view.v_tag_1 zeit_1
   ON zeit.dat > '2014-02-28'         -- fixer Start 01.03.
   AND zeit.akt_tag <= - 1       -- Default Vor-Vortag
   AND zeit.dat BETWEEN peper.dat_von AND peper.dat_bis
   AND (zeit.dat < pep.dat_austritt OR pep.dat_austritt IS NULL)

   WHERE peper.idabteilungen NOT IN (32, 33) -- Ausschluss: nicht verfuegbar, ausgeschieden
   AND peper.pep_ma_funktion_id IS NOT NULL -- Nur gelieferte Funktionen: HL_1, CL etc.
   ;