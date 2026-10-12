CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ITM_SUBITEMGROUP_2 as
   SELECT max_az.subitemgroup_id,	
   Max(max_az.mainitemgroup_id) AS mainitemgroup_id,	
   Max(max_az.itemgroup_int_id) AS itemgroup_int_id,	
   -1 AS statisticgroup_id	
  FROM (	
      /* Nur die Zuordnungen übernehmen, die am Häufigsten auftreten	
          Sollten Zuordnungen gleichhäufig auftreten, wird über die anschließende Gruppierung im äußersten Select per MAX()-Funktion willkürlich ein Datensatz bestimmt. Dieser Fall ist bisher nicht bekannt und stellt nur einen Sicherheitsmechanismus dar. */	
      SELECT az.subitemgroup_id,	
   az.mainitemgroup_id,	
   az.itemgroup_int_id,	
   az.anz_zuordnungen	
      FROM (	
          /* Alle aktuellen, distinkten Subitemgroup (SIG) - Mainitemgroup - Itemgroup_International (WGI) Zuordnungen bestimmen	
              Dazu die Anz. an Client-übergreifenden Zuordnungen  ermitteln. Dies ist notwendig, falls Sonderfälle bestehen, bei denen nicht für alle Clients die gleichen Zuordnungen bestehen.	
              Hierzu ist ein Sonderfall für die SIG 199 bekannt, bei der Client 4 eine_2 andere WGI als alle anderen Clients hat. Hierbei soll Client-übergreifend die WGI der Mehrheit angezeigt werden, damit pro SIG nur ein Satz zurückgegeben wird. */	
          SELECT DISTINCT TRY_CAST(s.src_subitemgrp_cd AS INTEGER) AS subitemgroup_id,	
   Coalesce(h.main_item_grp_cd, '-1') AS mainitemgroup_id,	
   TRY_CAST(h.item_grp_int_cd AS INTEGER) AS itemgroup_int_id,	
   Count(*) Over (PARTITION BY s.src_subitemgrp_cd, Coalesce(h.main_item_grp_cd, ''), h.item_grp_int_cd) AS anz_zuordnungen	
          FROM p_lew_core_ac.v_subitemgroup_2 AS s	
   INNER JOIN p_lew_core_ac.v_subitemgroup_hist_2 AS h	
   ON s.client_id = h.client_id	
   AND s.sub_item_grp_sid = h.sub_item_grp_sid	
WHERE CURRENT_DATE BETWEEN h.dwh_valid_from AND h.dwh_valid_to	
   ) AS az	
   QUALIFY az.anz_zuordnungen = Max(az.anz_zuordnungen) Over (PARTITION BY az.subitemgroup_id, az.mainitemgroup_id, az.itemgroup_int_id)	
) AS max_az	
GROUP BY max_az.subitemgroup_id	
;