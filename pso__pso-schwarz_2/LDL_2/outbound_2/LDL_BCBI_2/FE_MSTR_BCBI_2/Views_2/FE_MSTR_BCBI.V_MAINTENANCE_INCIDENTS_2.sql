CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_maintenance_incidents_2 AS SELECT id,
 info_type,
 subject,
 current_status,
 affected_countries,
 DATE(affected_day) AS affected_day,
 created_on,
 changed_on,
 CONCAT('https://schwarzit.sharepoint.com/teams/Spielwiese/Lists/Strungs%20und%20Wartungsinformationen/DispForm.aspx?ID='
  , id) AS url,
 CONCAT('<a href="', CONCAT('https://schwarzit.sharepoint.com/teams/Spielwiese/Lists/Strungs%20und%20Wartungsinformationen/DispForm.aspx?ID='
   , id), '" target="_blank" >', 'Cosmic Link', '</a>') AS link_html
FROM ldl_bcbi_fe_mstr_bcbi.t_maintenance_incidents_2;