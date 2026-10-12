CREATE OR REPLACE TASK DBP_MSI_VIEW_LBS.TASK_REBUILD_SECURITY_LBS_USER_ZEK_ZU
  WAREHOUSE = WH_UTILITY_XS
	SCHEDULE = 'USING CRON 15 0 * * * Europe/Berlin'
	AS EXECUTE IMMEDIATE
  $$
  BEGIN

 // Erstellen USER_ZEK_ZU
 // Löschen der bestehenden Sätze in user_zek_zu
 DELETE FROM DBP_SECURITY.lbs_user_zek_zu;
 
 -- Kompletter Neuaufbau der Tabelle anhand der gepflegten Tabellen
 INSERT INTO DBP_SECURITY.lbs_user_zek_zu (
     mandant_id
   , zek_id
   , user_id) 
 SELECT DISTINCT 
     mandant_id
   , zek_id
   , user_id
 FROM (

 -- Zek und User sind direkt einer Gruppe zugeordnet
    SELECT
        z.mandant_id
      , z.zek_id
      , u.user_id 
    FROM DBP_SECURITY.lbs_gruppe_user_zu u
    INNER JOIN DBP_SECURITY.lbs_gruppe_zek_zu z
    ON u.lbs_gruppe_id = z.lbs_gruppe_id
    AND u.dat_gueltig_bis >= current_date()
    UNION -- Zek und User der ersten Gruppen-Gruppen Zuordnung
    SELECT
       z.mandant_id
    , z.zek_id
    , u.user_id
    FROM DBP_SECURITY.lbs_gruppe_gruppe_zu g
    INNER JOIN DBP_SECURITY.lbs_gruppe_user_zu u 

    /*User koennen jeder Ebene zugeordnet sein*/
    ON (g.lbs_gruppe_id          = u.lbs_gruppe_id AND u.dat_gueltig_bis >= current_date())
    OR (g.lbs_gruppe_parent_id = u.lbs_gruppe_id AND u.dat_gueltig_bis >= current_date())
    INNER JOIN DBP_SECURITY.lbs_gruppe_zek_zu z

    /*zeks koennen nur auf Blattebene zugeordnet sein*/
    ON g.lbs_gruppe_id = z.lbs_gruppe_id 
    UNION -- Zek und User der zweiten Gruppen-Gruppen Zuordnung
    SELECT
       z.mandant_id
    , z.zek_id
    , u.user_id
    FROM DBP_SECURITY.lbs_gruppe_gruppe_zu g
    INNER JOIN DBP_SECURITY.lbs_gruppe_gruppe_zu gg
    ON g.lbs_gruppe_id = gg.lbs_gruppe_parent_id
    INNER JOIN DBP_SECURITY.lbs_gruppe_user_zu u 

    /*User koennen jeder Ebene zugeordnet sein*/
    ON (g.lbs_gruppe_id          = u.lbs_gruppe_id AND u.dat_gueltig_bis >= current_date())
    OR (g.lbs_gruppe_parent_id = u.lbs_gruppe_id AND u.dat_gueltig_bis >= current_date())
    OR (gg.lbs_gruppe_id       = u.lbs_gruppe_id AND u.dat_gueltig_bis >= current_date())
    INNER JOIN DBP_SECURITY.lbs_gruppe_zek_zu z

    /*zeks koennen nur auf Blattebene zugeordnet sein*/
    ON gg.lbs_gruppe_id = z.lbs_gruppe_id 
 ) a;

    RETURN 'DBP_SECURITY.LBS_USER_ZEK_ZU neu erstellt.' ;
  END;
  $$;