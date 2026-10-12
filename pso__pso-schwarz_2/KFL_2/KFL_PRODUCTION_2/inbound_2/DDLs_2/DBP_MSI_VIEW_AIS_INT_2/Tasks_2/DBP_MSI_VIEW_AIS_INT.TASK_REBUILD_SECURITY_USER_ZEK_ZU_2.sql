CREATE OR REPLACE TASK DBP_MSI_VIEW_AIS_INT.TASK_REBUILD_SECURITY_USER_ZEK_ZU
  WAREHOUSE = WH_UTILITY_XS
	SCHEDULE = 'USING CRON 15 0 * * * Europe/Berlin'
	AS EXECUTE IMMEDIATE
  $$
  BEGIN

  -- Erstellen USER_ZEK_ZU_2
  -- Löschen der bestehenden Sätze in user_zek_zu_2
  DELETE FROM DBP_SECURITY.user_zek_zu_2;

  -- Kompletter Neuaufbau der Tabelle anhand der gepflegten Tabellen
  INSERT INTO DBP_SECURITY.user_zek_zu_2 (
      mandant_id
    , zek_id
    , user_id) 
  SELECT DISTINCT 
      mandant_id
    , zek_id
    , user_id
  FROM (

  -- Zek_2 und User sind direkt einer Gruppe_2 zugeordnet
      SELECT
          z.mandant_id
        , z.zek_id
        , u.user_id 
      FROM DBP_SECURITY.gruppe_user_zu_2 u
      INNER JOIN DBP_SECURITY.gruppe_zek_zu_2 z
      ON u.gruppe_id = z.gruppe_id
      AND u.dat_gueltig_bis >= current_date()
      UNION -- Zek_2 und User der ersten Gruppen-Gruppen Zuordnung
      SELECT
        z.mandant_id
      , z.zek_id
      , u.user_id
      FROM DBP_SECURITY.gruppe_gruppe_zu_2 g
      INNER JOIN DBP_SECURITY.gruppe_user_zu_2 u 

      /*User koennen jeder Ebene zugeordnet sein*/
      ON (g.gruppe_id          = u.gruppe_id AND u.dat_gueltig_bis >= current_date())
      OR (g.gruppe_parent_id = u.gruppe_id AND u.dat_gueltig_bis >= current_date())
      INNER JOIN DBP_SECURITY.gruppe_zek_zu_2 z

      /*zeks koennen nur auf Blattebene zugeordnet sein*/
      ON g.gruppe_id = z.gruppe_id 
      UNION -- Zek_2 und User der zweiten Gruppen-Gruppen Zuordnung
      SELECT
        z.mandant_id
      , z.zek_id
      , u.user_id
      FROM DBP_SECURITY.gruppe_gruppe_zu_2 g
      INNER JOIN DBP_SECURITY.gruppe_gruppe_zu_2 gg
      ON g.gruppe_id = gg.gruppe_parent_id
      INNER JOIN DBP_SECURITY.gruppe_user_zu_2 u 

      /*User koennen jeder Ebene zugeordnet sein*/
      ON (g.gruppe_id          = u.gruppe_id AND u.dat_gueltig_bis >= current_date())
      OR (g.gruppe_parent_id = u.gruppe_id AND u.dat_gueltig_bis >= current_date())
      OR (gg.gruppe_id       = u.gruppe_id AND u.dat_gueltig_bis >= current_date())
      INNER JOIN DBP_SECURITY.gruppe_zek_zu_2 z

      /*zeks koennen nur auf Blattebene zugeordnet sein*/
      ON gg.gruppe_id = z.gruppe_id 
  ) a;

    RETURN 'DBP_SECURITY.USER_ZEK_ZU_2 neu erstellt.' ;
  END;
  $$;