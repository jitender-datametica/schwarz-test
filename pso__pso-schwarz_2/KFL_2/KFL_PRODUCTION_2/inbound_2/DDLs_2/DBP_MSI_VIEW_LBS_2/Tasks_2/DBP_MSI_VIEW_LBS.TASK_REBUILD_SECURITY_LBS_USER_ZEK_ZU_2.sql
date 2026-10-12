CREATE OR REPLACE TASK DBP_MSI_VIEW_LBS.TASK_REBUILD_SECURITY_LBS_USER_ZEK_ZU
  WAREHOUSE = WH_UTILITY_XS
	SCHEDULE = 'USING CRON 15 0 * * * Europe/Berlin'
	AS EXECUTE IMMEDIATE
  $$
  BEGIN

 // Erstellen USER_ZEK_ZU_2
 // Löschen der bestehenden Sätze in user_zek_zu_2
 DELETE FROM DBP_SECURITY.lbs_user_zek_zu_2;
 
 -- Kompletter Neuaufbau der Tabelle anhand der gepflegten Tabellen
 INSERT INTO DBP_SECURITY.lbs_user_zek_zu_2 (
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
    FROM DBP_SECURITY.lbs_gruppe_user_zu_2 u
    INNER JOIN DBP_SECURITY.lbs_gruppe_zek_zu_2 z
    ON u.lbs_gruppe_id = z.lbs_gruppe_id
    AND u.dat_gueltig_bis >= current_date()
    UNION -- Zek_2 und User der ersten Gruppen-Gruppen Zuordnung
    SELECT
       z.mandant_id
    , z.zek_id
    , u.user_id
    FROM DBP_SECURITY.lbs_gruppe_gruppe_zu_2 g
    INNER JOIN DBP_SECURITY.lbs_gruppe_user_zu_2 u 

    /*User koennen jeder Ebene zugeordnet sein*/
    ON (g.lbs_gruppe_id          = u.lbs_gruppe_id AND u.dat_gueltig_bis >= current_date())
    OR (g.lbs_gruppe_parent_id = u.lbs_gruppe_id AND u.dat_gueltig_bis >= current_date())
    INNER JOIN DBP_SECURITY.lbs_gruppe_zek_zu_2 z

    /*zeks koennen nur auf Blattebene zugeordnet sein*/
    ON g.lbs_gruppe_id = z.lbs_gruppe_id 
    UNION -- Zek_2 und User der zweiten Gruppen-Gruppen Zuordnung
    SELECT
       z.mandant_id
    , z.zek_id
    , u.user_id
    FROM DBP_SECURITY.lbs_gruppe_gruppe_zu_2 g
    INNER JOIN DBP_SECURITY.lbs_gruppe_gruppe_zu_2 gg
    ON g.lbs_gruppe_id = gg.lbs_gruppe_parent_id
    INNER JOIN DBP_SECURITY.lbs_gruppe_user_zu_2 u 

    /*User koennen jeder Ebene zugeordnet sein*/
    ON (g.lbs_gruppe_id          = u.lbs_gruppe_id AND u.dat_gueltig_bis >= current_date())
    OR (g.lbs_gruppe_parent_id = u.lbs_gruppe_id AND u.dat_gueltig_bis >= current_date())
    OR (gg.lbs_gruppe_id       = u.lbs_gruppe_id AND u.dat_gueltig_bis >= current_date())
    INNER JOIN DBP_SECURITY.lbs_gruppe_zek_zu_2 z

    /*zeks koennen nur auf Blattebene zugeordnet sein*/
    ON gg.lbs_gruppe_id = z.lbs_gruppe_id 
 ) a;

    RETURN 'DBP_SECURITY.LBS_USER_ZEK_ZU_2 neu erstellt.' ;
  END;
  $$;